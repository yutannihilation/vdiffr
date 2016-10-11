
context("Failed plots")
library("vdiffr")

p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()
p1_fail <- p1_orig + ggplot2::geom_vline(xintercept = 300)

test_that("New plots work are collected", {
  expect_doppelganger(p1_fail, "failed")
})
