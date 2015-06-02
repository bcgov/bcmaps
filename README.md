<a rel="Exploration" 
href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img
alt="Being designed and built, but in the lab. May change, disappear, or be 
buggy." style="border-width:0" src="http://bcdevexchange.org/badge/2.svg" 
title="Being designed and built, but in the lab. May change, disappear, or be 
buggy." /></a>

---

# bcmaps

An [R](http://r-project.org) package of map layers for British Columbia

### Features

Various layers of B.C., including administrative boundaries, natural resource 
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

### License

    Copyright 2015 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
