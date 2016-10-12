
subset_results <- function(results, file, test) {
  subset <- purrr::keep(results, function(result) {
    result$file == file && result$test == test
  })
  subset[[1]]$results
}
