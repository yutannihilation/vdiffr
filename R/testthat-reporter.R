
casesCollecter <-
  R6::R6Class("casesCollecter",
    public = list(
      initialize = function(pkg_path) {
        private$.cases <- cases(list(), pkg_path, "svglite")
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
      stop("Unknown case type")
    )

    collecter$add_case(case)
  }
}

vdiffrReporter <-
  R6::R6Class("vdiffrReporter", inherit = testthat::Reporter,

    public = list(
      initialize = function(pkg_path) {
        collecter <- casesCollecter$new(pkg_path)
        set_active_collecter(collecter)
      }
    )
  )
