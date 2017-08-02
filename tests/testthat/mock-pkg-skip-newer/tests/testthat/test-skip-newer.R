context("Failing test")

original <- ggplot(mtcars)
failing <- ggplot(mtcars) + geom_vline(xintercept = 0)

test_that("this fails", {
  expect_doppelganger("failing", failing)
})
