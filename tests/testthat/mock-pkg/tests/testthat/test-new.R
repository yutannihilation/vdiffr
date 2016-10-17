
context("New plots")
library("vdiffr")

p1 <- function() plot(mtcars$disp)
p2 <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) +
  ggplot2::geom_histogram()

test_that("New plots are collected", {
  expect_doppelganger("new1", p1, "", user_fonts = fonts)
  expect_doppelganger("new2", p2, "", user_fonts = fonts)
})

test_that("Figs are saved to alternative paths", {
  expect_doppelganger("alt1", p1, "path1", user_fonts = fonts)
  expect_doppelganger("alt2", p2, "path2", user_fonts = fonts)
})

test_that("Figs are saved to context subfolders", {
  expect_doppelganger("context1", p1, user_fonts = fonts)
  expect_doppelganger("context2", p2, user_fonts = fonts)
})
