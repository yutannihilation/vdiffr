
mock_path <- file.path("testthat", "mock-pkg", "tests")
cases_ver <- vdiffr:::cases_freetype_version(mock_path)
system_ver <- vdiffr:::system_freetype_version()

if (cases_ver != system_ver) {
  cat(glue::glue(
    "Skipping tests because the mock package was generated with a different FreeType version
     Mock package: { cases_ver }
     System: { system_ver }\n"
  ))
} else {
  library("testthat")
  library("vdiffr")
  test_check("vdiffr")
}
