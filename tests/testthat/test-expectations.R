
context("Expectations")

test_that("Mismatches fail", {
  failed_result <- subset_results(test_results, "test-failed.R", "New plots work are collected")[[1]]
  expect_match(failed_result$message, "Figures don't match: myplot.svg\n")

  class <- class(failed_result)[[1]]
  expect_equal(class, "expectation_failure")
})

test_that("Duplicated expectations issue warning", {
  expect_true(any(grepl("Duplicated expectations: myplot", mock_cases_outputs$warnings)))
})

test_that("Doppelgangers pass", {
  ggplot_result <- subset_results(test_results, "test-passed.R", "ggplot doppelgangers pass")[[1]]
  base_result <- subset_results(test_results, "test-passed.R", "base doppelgangers pass")[[1]]
  expect_is(ggplot_result, "expectation_success")
  expect_is(base_result, "expectation_success")
})

test_that("skip mismatches if vdiffr is stale", {
  mock_dir <- create_mock_pkg("mock-pkg-skip-stale")

  mock_test_dir <- file.path(mock_dir, "tests", "testthat")
  test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
  result <- test_results[[1]]$results[[1]]

  expect_is(result, "expectation_skip")
  expect_match(result$message, "The vdiffr engine is too old")
})
