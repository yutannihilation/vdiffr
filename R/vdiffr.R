#' @importFrom purrr splice map map_chr keep walk every set_names
#'   partial %||% map2_chr is_scalar_character
#' @importFrom R6 R6Class
#' @useDynLib vdiffr
NULL

old_freetype <- function() {
  gdtools::version_freetype() < "2.6.0"
}
