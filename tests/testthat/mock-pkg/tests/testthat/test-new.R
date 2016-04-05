
context("New plots")

test_that("New plots work are collected", {
  p1 <- function() plot(mtcars$disp)
  p2 <- function() plot(mtcars$drat)

  expect_doppelganger(p1, "new1")
  expect_doppelganger(p2, "new2")
})

test_that("Figs are saved to alternative paths", {
  expect_doppelganger(p1, "alt1", "path1")
  expect_doppelganger(p2, "alt2", "path2")
})
