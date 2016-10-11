
context("File comparison")

write_tempfile <- function(lines) {
  path <- tempfile()

  file <- file(path)
  open(file, "w")
  writeLines(lines, file)
  close(file)

  path
}

test_that("files are correctly compared", {
  original <- write_tempfile(letters)
  good <- write_tempfile(letters)
  bad <- write_tempfile(LETTERS)

  expect_true(compare_files(original, good))
  expect_false(compare_files(original, bad))
})
