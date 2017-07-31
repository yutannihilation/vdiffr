
context("Failed plots")
library("vdiffr")

p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()
p1_fail <- p1_orig + ggplot2::geom_vline(xintercept = 300)

test_that("(maintenance) Reset failing figure", {
  skip("maintenance")
  expect_doppelganger("myplot", p1_orig, "")
})
test_that("New plots work are collected", {
  expect_doppelganger("myplot", p1_fail, "")
})

test_that("Duplicated expectations issue a warning", {
  expect_doppelganger("myplot", p1_fail, "")
})

test_that("SVGs of failing cases are printed when `verbose` is TRUE", {
  expect_doppelganger("myplot", p1_fail, "", verbose = TRUE)
})
