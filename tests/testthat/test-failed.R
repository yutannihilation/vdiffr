
context("Failed cases")

test_that("Mismatches fail", {
  failed_result <- subset_results(test_results, "test-failed.R")[[1]]

  msg <- failed_result$message
  expected_msg <- "`testcase` not equal to `expected`.\nFigures don't match: failed.svg\n"
  expect_equal(msg, expected_msg)

  class <- class(failed_result)[[1]]
  expect_equal(class, "expectation_failure")

})
