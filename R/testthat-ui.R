
#' @export
expect_doppelganger <- function(fig, fig_name, fig_path = "figs", ...) {
  testcase <- as_svg(fig)
  fig_path <- file.path(fig_path, paste0(fig_name, ".svg"))

  # Climb one level as we are in the testthat folder
  test_path <- file.path("..", fig_path)

  if (!file.exists(test_path)) {
    maybe_collect_case("new",
      testcase = testcase,
      name = fig_name,
      path = fig_path
    )
    msg <- paste0("Figure not generated yet: ", fig_name, ".svg")

    expectation <- testthat::expectation("skip", msg)
    signal_expectation(expectation)
    return(invisible(expectation))
  }

  expected <- read_svg(test_path)
  testthat::expect_equal(testcase, expected,
    fig_name = fig_name,
    path = test_path,
    ...
  )
}

signal_expectation <- function(exp) {
  withRestarts(
    signalCondition(exp),
    continue_test = function(e) NULL
  )

  invisible(exp)
}

#' @importFrom testthat compare
#' @export
compare.svg <- function(x, y, fig_name, fig_path, ...) {
  equal <- identical(x, y)
  if (equal) {
    msg <- "TRUE"
  } else {
    maybe_collect_case("mismatch",
      testcase = x,
      expected = y,
      name = fig_name,
      path = fig_path
    )

    msg <- paste0("Figures don't match: ", fig_name, ".svg")
  }

  comparison <- list(
    equal = equal,
    message = msg
  )
  structure(comparison, class = "comparison")
}

#' @export
add_dependency <- function(deps) {
  collecter <- active_collecter()
  if (!is.null(collecter)) {
    walk(deps, collecter$add_dep)
  }
}
