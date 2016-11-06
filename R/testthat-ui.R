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
#' @param title The figure title is used for creating the figure file
#'   names (all non-alphanumeric characters are converted to
#'   \code{-}). Also, ggplot2 figures are appended with
#'   \code{ggtitle(title)}.
#' @param fig A figure to test.
#' @param path The path where the test case should be stored, relative
#'   to the \code{tests/figs/} folder. If \code{NULL} (the default),
#'   the current testthat context is used to create a
#'   subfolder. Supply an empty string \code{""} if you want the
#'   figures to be stored in the root folder.
#' @param ... Additional arguments passed to
#'   \code{\link[testthat]{compare}()} to control specifics of
#'   comparison.
#' @param user_fonts Passed to \code{\link[svglite]{svglite}()} to
#'   make sure SVG are reproducible. Defaults to Liberation fonts for
#'   standard families and Symbola font for symbols.
#' @export
#' @examples
#' disp_hist_base <- function() hist(mtcars$disp)
#' expect_doppelganger("disp-histogram-base", disp_hist_base)
#'
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library("ggplot2")
#'   disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()
#'   expect_doppelganger("disp-histogram-ggplot", disp_hist_ggplot)
#' }
expect_doppelganger <- function(title, fig, path = NULL, ...,
                                user_fonts = NULL) {
  fig_name <- str_standardise(title)
  testcase <- make_testcase_file(fig_name)
  write_svg(fig, testcase, title, user_fonts)

  context <- get(".context", envir = testthat::get_reporter())
  context <- str_standardise(context %||% "")
  path <- path %||% context

  # Climb one level as we are in the testthat folder
  path <- file.path(path, paste0(fig_name, ".svg"))
  path <- file.path("..", "figs", path)
  ensure_directories(dirname(path))

  if (file.exists(path)) {
    exp <- compare_figs(testcase, path, fig_name = fig_name)
  } else {
    maybe_collect_case("new", name = fig_name, path = path, testcase = testcase)
    msg <- paste0("Figure not generated yet: ", fig_name, ".svg")
    exp <- expectation_new(msg)
  }

  signal_expectation(exp)
  invisible(exp)
}

str_standardise <- function(s, sep = "-") {
  stopifnot(is_scalar_character(s))
  s <- gsub("[^a-z0-9]", sep, tolower(s))
  s <- gsub(paste0(sep, sep, "+"), sep, s)
  s <- gsub(paste0("^", sep, "|", sep, "$"), "", s)
  s
}

compare_figs <- function(testcase, path, fig_name) {
  equal <- compare_files(testcase, normalizePath(path))

  if (equal) {
    maybe_collect_case("success", name = fig_name, path = path, testcase = testcase)
    exp <- expectation_match("TRUE")
  } else {
    maybe_collect_case("mismatch", name = fig_name, path = path, testcase = testcase)
    msg <- paste0("Figures don't match: ", fig_name, ".svg\n")
    exp <- expectation_mismatch(msg)
  }

  exp
}

expectation_new <- function(msg) {
  x <- testthat::expectation("skip", msg)
  classes <- c(class(x), "vdiffr_new")
  structure(x, class = classes)
}
expectation_mismatch <- function(msg) {
  exp <- testthat::expectation("failure", msg)
  classes <- c(class(exp), "vdiffr_mismatch")
  structure(exp, class = classes)
}
expectation_match <- function(msg) {
  exp <- testthat::expectation("success", msg)
  classes <- c(class(exp), "vdiffr_match")
  structure(exp, class = classes)
}

# From testthat
expectation_broken <- function(exp) {
  expectation_type(exp) %in% c("failure", "mismatch", "error")
}
signal_expectation <- function(exp) {
  withRestarts(
    if (expectation_broken(exp)) {
      stop(exp)
    } else {
      signalCondition(exp)
    },
    continue_test = function(e) NULL
  )
  invisible(exp)
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
