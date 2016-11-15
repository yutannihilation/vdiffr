
# vdiffr 0.1.1

* `expect_doppelganger()` no longer throws an error when FreeType is
  too old. Instead, the test is skipped. This ensures that R CMD check
  passes on those platforms (e.g., CRAN's Solaris test server).

* Depends on gdtools 0.1.2 or later as this version fixes a crash on
  Linux platforms.

* `widget_toggle()`, `widget_slide()` and `widget_diff()` now take
  plots as arguments. This makes it easy to embed a vdiffr widget in
  R Markdown documents. The underscored versions take HTML sources as
  argument (paths to SVG files or inline SVGs).


# vdiffr 0.1.0

* Generated SVGs are now reproducible across platforms thanks to
  recent versions of svglite, gdtools, and the new package fontquiver.
  vdiffr now requires versions of FreeType greater than 2.6.1.

* The figures folder is hardcoded to `tests/figs/`.

* The figures are now stored in subfolders according to the current
  testthat context. `expect_doppelganger()` accepts the `path`
  argument to bypass this behaviour (set it to `""` to store the
  figures in `tests/figs/`).

* The `title` argument of `expect_doppelganger()` now serves as
  `ggtitle()` in ggplot2 figures (unless a title is already set). It
  is also standardised and used as filename to store the figure
  (spaces and non-alphanumeric characters are converted to dashes).

* Add support for handling orphaned cases: you can now remove figures
  left over from deleted tests with `delete_orphaned_cases()` or from
  the Shiny app.

* New `filter` argument to `collect_cases()` and `manage_cases()`.
  This lets you filter the test files from which to collect the cases,
  which is useful to speed up the collection for large codebases with
  a lot of unit tests.

* Fix invalid generation of SVG files (#3)

* Give a warning when multiple doppelgangers have the same name (#4).

* Remove CR line endings before comparing svg files for compatibility
  with Windows


# vdiffr 0.0.0.9000

Initial release
