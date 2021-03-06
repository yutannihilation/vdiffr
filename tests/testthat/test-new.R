
context("New cases")

test_that("New cases are skipped", {
  skip_old_freetype()

  new_results <- subset_results(test_results, "test-new.R", "New plots are collected")

  msg <- map_chr(new_results, function(result) result$message)
  expected_msg <- "Figure not generated yet: new%s.svg"
  expected_msg <- c(sprintf(expected_msg, "1"), sprintf(expected_msg, "2"))
  expect_equal(msg, expected_msg)

  classes <- map_chr(new_results, function(result) class(result)[[1]])
  expected_classes <- rep("expectation_skip", 2)
  expect_equal(classes, expected_classes)
})

test_that("Figs are saved to alternative paths", {
  skip_old_freetype()

  path1 <- file.path(mock_pkg_dir, "tests", "figs", "path1")
  path2 <- file.path(mock_pkg_dir, "tests", "figs", "path2")
  expect_true(file.exists(file.path(path1, "alt1.svg")))
  expect_true(file.exists(file.path(path2, "alt2.svg")))
})

test_that("Figs are saved in context subfolders", {
  skip_old_freetype()

  path1 <- file.path(mock_pkg_dir, "tests", "figs", "new-plots")
  path2 <- file.path(mock_pkg_dir, "tests", "figs", "new-plots")
  expect_true(file.exists(file.path(path1, "context1.svg")))
  expect_true(file.exists(file.path(path2, "context2.svg")))
})
