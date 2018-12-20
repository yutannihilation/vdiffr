
is_absolute_path <- function(path) {
  substr(path, 0, 1) %in% c("~", .Platform$file.sep)
}

maybe_concat_paths <- function(base_path, path) {
  if (is_absolute_path(path)) {
    path
  } else {
    file.path(base_path, path)
  }
}

ensure_directories <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  path
}

capitalise <- function(x) {
  map_chr(x, function(string) {
    paste0(
      toupper(substring(string, 1, 1)),
      substring(string, 2)
    )
  })
}

read_file <- function(file) {
  readChar(file, file.info(file)$size)
}

package_version <- function(pkg) {
  as.character(utils::packageVersion(pkg))
}

adjust_figs_path <- function(path, pkg_path) {
  # normalizePath() does not expand paths that do not exist so this
  # expands "../figs/" manually
  components <- strsplit(path, .Platform$file.sep)[[1]]
  components <- components[-(1:2)]
  args <- c(list(pkg_path, "tests", "figs"), as.list(components))
  path <- do.call(file.path, args)

  path
}

normalise_path <- function(path) {
  path <- normalizePath(path, mustWork = FALSE)

  # Get rid of double separators
  sep <- .Platform$file.sep
  gsub(paste0(sep, "+"), sep, path)
}

str_trim_ext <- function(path) {
  sub("\\..+$", "", path)
}


# R 3.2.0 compat
dir.exists <- function(paths) {
  if (utils::packageVersion("base") >= "3.2.0") {
    (baseenv()$dir.exists)(paths)
  } else {
    purrr::map_lgl(paths, dir_exists)
  }
}

dir_exists <- function(path) {
  !identical(path, "") && file.exists(paste0(path, .Platform$file.sep))
}

cat_line <- function(..., trailing = TRUE, file = "") {
  cat(paste_line(..., trailing = trailing), file = file)
}
paste_line <- function(..., trailing = FALSE) {
  lines <- paste(chr(...), collapse = "\n")
  if (trailing) {
    lines <- paste0(lines, "\n")
  }
  lines
}

svg_files_lines <- function(case, pkg_path = NULL) {
  name <- case$name
  if (is_null(pkg_path)) {
    original_path <- case$path
  } else {
    # The reporter is not run from the test directory
    original_path <- from_test_dir(pkg_path, case$path)
  }

  # If called from interactive use, we most likely can't figure out
  # where the original SVG lives (most likely in a subdirectory within
  # the `figs` folder) so we don't print it.
  if (file.exists(original_path)) {
    original_lines <- paste_line(
      "> Original SVG:",
      readLines(original_path),
      ""
    )
  } else {
    original_lines <- ""
  }

  lines <- paste_line(
    glue(">> Failed doppelganger: { case$name }"),
    original_lines,
    "> Testcase SVG:",
    readLines(case$testcase),
    ""
  )
}
from_test_dir <- function(pkg_path, path) {
  file.path(pkg_path, "tests", "testthat", path)
}

push_log <- function(case) {
  if (!is_checking()) {
    return(invisible(FALSE))
  }

  log_path <- file.path("..", "vdiffr.Rout.fail")
  log_exists <- file.exists(log_path)

  file <- file(log_path, "a")
  on.exit(close(file))

  if (!log_exists) {
    cat_line(file = file, glue(
      "Environment:
       - vdiffr: { utils::packageVersion('vdiffr') }
       - freetypeharfbuzz: { utils::packageVersion('freetypeharfbuzz') }"
    ))
  }
  cat_line(file = file, svg_files_lines(case))

  invisible(TRUE)
}
is_checking <- function() {
  nzchar(Sys.getenv("R_TESTS"))
}

hash_encode_url <- function(url){
  gsub("#", "%23", url)
}
