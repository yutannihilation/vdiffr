
context("Failed cases")

test_that("Mismatches fail", {
  failed_result <- subset_results(test_results, "test-failed.R")[[1]]
  expect_match(failed_result$message, "Figures don't match: failed.svg\n")

  class <- class(failed_result)[[1]]
  expect_equal(class, "expectation_failure")

})
