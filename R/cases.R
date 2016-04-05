
#' @export
manage_cases <- function(package = ".") {
  package <- devtools::as.package(package)
  cases <- collect_cases(package)

  shiny::runApp(list(
    ui = vdiffrUi(cases),
    server = vdiffrServer(cases)
  ))
}

collect_cases <- function(package = ".") {
  on.exit(set_active_collecter(NULL))

  package <- devtools::as.package(package)
  reporter <- vdiffrReporter$new(package$path)
  devtools::test(package, reporter = reporter)

  active_collecter()$get_cases()
}

#' @export
collect_new_cases <- function(package = ".") {
  filter_cases(collect_cases(package), "new")
}

#' @export
collect_mismatched_cases <- function(package = ".") {
  filter_cases(collect_cases(package), "mismatched")
}

#' @export
validate_cases <- function(cases = collect_new_cases()) {
  stopifnot(is_cases(cases))
  pkg_path <- attr(cases, "pkg_path")

  walk(attr(cases, "deps"), update_dependency, pkg_path)
  walk(cases, update_case, pkg_path)
}

update_case <- function(case, pkg_path) {
  path <- file.path(pkg_path, "tests", case$path)
  validate_path(dirname(path))
  write_file(case$testcase, path)
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
  cases(filtered, attr(cases, "path"), attr(cases, "deps"))
}

case_mismatch <- function(testcase, expected, name, path) {
  case <- list(
    testcase = normalizePath(testcase),
    expected = normalizePath(expected),
    name = name,
    path = path
  )

  structure(case, class = c("case_mismatch", "case"))
}

case_new <- function(testcase, name, path) {
  testcase <- normalizePath(testcase)
  case <- list(
    testcase = testcase,
    expected = testcase,
    name = name,
    path = path
  )

  structure(case, class = c("case_new", "case"))
}

is_case <- function(case) inherits(case, "case")
is_case_mismatch <- function(case) inherits(case, "case_mismatch")
is_case_new <- function(case) inherits(case, "case_new")
