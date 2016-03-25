
create_mock_pkg <- function() {
  dir <- tempfile()
  dir.create(dir)

  file.copy("mock-pkg/", dir, recursive = TRUE)
  file.path(dir, "mock-pkg")
}

mock_pkg_dir <- create_mock_pkg()
cases <- vdiffr::collect_cases(mock_pkg_dir)

vdiffr::validate_cases(cases)
