
create_mock_pkg <- function(pkg = "mock-pkg") {
  dir <- tempfile()
  dir.create(dir)

  file.copy(paste0(pkg, "/"), dir, recursive = TRUE)
  file.path(dir, pkg)
}

subset_results <- function(results, file, test) {
  subset <- purrr::keep(results, function(result) {
    result$file == file && result$test == test
  })
  subset[[1]]$results
}

on_load <- function() {
  identical(Sys.getenv("DEVTOOLS_LOAD"), "true")
}
skip_old_freetype <- function() {
  if (gdtools::version_freetype() < "2.6.0" ) {
    skip("FreeType too old for vdiffr")
  }
}

if (gdtools::version_freetype() >= "2.6.0" && !on_load()) {
  mock_pkg_dir <- create_mock_pkg()
  mock_test_dir <- file.path(mock_pkg_dir, "tests", "testthat")

  test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
  mock_cases_outputs <- purrr::quietly(purrr::safely(collect_cases))(mock_pkg_dir)
  mock_cases <- mock_cases_outputs$result$result

  validate_cases(mock_cases)
}
