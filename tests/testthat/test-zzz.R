
is_checking <- function() {
  nzchar(Sys.getenv("R_TESTS"))
}

# Forward mock-pkg's log in case of failure so we get useful
# information on Travis
if (is_checking()) {
  log <- readLines(file.path(mock_pkg_dir, "tests", "vdiffr.fail"))

  file <- file(file.path("..", "vdiffr.fail"), "a")
  on.exit(close(file))
  cxn_meow(file, log)

  invisible(TRUE)
}
