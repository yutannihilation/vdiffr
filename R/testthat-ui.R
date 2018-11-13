#' Does a figure look like its expected output?
#'
#' If the test has never been validated yet, the test is skipped. If
#' the test has previously been validated but \code{fig} does not look
#' like its expected output, an error is issued. Use
#' [validate_cases()] or [manage_cases()] to (re)validate
#' the test.
#'
#' `fig` can be a ggplot object, a recordedplot, a function to be
#' called, or more generally any object with a `print` method. If a
#' ggplot object, a dependency for ggplot2 is automatically added (see
#' [add_dependency()].
#' @param title The figure title is used for creating the figure file
#'   names (all non-alphanumeric characters are converted to
#'   `"-"`). Also, ggplot2 figures are appended with `ggtitle(title)`.
#' @param fig A figure to test.
#' @param path The path where the test case should be stored, relative
#'   to the `tests/figs/` folder. If `NULL` (the default), the current
#'   testthat context is used to create a subfolder. Supply an empty
#'   string `""` if you want the figures to be stored in the root
#'   folder.
#' @param ... Additional arguments passed to [testthat::compare()] to
#'   control specifics of comparison.
#' @param verbose If `TRUE`, the contents of the SVG files for the
#'   comparison plots are printed during testthat checks. This is
#'   useful to investigate errors when testing remotely.
#'
#'   Note that it is not possible to print the original SVG during
#'   interactive use. This is because there is no way of figuring out
#'   in which directory this SVG lives. Consequently, only the test
#'   case is printed.
#' @param writer A function that takes the plot, a target SVG file,
#'   and an optional plot title. It should transform the plot to SVG
#'   in a deterministic way and write it to the target file. See
#'   [write_svg()] (the default) for an example.
#' @export
#' @examples
#' disp_hist_base <- function() hist(mtcars$disp)
#' expect_doppelganger("disp-histogram-base", disp_hist_base)
#'
#' library("ggplot2")
#' disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()
#' expect_doppelganger("disp-histogram-ggplot", disp_hist_ggplot)
expect_doppelganger <- function(title,
                                fig,
                                path = NULL,
                                ...,
                                verbose = FALSE,
                                writer = write_svg) {
  fig_name <- str_standardise(title)
  testcase <- make_testcase_file(fig_name)
  writer(fig, testcase, title)

  context <- get(".context", envir = testthat::get_reporter())
  context <- str_standardise(context %||% "")
  path <- path %||% context

  # Climb one level as we are in the testthat folder
  path <- file.path(path, paste0(fig_name, ".svg"))
  path <- file.path("..", "figs", path)
  ensure_directories(dirname(path))

  case <- case(list(
    name = fig_name,
    path = path,
    testcase = testcase,
    verbose = verbose
  ))

  if (file.exists(path)) {
    exp <- compare_figs(case)
  } else {
    case <- new_case(case)
    maybe_collect_case(case)
    maybe_print_svgs(case)
    msg <- paste0("Figure not generated yet: ", fig_name, ".svg")
    exp <- new_exp(msg, case)
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

compare_figs <- function(case) {
  equal <- compare_files(case$testcase, normalizePath(case$path))

  if (equal) {
    case <- success_case(case)
    maybe_collect_case(case)
    return(match_exp("TRUE", case))
  }

  case <- mismatch_case(case)
  maybe_collect_case(case)
  push_log(case)

  msg <- paste0("Figures don't match: ", case$name, ".svg\n")
  mismatch_exp(msg, case)
}

# Print only if we're not collecting. The testthat reporter prints
# verbose cases at a later point.
maybe_print_svgs <- function(case, pkg_path = NULL) {
  if (case$verbose && is_null(active_collecter())) {
    meow(svg_files_lines(case, pkg_path))
  }
}

new_expectation <- function(msg, case, type, vdiffr_type) {
  exp <- testthat::expectation(type, msg)
  classes <- c(class(exp), vdiffr_type)
  structure(exp, class = classes, vdiffr_case = case)
}
new_exp <- function(msg, case) {
  new_expectation(msg, case, "skip", "vdiffr_new")
}
match_exp <- function(msg, case) {
  new_expectation(msg, case, "success", "vdiffr_match")
}
mismatch_exp <- function(msg, case) {
  new_expectation(msg, case, "failure", "vdiffr_mismatch")
}
skipped_mismatch_exp <- function(msg, case) {
  new_expectation(msg, case, "skip", "vdiffr_mismatch")
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
#' number is added to the `DESCRIPTION` file for each dependency.
#' Dependencies on svglite and ggplot2 are automatically added. In
#' addition, `add_dependency()` can be called in any testthat file to
#' manually add a dependency to a package.
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
