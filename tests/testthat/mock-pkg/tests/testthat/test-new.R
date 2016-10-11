
context("New plots")
library("vdiffr")

p1 <- function() plot(mtcars$disp)
p2 <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) +
  ggplot2::geom_histogram()

test_that("New plots work are collected", {
  expect_doppelganger(p1, "new1", "")
  expect_doppelganger(p2, "new2", "")
})

test_that("Figs are saved to alternative paths", {
  expect_doppelganger(p1, "alt1", "path1")
  expect_doppelganger(p2, "alt2", "path2")
})

test_that("Figs are saved to context subfolders", {
  expect_doppelganger(p1, "context1")
  expect_doppelganger(p2, "context2")
})
