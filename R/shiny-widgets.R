
#' @export
toggleOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "vdiffr-toggle",
    width, height, package = "vdiffr")
}

#' @export
renderToggle <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }
  htmlwidgets::shinyRenderWidget(expr, toggleOutput, env, quoted = TRUE)
}

#' @export
slideOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "vdiffr-slide",
    width, height, package = "vdiffr")
}

#' @export
slideTransition <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }
  htmlwidgets::shinyRenderWidget(expr, slideOutput, env, quoted = TRUE)
}

#' @export
diffOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "vdiffr-diff",
    width, height, package = "vdiffr")
}

#' @export
diffTransition <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }
  htmlwidgets::shinyRenderWidget(expr, diffOutput, env, quoted = TRUE)
}
