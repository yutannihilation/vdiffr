context("FreeType")

get_result <- function(suffix) {
  mock_pkg_dir <- create_mock_pkg(paste0("mock-pkg-skip-", suffix))
  mock_test_dir <- file.path(mock_pkg_dir, "tests", "testthat")
  test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
  result <- test_results[[1]]$results[[1]]
}

test_that("skip failing tests with newer FreeType", {
  result <- get_result("newer")
  expect_is(result, "expectation_skip")
  expect_match(result$message, "newer FreeType")
})

test_that("skip failing tests with older FreeType", {
  result <- get_result("older")
  expect_is(result, "expectation_skip")
  expect_match(result$message, "older FreeType")
})
