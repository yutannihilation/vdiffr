
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

validate_path <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  path
}

read_file <- function(file) {
  readChar(file, file.info(file)$size)
}

write_file <- function(x, file) {
  writeChar(x, file)
}

capitalise <- function(x) {
  map_chr(x, function(string) {
    paste0(
      toupper(substring(string, 1, 1)),
      substring(string, 2)
    )
  })
}

update_dependency <- function(dep, pkg_path) {
  desc_path <- file.path(pkg_path, "DESCRIPTION")
  desc <- description::description$new(desc_path)

  note <- paste0(dep, "Note")
  version <- as.character(utils::packageVersion(dep))

  desc$set(note, version)
  desc$write()

  NULL
}
