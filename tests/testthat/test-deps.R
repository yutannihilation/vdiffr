
context("Dependencies")

check_depnote <- function(pkg_name) {
  note_path <- file.path(mock_pkg_dir, "tests", "figs", "deps.txt")
  deps <- readLines(note_path)

  pkg_version <- package_version(pkg_name)
  note <- paste0(pkg_name, ": ", pkg_version)
  expect_true(any(grepl(note, deps)))
}
check_svglite_depnote <- function(pkg_name) {
  note_path <- file.path(mock_pkg_dir, "tests", "figs", "deps.txt")
  deps <- readLines(note_path)
  engine_dep <- glue::glue("vdiffr-svg-engine: { svg_engine_ver() }")
  expect_true(sum(grepl(engine_dep, deps)) == 1L)
}

test_that("DESCRIPTION notes are updated manually", {
  skip_old_freetype()
  check_depnote("utils")
})

test_that("DESCRIPTION notes are updated automatically", {
  skip_old_freetype()
  check_depnote("ggplot2")
  check_svglite_depnote()
})
