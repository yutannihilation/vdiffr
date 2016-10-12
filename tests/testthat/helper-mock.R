
create_mock_pkg <- function(pkg = "mock-pkg") {
  dir <- tempfile()
  dir.create(dir)

  file.copy(paste0(pkg, "/"), dir, recursive = TRUE)
  file.path(dir, pkg)
}

mock_pkg_dir <- create_mock_pkg()
mock_test_dir <- file.path(mock_pkg_dir, "tests", "testthat")

test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
cases_outputs <- purrr::quietly(vdiffr::collect_cases)(mock_pkg_dir)
cases <- cases_outputs$result

vdiffr::validate_cases(cases)
