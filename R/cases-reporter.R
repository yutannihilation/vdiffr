
casesCollecter <-
  R6::R6Class("casesCollecter",
    public = list(
      initialize = function(package_path) {
        private$.cases <- cases(list(), package_path)
      },

      add_case = function(case) {
        case <- set_names(list(case), case$name)
        private$.cases = c(private$.cases, case)
      },

      get_cases = function() private$.cases
    ),

    private = list(
      .cases = list()
    )
  )

active_collecter <- NULL

set_active_collecter <- function(collecter) {
  active_collecter <<- collecter
}

maybe_collect_case <- function(type, ...) {
  if (is.null(active_collecter)) {
    return(NULL)
  }

  case <- switch(type,
    new = case_new(...),
    mismatch = case_mismatch(...),
    stop("Unknown case type")
  )

  active_collecter$add_case(case)
}

vdiffrReporter <-
  R6::R6Class("vdiffrReporter", inherit = testthat::Reporter,

    public = list(
      initialize = function(package_path) {
        collecter <- casesCollecter$new(package_path)
        set_active_collecter(collecter)
      }
    )
  )
