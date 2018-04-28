#' @import rlang
#' @importFrom glue glue
#' @importFrom purrr map map_chr keep walk every partial map2_chr compact
#' @importFrom R6 R6Class
#' @importFrom Rcpp sourceCpp
#' @useDynLib vdiffr, .registration = TRUE
"_PACKAGE"

.onLoad <- function(lib, pkg) {
  if (!requireNamespace("freetypeharfbuzz", quietly = TRUE)) {
    abort("The package `freetypeharfbuzz` is not installed")
  }
  library_load()
}

old_freetype <- function() {
  gdtools::version_freetype() < "2.6.0"
}

SVG_ENGINE_VER <- "0.9000"

svg_engine_ver <- function() {
  as.numeric_version(SVG_ENGINE_VER)
}
