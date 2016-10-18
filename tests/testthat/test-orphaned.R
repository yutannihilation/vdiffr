
context("Orphaned")

test_that("Orphaned figures are found", {
  orphaned <- filter_cases(mock_cases, "case_orphaned")
  expect_equal(map_chr(orphaned, "name"), set_names(c("some-other-title", "some-title")))
})

test_that("Orphaned files are found and deleted", {
  orphaned <- filter_cases(mock_cases, "case_orphaned")
  files <- map_chr(orphaned, "path")
  files <- map_chr(files, purrr::partial(file.path, mock_pkg_dir, "tests", "testthat"))
  expect_true(purrr::every(files, file.exists))

  delete_orphaned_cases(mock_cases)
  expect_false(purrr::some(files, file.exists))
})
