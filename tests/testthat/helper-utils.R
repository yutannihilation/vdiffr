
subset_results <- function(results, file) {
  subset <- purrr::keep(results, function(result) result$file == file)
  subset[[1]]$results
}
