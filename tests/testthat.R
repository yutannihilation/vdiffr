
mock_path <- file.path("testthat", "mock-pkg", "tests")
cases_ver <- vdiffr:::cases_freetype_version(mock_path)
system_ver <- vdiffr:::system_freetype_version()

cat(glue::glue("system: { as.character(gdtools::version_freetype()) }"), "\n")
cat(glue::glue("cases: { as.character(cases_ver) }"), "\n")


if (cases_ver != system_ver) {
  cat(glue::glue(
    "Skipping tests because the mock package was generated with a different FreeType version
     Mock package: { cases_ver }
     System: { system_ver }

    "
  ))
} else {
  library("testthat")
  library("vdiffr")
  test_check("vdiffr")
}
