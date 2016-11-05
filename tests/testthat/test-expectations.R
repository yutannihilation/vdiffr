
context("Expectations")

test_that("Mismatches fail", {
  skip_old_freetype()

  failed_result <- subset_results(test_results, "test-failed.R", "New plots work are collected")[[1]]
  expect_match(failed_result$message, "Figures don't match: myplot.svg\n")

  class <- class(failed_result)[[1]]
  expect_equal(class, "expectation_failure")
})

test_that("Duplicated expectations issue warning", {
  skip_old_freetype()
  expect_true(any(grepl("Duplicated expectations: myplot", mock_cases_outputs$warnings)))
})

test_that("Doppelgangers pass", {
  skip_old_freetype()

  ggplot_result <- subset_results(test_results, "test-passed.R", "ggplot doppelgangers pass")[[1]]
  base_result <- subset_results(test_results, "test-passed.R", "base doppelgangers pass")[[1]]
  expect_is(ggplot_result, "expectation_success")
  expect_is(base_result, "expectation_success")
})
