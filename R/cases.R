#' Collect and validate cases
#'
#' These functions are mainly intended for internal use by
#' \code{\link{manage_cases}()}. They are useful to programmatically
#' collect and validate cases.
#'
#' @inheritParams manage_cases
#' @param cases A \code{cases} object returned by one of the
#'   collecting functions.
#' @seealso \code{\link{manage_cases}()}
#' @export
#' @examples
#' \dontrun{
#' new_cases <- collect_new_cases()
#' validate_cases(new_cases)
#' }
collect_cases <- function(package = ".", filter = NULL) {
  on.exit(set_active_collecter(NULL))

  message("Running testthat to collect visual cases\n")
  package <- devtools::as.package(package)
  reporter <- vdiffrReporter$new(package$path)
  devtools::test(package, filter = filter, reporter = reporter)

  cases <- active_collecter()$get_cases()

  cases_names <- map_chr(cases, "name")
  is_duplicated <- duplicated(cases_names)
  if (any(is_duplicated)) {
    warning(call. = FALSE,
      "Duplicated expectations: ",
      paste(cases_names[is_duplicated], collapse = ", "))
  }

  cases
}

#' @rdname collect_cases
#' @export
collect_new_cases <- function(package = ".") {
  filter_cases(collect_cases(package), "new")
}

#' @rdname collect_cases
#' @export
collect_mismatched_cases <- function(package = ".") {
  filter_cases(collect_cases(package), "mismatched")
}

#' @rdname collect_cases
#' @export
validate_cases <- function(cases = collect_new_cases()) {
  stopifnot(is_cases(cases))
  pkg_path <- attr(cases, "pkg_path")
  if (is.null(pkg_path)) {
    stop("Internal error: Package path is missing", call. = FALSE)
  }

  write_deps_note(cases, pkg_path)
  walk(cases, update_case, pkg_path)
}

write_deps_note <- function(cases, pkg_path) {
  deps <- attr(cases, "deps")
  versions <- map_chr(deps, package_version)
  deps <- map2_chr(deps, versions, paste, sep = ": ")

  deps_note_file <- file.path(pkg_path, "tests", "figs", "deps.txt")
  writeLines(deps, deps_note_file)
}

update_case <- function(case, pkg_path) {
  path <- file.path(pkg_path, "tests", "figs", case$path)
  ensure_directories(dirname(path))
  file.copy(case$testcase, path, overwrite = TRUE)
}

cases <- function(x, pkg_path, deps = NULL) {
  structure(x,
    class = "cases",
    pkg_path = pkg_path,
    deps = deps
  )
}

is_cases <- function(case) inherits(case, "cases")

c.cases <- function(..., recursive = FALSE) {
  cases(NextMethod(), attr(..1, "pkg_path"), attr(..1, "deps"))
}

`[.cases` <- function(x, i) {
  cases(NextMethod(), attr(x, "pkg_path"), attr(x, "deps"))
}

#' @export
print.cases <- function(x, ...) {
  cat(sprintf("<cases>: %s\n", length(x)))

  mismatched <- filter_cases(x, "mismatched")
  if (length(mismatched) > 0) {
    cat("\nMismatched:\n")
    print_cases_names(mismatched)
  }

  new <- filter_cases(x, "new")
  if (length(new) > 0) {
    cat("\nNew:\n")
    print_cases_names(new)
  }

  invisible(cases)
}

print_cases_names <- function(cases) {
  names <- map_chr(names(cases), function(name) paste0(" - ", name))
  cat(paste(names, collapse = "\n"), "\n")
}

filter_cases <- function(cases, type) {
  filtered <- switch(type,
    new = keep(cases, is_case_new),
    mismatched = keep(cases, is_case_mismatch),
    cases
  )

  # Restore attributes discarded by purrr::keep()
  cases(filtered, attr(cases, "pkg_path"), attr(cases, "deps"))
}

case_mismatch <- function(name, path, testcase) {
  case <- list(
    name = name,
    path = path,
    testcase = testcase
  )
  structure(case, class = c("case_mismatch", "case"))
}

case_new <- function(name, path, testcase) {
  case <- list(
    name = name,
    path = path,
    testcase = testcase
  )
  structure(case, class = c("case_new", "case"))
}

is_case <- function(case) inherits(case, "case")
is_case_mismatch <- function(case) inherits(case, "case_mismatch")
is_case_new <- function(case) inherits(case, "case_new")
