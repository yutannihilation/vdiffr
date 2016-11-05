
context("Dependencies")

check_depnote <- function(pkg_name) {
  note_path <- file.path(mock_pkg_dir, "tests", "figs", "deps.txt")
  deps <- readLines(note_path)

  pkg_version <- package_version(pkg_name)
  note <- paste0(pkg_name, ": ", pkg_version)
  expect_true(any(grepl(note, deps)))
}

test_that("DESCRIPTION notes are updated manually", {
  skip_old_freetype()
  check_depnote("utils")
})

test_that("DESCRIPTION notes are updated automatically", {
  skip_old_freetype()
  check_depnote("svglite")
  check_depnote("ggplot2")
})
