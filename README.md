sjmisc - Data Transformation and Labelled Data Utility Functions
------------------------------------------------------------------------------
This package contains utility functions that are useful when carrying out data analysis or basic statistical tests, performing common recode and data transformation tasks or working with labelled data (especially intended for people coming from 'SPSS' and/or who are new to R).

Basically, this package covers four domains of functionality:
* reading and writing data between other statistical packages (like 'SPSS') and R, based on the haven and foreign packages
* hence, this package also includes functions to make working with labelled data easier
* frequently used statistical tests and computation of statistical coefficients, or at least convenient wrappers for such test functions
* frequently applied recoding and variable transformation tasks


### Installation

#### Latest development build

To install the latest development snapshot (see latest changes below), type following commands into the R console:

```r
library(devtools)
devtools::install_github("sjPlot/sjmisc")
```

#### Officiale, stable release
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/sjmisc)](http://cran.r-project.org/package=sjmisc)
&#160;&#160;
[![downloads](http://cranlogs.r-pkg.org/badges/sjmisc)](http://cranlogs.r-pkg.org/)

To install the latest stable release from CRAN, type following command into the R console:

```r
install.packages("sjmisc")
```

### References, documentation and examples

- [Documentation and examples](http://www.strengejacke.de/sjPlot/)


### Citation

In case you want / have to cite my package, please use `citation('sjmisc')` for citation information. 


### Changelog of stable release 1.1

#### General
* Updated namespaces to meet new CRAN namespace requirements.
* Renamed `add_labels` to `copy_labels`.

#### New functions
* `get_na` to get value codes of missing values from labelled vectors (that have an `is_na` attribute).
* `to_na` to convert value codes of missing values from labelled vectors (that have an `is_na` attribute) into NA.
* `fill_labels` to add missing labels to non-labelled values of partially labelled vectors.
* `as_labelled` to convert vectors to labelled.
* `add_labels` to add additional value labels to a labelled vector.
* `zap_labels` and `zap_unlabelled` to convert (non-)labelled values into `NA`.
* `frq` to print summary and frequency tables for labelled-class objects.
* Added `labelled` method to create labelled class objects, including `is_na` attribute.
* Added S3-methods `is.na` and `mean` for labelled-class objects.

#### Changes to functions
* `std_beta` gets a `type` argument to compute standardized estimates following Gelman's approach by dividing estimates by two standard deviations.
* `se` now accepts fitted linear mixed model (from lme4) to compute standard errors for joint random and fixed effects.
* Added argument `attr.only` to `get_labels` to get value labels also of factor levels, if variable has no value label attributes.
* Argument `include.values` of `get_labels` has now two options for returning includes values.
* `get_labels` now supports vectors with string label attributes.
* `to_factor` and `to_value` better deal with vectors that don't need to be converted.
* `get_labels` gets a `include.non.labelled` argument to also return non-labelled values as label.
* `to_label` and `to_factor` get a `add.non.labelled` argument to also convert non-labelled values to labels.
* `set_labels` gets a `force.values` argument to add values without associated labels as labels, too.
* `set_na` gets a `as.attr` argument, so values are not converted to NA, but rather missing codes are added as `is_na` attribute.
* `get_values`, `to_label` and `to_factor` get a `drop.na` argument, to exclude values of missing codes from return value.
* Renamed argument `autoAttachVarLabels` of `read_spss` into `attach.var.labels`.
* Functions now better deal with mix of labelled and non-labelled values.

#### Deprecated
* `set_val_labels` is deprecated, use `set_labels`.
* `set_var_labels` is deprecated, use `set_label`.
* `get_val_labels` is deprecated, use `get_labels`.
* `get_var_labels` is deprecated, use `get_label`.
* `to_fac` is deprecated, use `to_factor`.
* `std_e` is deprecated, use `se`.
