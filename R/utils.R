
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

update_dependency <- function(dep, pkg_path) {
  desc_path <- file.path(pkg_path, "DESCRIPTION")
  desc <- desc::description$new(desc_path)
  padding <- "\n    "

  note <- desc$get("vdiffrNote")
  if (identical(note, c(vdiffrNote = NA_character_))) {
    note <- NULL
  } else {
    note <- paste0(note, ",")
  }

  version <- as.character(utils::packageVersion(dep))
  note <- paste0(note, padding, dep, " (", version, ")")

  desc$set("vdiffrNote", note)
  desc$write()

  NULL
}
