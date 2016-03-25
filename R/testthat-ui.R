
#' @export
expect_doppelganger <- function(fig, fig_name, path = "../figs", ...) {
  expected_path <- file.path(path, paste0(fig_name, ".svg"))
  testcase <- as_svg(fig)

  if (!file.exists(expected_path)) {
    maybe_collect_case("new",
      testcase = testcase,
      name = fig_name
    )
    msg <- paste0("Figure not generated yet: ", fig_name, ".svg")

    expectation <- testthat::expectation("skip", msg)
    signal_expectation(expectation)
    return(invisible(expectation))
  }

  expected <- read_svg(expected_path)
  testthat::expect_equal(testcase, expected, fig_name = fig_name, ...)
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
compare.svg <- function(x, y, fig_name, ...) {
  equal <- identical(x, y)
  if (equal) {
    msg <- "TRUE"
  } else {
    maybe_collect_case("mismatch",
      testcase = x,
      expected = y,
      name = fig_name
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
