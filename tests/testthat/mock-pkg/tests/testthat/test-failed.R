
context("Failed plots")
library("vdiffr")

p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()
p1_fail <- p1_orig + ggplot2::geom_vline(xintercept = 300)

maintenance <- FALSE
skip_if_maintenance <- function() {
  if (maintenance) {
    skip("maintenance")
  }
}

test_that("(maintenance) Reset failing figure", {
  if (!maintenance) {
    skip("maintenance")
  }
  expect_doppelganger("myplot", p1_orig, "")
})
test_that("New plots work are collected", {
  skip_if_maintenance()
  expect_doppelganger("myplot", p1_fail, "")
})

test_that("Duplicated expectations issue a warning", {
  skip_if_maintenance()
  expect_doppelganger("myplot", p1_fail, "")
})

test_that("SVGs of failing cases are printed when `verbose` is TRUE", {
  skip_if_maintenance()
  expect_doppelganger("myplot", p1_fail, "", verbose = TRUE)
})
