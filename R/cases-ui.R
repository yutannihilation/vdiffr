#' Manage visual test cases with a Shiny app
#'
#' @inheritParams devtools::test
#' @param package Package description, can be path or package
#'   name. See \code{\link[devtools]{as.package}} for more information.
#' @seealso \code{\link{vdiffrAddin}()}, \code{\link{collect_cases}()}
#'   and \code{\link{validate_cases}()}
#' @export
manage_cases <- function(package = ".", filter = NULL) {
  cases <- collect_cases(package, filter = filter)
  cases <- filter_cases(cases, c("new_case", "mismatch_case", "orphaned_case"))

  vdiffrApp <- shiny::shinyApp(
    ui = vdiffrUi(cases),
    server = vdiffrServer(cases)
  )
  shiny::runApp(vdiffrApp)
}

#' RStudio Addin for managing visual cases
#'
#' The package is detected by looking for the currently active
#' project, then for the current folder if no project is active.
#' @seealso \code{\link{manage_cases}()}, \code{\link{collect_cases}()}
#'   and \code{\link{validate_cases}()}
#' @export
vdiffrAddin <- function() {
  pkg_path <- rstudioapi::getActiveProject() %||% "."
  cases <- collect_cases(pkg_path)
  cases <- filter_cases(cases, c("new_case", "mismatch_case", "orphaned_case"))

  vdiffrApp <- shiny::shinyApp(
    ui = vdiffrUi(cases),
    server = vdiffrServer(cases)
  )
  viewer <- shiny::dialogViewer("vdiffr", width = 1000, height = 800)
  shiny::runGadget(vdiffrApp, viewer = viewer)
}
