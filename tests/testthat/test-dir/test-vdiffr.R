
context("Visual Expectations")

test_that("New plots work", {
  p1 <- function() plot(mtcars$disp)
  p2 <- function() plot(mtcars$drat)

  expect_doppelganger(p1, "new1")
  expect_doppelganger(p2, "new2")
})
