
context("Passed plots")
library("vdiffr")

p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()

test_that("doppelgangers pass", {
  expect_doppelganger(p1_orig, "myplot", "")
})
