
context("Orphaned")

test_that("Orphaned figures are found", {
  skip_old_freetype()

  orphaned <- filter_cases(mock_cases, "case_orphaned")
  expect_equal(map_chr(orphaned, "name"), set_names(c("orphaned1", "orphaned2")))
})

test_that("Orphaned files are found and deleted", {
  skip_old_freetype()

  orphaned <- filter_cases(mock_cases, "case_orphaned")
  files <- map_chr(orphaned, "path")
  files <- map_chr(files, purrr::partial(file.path, mock_pkg_dir, "tests", "testthat"))
  files_exist <- purrr::every(files, file.exists)
  expect_true(files_exist)

  if (files_exist) {
    delete_orphaned_cases(mock_cases)
    expect_false(purrr::some(files, file.exists))
  }
})
