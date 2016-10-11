#' Does a figure look like its expected output?
#'
#' If the test has never been validated yet, the test is skipped. If
#' the test has previously been validated but \code{fig} does not look
#' like its expected output, an error is issued. Use
#' \code{\link{validate_cases}()} or \code{\link{manage_cases}()} to
#' (re)validate the test.
#'
#' \code{fig} can be a ggplot object, a recordedplot, a function to be
#' called, or more generally any object with a \code{print} method. If
#' a ggplot object, a dependency for ggplot2 is automatically added
#' (see \code{\link{add_dependency}()}).
#' @param fig A figure to test.
#' @param fig_name The name of the test case. This will be used as the
#'   base for the SVG file name.
#' @param path The path where the test case should be stored, relative
#'   to the \code{tests/figs/} folder. If \code{NULL} (the default),
#'   the current testthat context is used to create a
#'   subfolder. Supply an empty string \code{""} if you want the
#'   figures to be stored in the root folder.
#' @param ... Additional arguments passed to
#'   \code{\link[testthat]{compare}()} to control specifics of
#'   comparison.
#' @export
#' @examples
#' \dontrun{
#' disp_hist_base <- function() hist(mtcars$disp)
#' disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()
#'
#' expect_doppelganger(disp_hist_base, "disp-histogram-base")
#' expect_doppelganger(disp_hist_ggplot, "disp-histogram-ggplot")
#' }
expect_doppelganger <- function(fig, fig_name, path = NULL, ...) {
  testcase <- testcase(fig_name)
  write_svg(fig, testcase)

  context <- get(".context", envir = testthat::get_reporter())
  context <- str_standardise(context)
  path <- path %||% context

  # Climb one level as we are in the testthat folder
  path <- file.path(path, paste0(fig_name, ".svg"))
  path <- file.path("..", "figs", path)
  ensure_directories(dirname(path))

  if (file.exists(path)) {
    # Dispatches to compare()'s vdiffr_testcase S3 method
    testthat::expect_equal(testcase, path, fig_name = fig_name, ...)
  } else {
    signal_new_case(fig_name, path, testcase)
  }
}

str_standardise <- function(s, sep = "-") {
  gsub(" |/", sep, tolower(s))
}

signal_new_case <- function(fig_name, path, testcase_path) {
  maybe_collect_case("new", name = fig_name, path = path, testcase = testcase_path)
  msg <- paste0("Figure not generated yet: ", fig_name, ".svg")

  expectation <- testthat::expectation("skip", msg)
  signal_expectation(expectation)
  invisible(expectation)
}

signal_expectation <- function(exp) {
  withRestarts(signalCondition(exp), continue_test = function(e) NULL)
  invisible(exp)
}

#' @importFrom testthat compare
#' @export
compare.vdiffr_testcase <- function(x, y, fig_name, ...) {
  equal <- compare_files(x, normalizePath(y))
  if (equal) {
    msg <- "TRUE"
  } else {
    maybe_collect_case("mismatch", name = fig_name, path = y, testcase = x)
    msg <- paste0("Figures don't match: ", fig_name, ".svg")
  }

  comparison <- list(equal = equal, message = msg)
  structure(comparison, class = "comparison")
}

#' Add a vdiffr dependency
#'
#' It is useful to record the version number of all the packages on
#' which your visual test cases depend. A note containing a version
#' number is added to the \code{DESCRIPTION} file for each dependency.
#' Dependencies on svglite and ggplot2 are automatically added. In
#' addition, \code{add_dependency()} can be called in any testthat
#' file to manually add a dependency to a package.
#'
#' @param deps A vector containing the names of the packages for which
#'   a dependency should be added.
#' @export
add_dependency <- function(deps) {
  collecter <- active_collecter()
  if (!is.null(collecter)) {
    walk(deps, collecter$add_dep)
  }
}
