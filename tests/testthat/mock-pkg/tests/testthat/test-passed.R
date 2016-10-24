
context("Passed plots")
library("vdiffr")

test_that("ggplot doppelgangers pass", {
  p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()
  expect_doppelganger("myplot", p1_orig, "")
})

test_that("base doppelgangers pass", {
  p2_orig <- function() plot(mtcars$disp)
  expect_doppelganger("myplot2", p2_orig, "")
})

library("grid")
test_that("grid doppelgangers pass", {
  p_grid <- function() {
    grid.newpage()
    grid.text("foobar", gp = gpar(fontsize = 10.1))
    grid.text("foobaz", 0.5, 0.1, gp = gpar(fontsize = 15.05))
  }
  expect_doppelganger("Grid doppelganger", p_grid)
})
