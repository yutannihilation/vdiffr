
on_appveyor <- function() {
  identical(Sys.getenv("APPVEYOR"), "True")
}
on_cran <- function() {
  !identical(Sys.getenv("NOT_CRAN"), "true")
}

# Hack to force Fontconfig to reload debug flag
reload_gdtools <- function() {
  ns_env <- asNamespace("gdtools")
  ns_info <- ns_env[[".__NAMESPACE__."]]
  dll <- ns_info$DLLs$gdtools
  dll_path <- .subset2(dll, "path")
  dyn.load(dll_path)
}

set_dummy_conf <- function() {
  template_path <- file.path("dummy-fonts.conf")
  template <- readChar(template_path, file.info(template_path)$size, useBytes = TRUE)

  font_path <- fontquiver::font("Bitstream Vera", "Sans", "Roman")$ttf
  conf_path <- file.path(tempdir(), "dummy_fontconfig")
  dir.create(conf_path, FALSE)

  file.copy(font_path, conf_path)
  template <- sprintf(template, conf_path)

  conf_file <- file.path(conf_path, "fonts.conf")
  writeChar(template, conf_file, eos = NULL, useBytes = TRUE)

  # Rebuild cache with dummy conf
  Sys.setenv(FONTCONFIG_FILE = conf_file)
  reload_gdtools()
  gdtools::match_font("serif")
}

# Use minimal fonts.conf to speed up fc-cache
if (on_appveyor() || on_cran()) {
  set_dummy_conf()
}
