
context("New cases")

test_that("new cases are skipped", {
  new_results <- subset_results(test_results, "test-new.R")

  msg <- map_chr(new_results, function(result) result$message)
  expected_msg <- "Figure not generated yet: new%s.svg"
  expected_msg <- c(sprintf(expected_msg, "1"), sprintf(expected_msg, "2"))
  expect_equal(msg, expected_msg)

  classes <- map_chr(new_results, function(result) class(result)[[1]])
  expected_classes <- rep("expectation_skip", 2)
  expect_equal(classes, expected_classes)
})
