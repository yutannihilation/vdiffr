
create_mock_pkg <- function(pkg = "mock-pkg") {
  dir <- tempfile()

  dir.create(dir, recursive = TRUE)
  file.copy(pkg, dir, recursive = TRUE)

  # Enable `R CMD check` logging
  from <- file.path(dir, pkg)
  to <- paste0(from, ".Rcheck")
  file.rename(from, to)

  to
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
  if (old_freetype()) {
    skip("FreeType too old for vdiffr")
  }
}

is_checking <- function() {
  nzchar(Sys.getenv("R_TESTS"))
}


stack <- rev(rlang::ctxt_stack())

is_load_all <- function(frame) {
  if (rlang::is_lang(frame$expr, "load_all")) {
    identical(frame$fn, devtools::load_all)
  } else {
    FALSE
  }
}

on_load <- purrr::some(stack, is_load_all)

if (!old_freetype() && !on_load) {
  mock_pkg_dir <- create_mock_pkg()
  mock_test_dir <- file.path(mock_pkg_dir, "tests", "testthat")

  test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
  mock_cases_outputs <- purrr::quietly(purrr::safely(collect_cases))(mock_pkg_dir)

  quietly_out <- mock_cases_outputs$result
  if (inherits(quietly_out$error, "condition")) {
    cat("While collecting testing cases:\n")
    stop(quietly_out$error)
  }

  mock_cases <- quietly_out$result
  validate_cases(mock_cases)
}
