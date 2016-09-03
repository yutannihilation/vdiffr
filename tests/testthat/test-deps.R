
context("Dependencies")

desc_path <- file.path(mock_pkg_dir, "DESCRIPTION")
desc <- desc::description$new(desc_path)

check_depnote <- function(pkg_name) {
  pkg_version <- as.character(utils::packageVersion(pkg_name))
  note <- paste0(pkg_name, " \\(", pkg_version, "\\)")
  desc_note <- desc$get("vdiffrNote")

  expect_true(grepl(note, desc_note))
}

test_that("DESCRIPTION notes are updated manually", {
  check_depnote("utils")
})

test_that("DESCRIPTION notes are updated automatically", {
  check_depnote("svglite")
  check_depnote("ggplot2")
})
