
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
