
context("New cases")

test_that("new cases are skipped", {
  test_results <- testthat::test_dir("test-dir", reporter = "silent")
  cases_results <- test_results[[1]]$results

  msg <- map_chr(cases_results, function(result) result$message)
  expected_msg <- "Figure not generated yet: new%s.svg"
  expected_msg <- c(sprintf(expected_msg, "1"), sprintf(expected_msg, "2"))
  expect_equal(msg, expected_msg)

  classes <- map_chr(cases_results, function(result) class(result)[[1]])
  expected_classes <- rep("expectation_skip", 2)
  expect_equal(classes, expected_classes)
})
