
# vdiffr

vdiffr is an extension to the package testthat that makes it easy to
test for visual regressions. It provides a Shiny app to manage failed
tests and visually compare a graphic to its expected output.


## Installation

Get the development version from github with:

```{r}
# install.packages("devtools")
devtools::install_github("lionel-/vdiffr")
```


## How to use vdiffr

### Adding expectations

vdiffr integrates with testthat through the `expect_doppelganger()`
expectation. It takes as argument:

- A figure. This can be a ggplot object, a recordedplot, a function to
  be called, or more generally any object with a `print` method.
- A name identifying the test case.
- Optionally, a path where to store the figures. By default, they are
  stored in `tests/figs/`.

```{r}
disp_hist_base <- function() hist(mtcars$disp)
disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()

vdiffr::expect_doppelganger(disp_hist_base, "disp-histogram-base")
vdiffr::expect_doppelganger(disp_hist_ggplot, "disp-histogram-ggplot")
```

### Running tests

You can run the tests the usual way, for example with
`devtools::test()`. New cases for which you just wrote an expectation
will be skipped. Failed tests will show as an error.


### Managing the tests

When you have added new test cases or detected regressions, you can
manage those from the R command line with the functions
`collect_cases()` and `validate_cases()`. However it's often more
comfortable to run the shiny application `manage_cases()`. With this
app you can:

- Check how a failed case differs from its expected output using three
  widgets: Toggle (click to swap the images), Slide and Diff. If you
  use Github, you may be familiar with [the last two](https://github.com/blog/817-behold-image-view-modes).

- Validate cases. You can do so groupwise (all new cases or all failed
  cases) or on a case by case basis. When you validate a failed case,
  the old expected output is replaced by the new one.

Both `manage_cases()` and `collect_cases()` take `package` as first
argument, the path to your package sources. This argument has exactly
the same semantics as in devtools. You can use vdiffr tools the same
way as you would use `devtools::check()`, for example. The default is
`"."`, meaning that the package is expected to be found in the current
folder.

All validated cases are stored in `tests/figs/` or in the path
specified as an option to `expect_doppelganger()`. This folder may be
handy to showcase the different graphs offered by your package. You
can also keep track of how your plots change as you tweak their layout
by checking the history on Github.


### RStudio integration

An addin to launch `manage_cases()` is provided with vdiffr. Use the
addin menu to launch the Shiny app in an RStudio dialog.

![RStudio addin](https://raw.githubusercontent.com/lionel-/vdiffr/readme/rstudio-vdiffr.png)


## Dependency notes

vdiffr currently uses svglite to save the plots in a text format that
makes it easy to perform comparisons. This makes the test cases
dependent on that package as the SVG translation of the plot may
change across different versions of svglite (though that should not
happen often). For this reason, whenever you validate a graphical test
case, your `DESCRIPTION` file is updated with a note containing the
svglite version. This works the same way as the roxygen version note.

Your graphics might be dependent on other packages besides svglite. If
your package is an extension to ggplot2 for instance, the appearance
of your plot may change as ggplot2 evolves (as with the 2.0 version
which tweaked the grayness of the background color among other
changes). For this reason, `expect_doppelganger()` adds a dependence
on ggplot2 when you supply a ggplot2 object. Next time you validate a
case, the `DESCRIPTION` file will be updated with a note describing
the ggplot2 version with which the tested plots were rendered. You can
also manually add a dependency on any other package by calling
`vdiffr::add_dependency()` anywhere in a test file.


## Configuration

### Changing default figures folder

By default, figures will be stored in `tests/figs/`. You can change
this path by providing the `path` argument to
`expect_doppelganger()`. To set it globally, just write a small
wrapper in a testthat helper file. Helper files have names starting
with `helper-` and are executed before the unit tests.

```{r}
default_path <- "path/default/"
this_path <- "path/this/"
that_path <- "path/that/"

expect_doppelganger <- function(fig, fig_name) {
  vdiffr::expect_doppelganger(fig, fig_name, default_path)
}

expect_doppelganger_this <- function(fig, fig_name) {
  vdiffr::expect_doppelganger(fig, fig_name, this_path)
}

expect_doppelganger_that <- function(fig, fig_name) {
  vdiffr::expect_doppelganger(fig, fig_name, that_path)
}
```


## Implementation

### testthat Reporter

vdiffr extends testthat through a custom `Reporter`.
[Reporters](https://github.com/hadley/testthat/blob/master/R/reporter.R)
are classes (R6 classes in recent versions of testthat) whose
instances collect cases and output a summary of the tests. While
reporters are usually meant to provide output for the end user, you
can also use them in functions to interact with testthat.

vdiffr has a
[special reporter](https://github.com/lionel-/vdiffr/blob/master/R/testthat-reporter.R)
that does nothing but activate a collecter for the visual test
cases. `collect_cases()` calls `devtools::test()` with this
reporter. When `expect_doppelganger()` is called, it first checks
whether the case is new or failed. If that's the case, and if it finds
that vdiffr's collecter is active, it calls the collecter, which in
turns records the current test case.

This enables the user to run the tests with the usual development
tools and get feedback in the form of skipped or failed cases. On the
other hand, when vdiffr's tools are called, we collect information
about the tests of interest and wrap them in a data structure.


### SVG comparison

Comparing SVG files is convenient and should work correctly in most
situations. However, SVG is not suitable for tracking really subtle
changes and regressions. See
[vdiffr's issue #1](https://github.com/lionel-/vdiffr/issues/1) for a
discussion on this. vdiffr may gain additional comparison backends in
the future to make the tests more stringent.
