#' @import rlang
#' @importFrom glue glue
#' @importFrom purrr map map_chr keep walk every partial map2_chr
#' @importFrom R6 R6Class
#' @importFrom Rcpp sourceCpp
#' @useDynLib vdiffr, .registration = TRUE
"_PACKAGE"

old_freetype <- function() {
  gdtools::version_freetype() < "2.6.0"
}
