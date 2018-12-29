# bayesplot

Version: 1.6.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.2Mb
      sub-directories of 1Mb or more:
        R     2.5Mb
        doc   4.0Mb
    ```

# blorr

Version: 0.2.0

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘lmtest’
    ```

# cicero

Version: 1.0.14

## In both

*   R CMD check timed out
    

*   checking R code for possible problems ... NOTE
    ```
    aggregate_nearby_peaks: no visible binding for global variable 'val'
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/cicero/new/cicero.Rcheck/00_pkg_src/cicero/R/aggregate.R:37)
    assemble_connections: no visible binding for global variable 'value'
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/cicero/new/cicero.Rcheck/00_pkg_src/cicero/R/runCicero.R:640-641)
    find_overlapping_ccans: no visible binding for global variable 'CCAN'
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/cicero/new/cicero.Rcheck/00_pkg_src/cicero/R/runCicero.R:919-922)
    generate_windows: no visible binding for global variable 'V1'
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/cicero/new/cicero.Rcheck/00_pkg_src/cicero/R/runCicero.R:663-667)
    plot_accessibility_in_pseudotime: no visible binding for global
      variable 'f_id'
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/cicero/new/cicero.Rcheck/00_pkg_src/cicero/R/plotting.R:676-695)
    Undefined global functions or variables:
      CCAN V1 f_id val value
    ```

# dabestr

Version: 0.1.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
    The following objects are masked from 'package:stats':
    
        filter, lag
    
    The following objects are masked from 'package:base':
    
        intersect, setdiff, setequal, union
    
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "Rubik Medium"
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "Rubik Medium"
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "Rubik Medium"
    Warning in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  :
      no font could be found for family "Work Sans Medium"
    Quitting from lines 72-103 (bootstrap-confidence-intervals.Rmd) 
    Error: processing vignette 'bootstrap-confidence-intervals.Rmd' failed with diagnostics:
    polygon edge not found
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        doc   4.5Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grid’
      All declared Imports should be used.
    ```

# epiflows

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘htmlwidgets’
      All declared Imports should be used.
    ```

# fingertipscharts

Version: 0.0.3

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘mapproj’
      All declared Imports should be used.
    ```

# GenVisR

Version: 1.14.1

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘GenVisR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: Lolliplot-class
    > ### Title: Class Lolliplot
    > ### Aliases: Lolliplot-class Lolliplot
    > 
    > ### ** Examples
    > 
    > # Load a pre-existing data set
    > dataset <- PIK3CA
    > 
    > # mode 1, amino acid changes are not present
    > 
    > library(TxDb.Hsapiens.UCSC.hg38.knownGene)
    Error in library(TxDb.Hsapiens.UCSC.hg38.knownGene) : 
      there is no package called ‘TxDb.Hsapiens.UCSC.hg38.knownGene’
    Execution halted
    ```

*   checking tests ...
    ```
    ...
      4. Error: (unknown) (@test-genCov_qual.R#1) 
      
      Error: testthat unit tests failed
      Execution halted
    Running the tests in ‘tests/vdiffr.[rR]’ failed.
    Last 13 lines of output:
      : MC4wMHw3MjAuMDB8NTc2LjAwfDAuMDA=)' />                                         
      < <g clip-path='url(#cpMHw3MjB8NTc2fDA=)'><text x='630.20' y='280.62' style='fon
      : t-size: 8.80px; font-family: Liberation Sans;' textLength='75.03px' lengthAdju
      : st='spacingAndGlyphs'>Missense Mutation</text></g>                            
      > <g clip-path='url(#cpMC4wMHw3MjAuMDB8NTc2LjAwfDAuMDA=)'><text x='628.54' y='28
      : 2.24' style='font-size: 8.80px; font-family: Liberation Sans;' textLength='73.
      : 33px' lengthAdjust='spacingAndGlyphs'>Missense Mutation</text></g>            
      < <g clip-path='url(#cpMHw3MjB8NTc2fDA=)'><text x='630.20' y='297.90' style='fon
      : t-size: 8.80px; font-family: Liberation Sans;' textLength='19.00px' lengthAdju
      : st='spacingAndGlyphs'>RNA</text></g>                                          
      > <g clip-path='url(#cpMC4wMHw3MjAuMDB8NTc2LjAwfDAuMDA=)'><text x='628.54' y='29
      : 9.52' style='font-size: 8.80px; font-family: Liberation Sans;' textLength='18.
      : 59px' lengthAdjust='spacingAndGlyphs'>RNA</text></g>                          
        </svg>                                                                        
      
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    genome specified is preloaded, retrieving data...
    Argument not supplied to target, defaulting to predefined identity SNPs from hg19 assembly!
    Obtaining CDS Coordinates
    This function is part of the new S4 feature and is under active development
    This function is part of the new S4 feature and is under active development
    Warning in .local(object, labelColumn, verbose, ...) :
      Removed 1212 rows from the data which harbored duplicate genomic locations
    Warning in .local(object, labelColumn, verbose, ...) :
      Removed 1212 rows from the data which harbored duplicate genomic locations
    Warning in .local(object, labelColumn, verbose, ...) :
      Removed 1212 rows from the data which harbored duplicate genomic locations
    Warning in .local(object, labelColumn, verbose, ...) :
      Removed 1212 rows from the data which harbored duplicate genomic locations
    Warning in setMutationHierarchy(object, mutationHierarchy, verbose) :
      The following mutations were found in the input however were not specified in the mutationHierarchy! upstream_gene_variant, splice_region_variant,non_coding_transcript_exon_variant, intron_variant,non_coding_transcript_variant, downstream_gene_variant, non_coding_transcript_exon_variant, 5_prime_UTR_variant, intron_variant, stop_lost, regulatory_region_variant, 3_prime_UTR_variant, intron_variant,NMD_transcript_variant, missense_variant,NMD_transcript_variant, inframe_insertion, inframe_deletion, frameshift_variant, 3_prime_UTR_variant,NMD_transcript_variant, splice_acceptor_variant,non_coding_transcript_variant, missense_variant,splice_region_variant,NMD_transcript_variant, synonymous_variant, synonymous_variant,NMD_transcript_variant, splice_donor_variant,non_coding_transcript_variant, start_lost, stop_gained,NMD_transcript_variant, 5_prime_UTR_variant,NMD_transcript_variant adding these in as least important and assigning random colors!
    Warning in .local(object, labelColumn, verbose, ...) :
      Removed 1212 rows from the data which harbored duplicate genomic locations
    Quitting from lines 224-233 (Upcoming_Features.Rmd) 
    Error: processing vignette 'Upcoming_Features.Rmd' failed with diagnostics:
    there is no package called 'BSgenome.Hsapiens.UCSC.hg19'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘BSgenome.Hsapiens.UCSC.hg19’ ‘TxDb.Hsapiens.UCSC.hg19.knownGene’
      ‘TxDb.Hsapiens.UCSC.hg38.knownGene’ ‘BSgenome.Hsapiens.UCSC.hg38’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 16.2Mb
      sub-directories of 1Mb or more:
        R         3.1Mb
        doc      11.5Mb
        extdata   1.0Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘reshape2’
      All declared Imports should be used.
    ```

*   checking R code for possible problems ... NOTE
    ```
    setTierTwo,data.table : a: no visible binding for global variable ‘tmp’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/GenVisR/new/GenVisR.Rcheck/00_pkg_src/GenVisR/R/Lolliplot-class.R:969)
    toLolliplot,GMS: no visible binding for global variable ‘missingINdex’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/GenVisR/new/GenVisR.Rcheck/00_pkg_src/GenVisR/R/GMS-class.R:536-537)
    Undefined global functions or variables:
      missingINdex tmp
    ```

# ggcyto

Version: 1.10.0

## Newly broken

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
      sub-directories of 1Mb or more:
        doc   5.5Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘scales’
      All declared Imports should be used.
    ':::' call which should be '::': ‘flowWorkspace:::isNegated’
      See the note in ?`:::` about the use of this operator.
    Unexported objects imported by ':::' calls:
      ‘flowWorkspace:::.mergeGates’ ‘flowWorkspace:::compact’
      ‘flowWorkspace:::fix_y_axis’ ‘ggplot2:::+.gg’ ‘ggplot2:::add_group’
      ‘ggplot2:::as_gg_data_frame’ ‘ggplot2:::check_aesthetics’
      ‘ggplot2:::is.waive’ ‘ggplot2:::is_calculated_aes’
      ‘ggplot2:::make_labels’ ‘ggplot2:::make_scale’ ‘ggplot2:::plot_clone’
      ‘ggplot2:::print.ggplot’ ‘ggplot2:::scales_add_defaults’
      ‘ggplot2:::scales_list’ ‘ggplot2:::update_theme’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    ggcyto.flowSet: no visible binding for global variable ‘name’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_flowSet.R:61)
    ggcyto.flowSet: no visible binding for global variable ‘axis’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_flowSet.R:63-64)
    ggcyto.flowSet: no visible binding for global variable ‘name’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_flowSet.R:63-64)
    ggcyto.ncdfFlowList: no visible global function definition for
      ‘getS3method’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_flowSet.R:103)
    ggcyto_arrange: no visible binding for global variable ‘name’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_GatingLayout.R:42)
    ggcyto_arrange: no visible binding for global variable ‘name’
      (/Users/lionel/Desktop/vdiffr/revdep/checks.noindex/ggcyto/new/ggcyto.Rcheck/00_pkg_src/ggcyto/R/ggcyto_GatingLayout.R:47)
    Undefined global functions or variables:
      approx axis density desc dist getS3method gray modifyList name
    Consider adding
      importFrom("grDevices", "gray")
      importFrom("graphics", "axis")
      importFrom("stats", "approx", "density", "dist")
      importFrom("utils", "getS3method", "modifyList")
    to your NAMESPACE file.
    ```

# ggExtra

Version: 0.8

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘grDevices’
      All declared Imports should be used.
    ```

# ggformula

Version: 0.9.0

## Newly broken

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.0Mb
      sub-directories of 1Mb or more:
        R     3.1Mb
        doc   2.7Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyr’
      All declared Imports should be used.
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘quantreg’
    ```

# ggplot2

Version: 3.1.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.3Mb
      sub-directories of 1Mb or more:
        R     3.8Mb
        doc   1.8Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘mgcv’ ‘reshape2’ ‘viridisLite’
      All declared Imports should be used.
    ```

# ggridges

Version: 0.5.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 6242 marked UTF-8 strings
    ```

# ggstatsplot

Version: 0.0.7

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        'x' must at least have 2 elements
      Warning: Proportion test will not be run because it requires x to have at least 
      2 levels with non-zero frequencies.
      Error in chisq.test(counts, p = expProps) : 
        'x' must at least have 2 elements
      ── 1. Failure: parametric t-test works (between-subjects without NAs) (@test_sub
      `using_function1` not equal to `results1`.
      target, current do not match when deparsed
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 653 SKIPPED: 0 FAILED: 1
      1. Failure: parametric t-test works (between-subjects without NAs) (@test_subtitle_t_parametric.R#63) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘glmmTMB’
      All declared Imports should be used.
    ```

# ggthemes

Version: 4.0.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 138 marked UTF-8 strings
    ```

# metR

Version: 0.2.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R      2.0Mb
        data   1.1Mb
        doc    1.5Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘curl’
      All declared Imports should be used.
    ```

# projections

Version: 0.3.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘distcrete’
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

# tidybayes

Version: 1.0.3

## In both

*   checking tests ...
    ```
    ...
      1. Error: tidy_draws works with runjags (@test.tidy_draws.R#87) 
      
      Error: testthat unit tests failed
      Execution halted
    Running the tests in ‘tests/vdiffr.[rR]’ failed.
    Last 13 lines of output:
      : 0) rotate(-90)' style='font-size: 11.00px; font-family: Liberation Sans;' text
      : Length='27.53px' lengthAdjust='spacingAndGlyphs'>u_tau</text></g>             
      > <g clip-path='url(#cpMC4wMHw3MjAuMDB8NTc2LjAwfDAuMDA=)'><text transform='trans
      : late(13.04,297.18) rotate(-90)' style='font-size: 11.00px; font-family: Libera
      : tion Sans;' textLength='27.56px' lengthAdjust='spacingAndGlyphs'>u_tau</text><
      : /g>                                                                           
      < <g clip-path='url(#cpMHw3MjB8NTc2fDA=)'><text x='30.94' y='14.42' style='font-
      : size: 13.20px; font-family: Liberation Sans;' textLength='245.67px' lengthAdju
      : st='spacingAndGlyphs'>grouped pointintervals (stat, reverse order)</text></g> 
      > <g clip-path='url(#cpMC4wMHw3MjAuMDB8NTc2LjAwfDAuMDA=)'><text x='28.09' y='14.
      : 56' style='font-size: 13.20px; font-family: Liberation Sans;' textLength='249.
      : 05px' lengthAdjust='spacingAndGlyphs'>grouped pointintervals (stat, reverse or
      : der)</text></g>                                                               
        </svg>                                                                        
      
    ```

# tsmp

Version: 0.3.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        data   4.6Mb
    ```

# viridis

Version: 0.5.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
    ```

# visdat

Version: 0.5.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘plotly’ ‘rlang’
      All declared Imports should be used.
    ```

