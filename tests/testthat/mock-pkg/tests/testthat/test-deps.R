
context("Dependencies")
library("vdiffr")

test_that("DESCRIPTION notes are updated manually", {
  add_dependency("utils")
})
