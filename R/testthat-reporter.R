
casesCollecter <-
  R6::R6Class("casesCollecter",
    public = list(
      initialize = function(pkg_path) {
        default_deps <- c("vdiffr", "svglite")
        private$.cases <- cases(list(), pkg_path, default_deps)
      },

      add_case = function(case) {
        case <- set_names(list(case), case$name)
        private$.cases = c(private$.cases, case)
      },

      add_dep = function(dep) {
        deps <- attr(private$.cases, "deps")
        attr(private$.cases, "deps") <- unique(c(deps, dep))
      },

      get_cases = function() {
        private$.cases
      }
    ),

    private = list(
      .cases = NULL
    )
  )

vdiffr_env <- new.env(parent = emptyenv())

set_active_collecter <- function(collecter) {
  vdiffr_env$active_collecter <- collecter
}

active_collecter <- function() {
  vdiffr_env$active_collecter
}

maybe_collect_case <- function(type, ...) {
  collecter <- active_collecter()

  if (!is.null(collecter)) {
    case <- switch(type,
      new = case_new(...),
      mismatch = case_mismatch(...),
      success = case_success(...),
      stop("Unknown case type")
    )

    collecter$add_case(case)
  }
}

expectation_error <- function(exp) {
  exp <- gsub("^expectation_", "", class(exp)[[1]])
  exp == "error"
}

vdiffrReporter <-
  R6::R6Class("vdiffrReporter", inherit = testthat::Reporter,
    public = list(
      failure = NULL,

      initialize = function(pkg_path) {
        collecter <- casesCollecter$new(pkg_path)
        set_active_collecter(collecter)
      },

      add_result = function(context, test, result) {
        cat(single_letter_summary(result))
        if (expectation_error(result)) {
          self$failure <- result
        }
      },

      end_reporter = function() {
        cat("\n")
        if (!is.null(self$failure)) {
          stop(call. = FALSE,
            "while collecting vdiffr cases. Last error:\n",
            "     test: `", self$failure$test, "`\n",
            "  message: `", self$failure$message, "`"
          )
        }
      }
    )
  )

expectation_type <- function(exp) {
  stopifnot(inherits(exp, "expectation"))
  if (inherits(exp, "vdiffr_new")) return("new")
  if (inherits(exp, "vdiffr_mismatch")) return("mismatch")
  if (inherits(exp, "vdiffr_match")) return("match")

  gsub("^expectation_", "", class(exp)[[1]])
}
single_letter_summary <- function(x) {
  switch(expectation_type(x),
    new      = "N",
    mismatch = "X",
    match    = "o",
    skip     = "S",
    success  = ".",
    error    = "E",
    failure  = "F",
    warning  = "W",
    "?"
  )
}
