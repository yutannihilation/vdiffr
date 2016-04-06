#' HTML Widgets for graphical comparison
#'
#' @inheritParams htmlwidgets::createWidget
#' @param before Path to the picture that is taken as reference.
#' @param after Path to the picture against which the reference is
#'   compared.
#' @name htmlwidgets
NULL

#' @rdname htmlwidgets
#' @export
widget_toggle <- function(before, after, width = NULL, height = NULL) {
  sources <- list(files = list(before = before, after = after))

  htmlwidgets::createWidget("vdiffr-toggle",
    x = sources,
    width = width,
    height = height,
    package = "vdiffr"
  )
}

#' @rdname htmlwidgets
#' @export
widget_slide <- function(before, after, width = NULL, height = NULL) {
  # Drawing a SVG into a canvas requires that the svg node has 'width'
  # and 'height' attributes set. Otherwise the result is oddly cropped.
  sources <- list(before = before, after = after)
  sources <- list(sources = map(sources, svg_add_dims))

  htmlwidgets::createWidget("vdiffr-slide",
    x = sources,
    width = width,
    height = height,
    package = "vdiffr"
  )
}

#' @rdname htmlwidgets
#' @export
widget_diff <- function(before, after, width = NULL, height = NULL) {
  sources <- list(before = before, after = after)
  sources <- list(sources = map(sources, svg_add_dims))

  htmlwidgets::createWidget("vdiffr-diff",
    x = sources,
    width = width,
    height = height,
    package = "vdiffr"
  )
}
