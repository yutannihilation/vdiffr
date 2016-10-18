
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
  passed_result <- subset_results(test_results, "test-passed.R", "doppelgangers pass")[[1]]
  expect_is(passed_result, "expectation_success")
})
