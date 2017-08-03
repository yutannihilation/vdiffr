This version fixes the errors on systems featuring FreeType 2.8.0. It
should also fix packages depending on vdiffr, such as ggstance.

The win-builder checks failed with this error:

```
Error in svglite_(file, bg, width, height, pointsize, standalone, aliases) :
  function 'gdtools_RcppExport_validate' not provided by package 'gdtools'
```

However I cannot reproduce this error on Appveyor or on R hub.


## Test environments

* local OS X install, R 3.4.1
* ubuntu 12.04 (on travis-ci), R 3.4.1 and devel
* Windows Server 2012 R2 x64 (on appveyor-ci), R 3.4.1
* win-builder (devel and release)


## R CMD check results

0 errors | 0 warnings | 0 notes


## Reverse dependencies

We ran R CMD check on all 5 reverse dependencies (summary at
https://github.com/lionel-/vdiffr/tree/master/revdep). No problems
were found.

We also run R CMD check for the ggstance package on a Debian system
featuring FreeType 2.8.0. This new version of vdiffr fixes the
ggstance failures.
