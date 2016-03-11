
#' @export
manage_cases <- function(package = ".", figs_path = "tests/figs/") {
  package <- devtools::as.package(package)
  figs_path <- maybe_concat_paths(package$path, figs_path)
  cases <- collect_cases(package)

  shiny::runApp(list(
    ui = vdiffrUi(cases),
    server = vdiffrServer(cases)
  ))
}

cases <- function(x, path, deps = NULL) {
  structure(x,
    class = "cases",
    path = path,
    deps = deps
  )
}

is_cases <- function(case) inherits(case, "cases")

c.cases <- function(..., recursive = FALSE) {
  cases(NextMethod(), attr(..1, "path"), attr(..1, "deps"))
}

`[.cases` <- function(x, i) {
  cases(NextMethod(), attr(x, "path"), attr(x, "deps"))
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

#' @export
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
validate_cases <- function(cases = collect_new_cases(),
                           figs_path = "tests/figs") {
  stopifnot(is_cases(cases))
  figs_path <- maybe_concat_paths(attr(cases, "path"), figs_path)

  if (length(cases)) {
    walk(attr(cases, "deps"), update_dependency,
      path = attr(cases, "path"))
  }

  walk(cases, function(case) {
    svg <- case$testcase

    fig_name <- paste0(case$name, ".svg")
    fig_path <- file.path(figs_path, fig_name)

    write_file(svg, fig_path)
  })
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

case_mismatch <- function(testcase, expected, name = NULL) {
  case <- list(
    testcase = normalizePath(testcase),
    expected = normalizePath(expected),
    name = name
  )

  structure(case, class = c("case_mismatch", "case"))
}

case_new <- function(testcase, name = NULL) {
  testcase <- normalizePath(testcase)
  case <- list(
    testcase = testcase,
    expected = testcase,
    name = name
  )

  structure(case, class = c("case_new", "case"))
}

is_case <- function(case) inherits(case, "case")
is_case_mismatch <- function(case) inherits(case, "case_mismatch")
is_case_new <- function(case) inherits(case, "case_new")
