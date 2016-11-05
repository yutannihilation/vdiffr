
context("ggplot")

test_that("ggtitle is set correctly", {
  skip_old_freetype()

  ggplot_results <- subset_results(test_results, "test-ggplot.R", "ggtitle is set correctly")
  expect_true(purrr::every(ggplot_results, inherits, "expectation_success"))
})
