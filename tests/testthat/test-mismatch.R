context("mismatch")

test_that("failures are pushed to log file", {
  if (!is_checking()) {
    return("Skipping R CMD check tests")
  }

  log <- readLines(file.path(mock_pkg_dir, "tests", "vdiffr.Rout.fail"))

  n_logged <- length(grep(">> Failed doppelganger:", log))
  n_failures <- length(keep(mock_cases, inherits, "mismatch_case"))
  expect_identical(n_logged, n_failures)
})

test_that("Verbose outputs svg files", {
  output <- mock_cases_outputs$output
  expect_true(grepl(">> Failed doppelganger: myplot", output))
})
