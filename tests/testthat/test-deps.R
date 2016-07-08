
context("Dependencies")

desc_path <- file.path(mock_pkg_dir, "DESCRIPTION")
desc <- desc::description$new(desc_path)

check_depnote <- function(pkg_name) {
  field_name <- paste0(pkg_name, "Note")
  desc_note <- desc$get(field_name)
  pkg_version <- as.character(utils::packageVersion(pkg_name))

  expect_equal(desc_note, purrr::set_names(pkg_version, field_name))
}

test_that("DESCRIPTION notes are updated manually", {
  check_depnote("utils")
})

test_that("DESCRIPTION notes are updated automatically", {
  check_depnote("svglite")
  check_depnote("ggplot2")
})
