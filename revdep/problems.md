# atlantistools

Version: 0.4.3

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    ------------
    ------------
    Running 'pdflatex  -halt-on-error -interaction=batchmode -recorder  "model-calibration.tex"'
    ------------
    Latexmk: applying rule 'pdflatex'...
    This is pdfTeX, Version 3.14159265-2.6-1.40.17 (TeX Live 2016) (preloaded format=pdflatex)
     restricted \write18 enabled.
    entering extended mode
    Collected error summary (may duplicate other messages):
      pdflatex: Command for 'pdflatex' gave return code 256
    Latexmk: Use the -f option to force complete processing,
     unless error was exceeding maximum runs of latex/pdflatex.
    Latexmk: Errors, so I did not complete making targets
    ! File ended while scanning use of \@@BOOKMARK.
    <inserted text> 
                    \par 
    l.107 \begin{document}
    
    Error: processing vignette 'model-calibration.Rmd' failed with diagnostics:
    Failed to compile model-calibration.tex. See model-calibration.log for more info.
    Execution halted
    ```

# bayesplot

Version: 1.5.0

## Newly broken

*   R CMD check timed out
    

## Newly fixed

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      7: value[[3L]](cond)
      8: stop(msg, call. = FALSE, domain = NA)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 735 SKIPPED: 18 FAILED: 7
      1. Error: (unknown) (@test-extractors.R#2) 
      2. Error: (unknown) (@test-mcmc-nuts.R#2) 
      3. Error: (unknown) (@test-mcmc-recover.R#2) 
      4. Error: (unknown) (@test-mcmc-scatter-and-parcoord.R#2) 
      5. Error: mcmc_trace 'np' argument works (@test-mcmc-traces.R#46) 
      6. Error: (unknown) (@test-ppc-discrete.R#2) 
      7. Error: (unknown) (@test-ppc-loo.R#2) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 18-20 (graphical-ppcs.Rmd) 
    Error: processing vignette 'graphical-ppcs.Rmd' failed with diagnostics:
    package or namespace load failed for 'rstanarm' in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
     there is no package called 'httpuv'
    Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        R     2.2Mb
        doc   3.6Mb
    ```

# ggExtra

Version: 0.8

## Newly broken

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    pandoc: Could not fetch http://www.r-pkg.org/badges/version/ggExtra
    TlsException (HandshakeFailed (Error_Protocol ("expecting server hello, got alert : [(AlertLevel_Fatal,HandshakeFailure)]",True,HandshakeFailure)))
    Error: processing vignette 'ggExtra.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 67
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
    ```

## Newly fixed

*   checking whether package ‘ggExtra’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/ggExtra/old/ggExtra.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘ggExtra’ ...
** package ‘ggExtra’ successfully unpacked and MD5 sums checked
** R
** inst
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
* DONE (ggExtra)

```
### CRAN

```
* installing *source* package ‘ggExtra’ ...
** package ‘ggExtra’ successfully unpacked and MD5 sums checked
** R
** inst
** preparing package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘httpuv’
ERROR: lazy loading failed for package ‘ggExtra’
* removing ‘/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/ggExtra/old/ggExtra.Rcheck/ggExtra’

```
# ggjoy

Version: 0.4.0

## In both

*   checking whether package ‘ggjoy’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘ggridges’ was built under R version 3.4.4
    See ‘/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/ggjoy/new/ggjoy.Rcheck/00install.out’ for details.
    ```

# ggridges

Version: 0.5.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 6242 marked UTF-8 strings
    ```

# ggstance

Version: 0.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘lazyeval’
      All declared Imports should be used.
    ```

# naniar

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘purrrlyr’
      All declared Imports should be used.
    ```

# olsrr

Version: 0.5.0

## Newly broken

*   R CMD check timed out
    

## Newly fixed

*   checking whether package ‘olsrr’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/olsrr/old/olsrr.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘olsrr’ ...
** package ‘olsrr’ successfully unpacked and MD5 sums checked
** libs
ccache g++-7 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/new/Rcpp/include" -I/usr/local/include   -fPIC  -arch x86_64  -ftemplate-depth-256  -Wall  -pedantic  -O0 -g -c RcppExports.cpp -o RcppExports.o
ccache gcc-7 -std=c99 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/new/Rcpp/include" -I/usr/local/include   -fPIC  -Wall  -pedantic -O0 -g -c init.c -o init.o
ccache g++-7 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/new/Rcpp/include" -I/usr/local/include   -fPIC  -arch x86_64  -ftemplate-depth-256  -Wall  -pedantic  -O0 -g -c tvar.cpp -o tvar.o
ccache g++-7 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o olsrr.so RcppExports.o init.o tvar.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/olsrr/new/olsrr.Rcheck/olsrr/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded
* DONE (olsrr)

```
### CRAN

```
* installing *source* package ‘olsrr’ ...
** package ‘olsrr’ successfully unpacked and MD5 sums checked
** libs
ccache g++-7 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/old/Rcpp/include" -I/usr/local/include   -fPIC  -arch x86_64  -ftemplate-depth-256  -Wall  -pedantic  -O0 -g -c RcppExports.cpp -o RcppExports.o
ccache gcc-7 -std=c99 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/old/Rcpp/include" -I/usr/local/include   -fPIC  -Wall  -pedantic -O0 -g -c init.c -o init.o
ccache g++-7 -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG  -I"/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/library.noindex/vdiffr/old/Rcpp/include" -I/usr/local/include   -fPIC  -arch x86_64  -ftemplate-depth-256  -Wall  -pedantic  -O0 -g -c tvar.cpp -o tvar.o
ccache g++-7 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o olsrr.so RcppExports.o init.o tvar.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/olsrr/old/olsrr.Rcheck/olsrr/libs
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘httpuv’
ERROR: lazy loading failed for package ‘olsrr’
* removing ‘/Users/lionel/Dropbox/Projects/R/lionel/vdiffr/revdep/checks.noindex/olsrr/old/olsrr.Rcheck/olsrr’

```
# projections

Version: 0.0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘distcrete’ ‘incidence’
      All declared Imports should be used.
    ```

# sicegar

Version: 0.2.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# viridis

Version: 0.5.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
    ```

