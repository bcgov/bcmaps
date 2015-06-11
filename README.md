<div id="devex-badge">
<a rel="Exploration" 
href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img
alt="Being designed and built, but in the lab. May change, disappear, or be 
buggy." style="border-width:0" src="http://bcdevexchange.org/badge/2.svg" 
title="Being designed and built, but in the lab. May change, disappear, or be 
buggy." /></a>
</div>

---

# bcmaps

An [R](http://r-project.org) package of map layers for British Columbia

### Features

Various layers of B.C., such as administrative boundaries, natural resource 
management boundaries, etc. All layers are available as [sp](http://cran.r-project.org/web/packages/sp/index.html) objects, and are in 
[BC Albers](http://spatialreference.org/ref/epsg/nad83-bc-albers/) projection, which is the [B.C. government standard](https://www.for.gov.bc.ca/hts/risc/pubs/other/mappro/index.htm).

### Installation

The package is not available on CRAN, but can be installed using
the [devtools](https://github.com/hadley/devtools) package:

``` r 
install.packages("devtools") # if not already installed

library(devtools)
install_github("bcgov/rcaaqs")

```

### Usage

### Project Status

Under active development, we will add different layers iteratively.

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/bcmaps/issues/).

### How to Contribute

Pull requests of new B.C. layers are welcome.
If you would like to contribute to the package, please see our 
[CONTRIBUTING](CONTRIBUTING.md) guidelines.

### Source data
The source datasets used in this package come from various sources under open licenses, including [DataBC](http://data.gov.bc.ca) ([Open Government License - British Columbia](http://www.data.gov.bc.ca/local/dbc/docs/license/OGL-vbc2.0.pdf)) and [Statistics Canada](http://www.statcan.gc.ca/start-debut-eng.html) ([Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng)). See the `data-raw` folder for details on each source dataset.

### License

The data and code in this repository is licensed under multiple licenses.

- All R code in the /R directory and the /data-raw directory is licensed under the Apache License 2.0. See LICENSE.Apache-2.0 in the appropriate directories.

- Source data in /data-raw/bc_bound is licensed under the Open Government License - Canada. See LICENSE.Canada-OGL-2.0 in the appropriate directory.

- Source data in /data-raw/census-divisions_statscan is licensed under the Statistics Canada Open License Agreement. See LICENSE.StatsCan-OLA in the appropriate directory.

- Source data in /data-raw/airzones is licensed under the Open Government License - British Columbia. See LICENSE.BC-OGL in the appropriate directory.
