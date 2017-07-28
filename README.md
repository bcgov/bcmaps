<!-- README.md is generated from README.Rmd. Please edit that file and re-knit-->
<a rel="Delivery" href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img alt="In production, but maybe in Alpha or Beta. Intended to persist and be supported." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/delivery.svg" title="In production, but maybe in Alpha or Beta. Intended to persist and be supported." /></a>

[![Travis-CI Build Status](https://travis-ci.org/bcgov/bcmaps.svg?branch=master)](https://travis-ci.org/bcgov/bcmaps)

------------------------------------------------------------------------

bcmaps
======

An [R](http://r-project.org) package of map layers for British Columbia.

### Features

Various layers of British Columbia, such as administrative boundaries, natural resource management boundaries, watercourses etc. All layers are available as [sp](http://cran.r-project.org/web/packages/sp/index.html) objects, and are in [BC Albers](http://spatialreference.org/ref/epsg/nad83-bc-albers/) projection, which is the [B.C. Government standard](https://www.for.gov.bc.ca/hts/risc/pubs/other/mappro/index.htm).

### Installation

The package is not available on CRAN, but can be installed using the [devtools](https://github.com/hadley/devtools) package:

``` r
install.packages("devtools") # if not already installed

library(devtools)
install_github("bcgov/bcmaps", build_vignettes = TRUE)
```

### Usage

At the moment, there are sixteen layers available:

-   `bc_bound`: Coarse provincial boundary of British Columbia (1:7.5M scale).

-   `bc_bound_hres`: Detailed provincial boundary of British Columbia from Statistics Canada.

-   `regional_districts_analysis`: Detailed B.C. Regional District boundaries based on Canadian Census boundaries. Suitable for situations where you need detailed boundaries (faithful to the original representation).

-   `regional_districts_disp`: Simplified B.C. Regional District boundaries. Much smaller file size than the analysis layer, suitable for situations where you don't need detailed boundaries, often useful when making maps for display.

-   `ecoprovinces`: Boundaries of British Columbia's 10 ecoprovinces.

-   `ecoregions`: Boundaries of British Columbia's 43 ecoregions.

-   `airzones`: Boundaries of British Columbia's 7 Air Zones.

-   `nr_areas`: Boundaries of British Columbia's 3 Natural Resource (NR) Areas.

-   `nr_regions`: Boundaries of British Columbia's 8 Natural Resource (NR) Regions.

-   `nr_districts`: Boundaries of British Columbia's 24 Natural Resource (NR) Districts.

-   `watersheds`: Boundaries of British Columbia's hydrometric watersheds, delineated for Canada-British Columbia hydrometric stations.

-   `watercourses_15M`: Watercourses for British Columbia at 1:15M scale.

-   `watercourses_5M`: Watercourses for British Columbia at 1:5M scale.

-   `gw_aquifers`: Boundaries of British Columbia's developed ground water aquifers (that have been mapped).

-   `water_districts`: Boundaries of British Columbia's Water Management Districts.

-   `water_precincts`: Boundaries of British Columbia's Water Management Precincts.

-   `hydrozones`: Hydrologic Zone Boundaries of British Columbia.

-   `wsc_drainages`: Water Survey of Canada Sub-Sub-Drainage Areas.

To load any of them, simply type `data(layer_name)`, where `layer_name` is the name of the layer of interest. Then you can use the data as you would any `sp` object.

A couple of simple examples:

``` r
library(bcmaps)
#> Loading required package: sp

# Load and plot the boundaries of B.C.
data(bc_bound)
plot(bc_bound)
```

![](README-plot-maps-1.png)

``` r

## Next load the Regional Districts data, then extract and plot the Kootenays
data(regional_districts_disp)
kootenays <- regional_districts_disp[grep("Kootenay", 
                                          regional_districts_disp$region_name), ]
plot(kootenays)
text(coordinates(kootenays), 
     labels = kootenays$region_name, cex = 0.6)
```

![](README-plot-maps-2.png)

#### Plot watercourses in British Columbia at a course scale

``` r

# Load watercourse data and plot with boundaries of B.C.
data(watercourses_15M)
plot(bc_bound)
plot(watercourses_15M, add = TRUE)
```

![](README-unnamed-chunk-4-1.png)

#### Size of British Columbia

There is also a simple function that returns the size of B.C. in various units. You can choose total area, land area only, or freshwater area only:

``` r
bc_area("total", "ha")
#> total_ha 
#> 94473500

bc_area("land", "m2")
#>     land_m2 
#> 9.25186e+11

bc_area("freshwater", "km2")
#> freshwater_km2 
#>          19549
```

#### Vignettes

We have written a short vignette on plotting points on one of the layers from `bcmaps`. You can view the vignette online [here](/vignettes/add_points.md) or if you installed the package using `devtools::install_github("bcgov/bcmaps", build_vignettes = TRUE)` you can open it using `browseVignettes("bcmaps")`.

### Project Status

Further development of the `bcmaps` package is on hold until the enhancements outlined in [Issue \#2](https://github.com/bcgov/bcmaps/issues/2) and [\#21](https://github.com/bcgov/bcmaps/issues/21) are implemented. We are hoping to tackle these in 2018.

If you are using the new [R package sf](https://cran.r-project.org/web/packages/sf/index.html), you can convert the `bcmaps` [sp](https://cran.r-project.org/web/packages/sp/index.html) objects to `sf` objects with `sf::st_as_sf()`

``` r
install.packages("sf") # if not already installed

library(sf)
bc_bound_sf <- st_as_sf(bcmaps::bc_bound)
```

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/bcmaps/issues/).

### How to Contribute

Pull requests of new B.C. layers are welcome. If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### Source Data

The source datasets used in this package come from various sources under open licences, including [DataBC](http://data.gov.bc.ca) ([Open Government Licence - British Columbia](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61)) and [Statistics Canada](http://www.statcan.gc.ca/start-debut-eng.html) ([Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng)). See the `data-raw` folder for details on each source dataset.

### License

The data and code in this repository is licenced under multiple licences.

-   All R code in the `/R` directory and the `/data-raw` directory is licenced under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). See LICENSE.Apache-2.0 in the appropriate directories.

-   Source data in `/data-raw/bc_bound` is licenced under the [Open Government Licence - Canada version 2.0](http://open.canada.ca/en/open-government-licence-canada). See LICENSE.Canada-OGL-2.0 in the appropriate directory.

-   Source data in `/data-raw/census-divisions_statscan` is licenced under the [Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng). See LICENSE.StatsCan-OLA in the appropriate directory.

-   Source data in `/data-raw/prov_territories_statscan` is licenced under the [Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng). See LICENSE.StatsCan-OLA in the appropriate directory.

-   Source data in `/data-raw/ecoprovinces` and `/data-raw/ecoregions` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/airzones` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/nr_areas`, `/data-raw/nr_regions` and `/data-raw/nr_districts` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/watershed_boundaries` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/hydrozones` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/canvec_15M_hydro` and `/data-raw/canvec_5M_hydro` is licenced under the [Open Government Licence - Canada version 2.0](http://open.canada.ca/en/open-government-licence-canada). See LICENSE.Canada-OGL-2.0 in the appropriate directory.

-   Source data in `/data-raw/gw_aquifers`, `/data-raw/water_districts` and `/data-raw/water_precincts` is licenced under the [Open Government Licence - British Columbia version 2.0](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). See LICENSE.OGL-vbc2.0.pdf in the appropriate directory.

-   Source data in `/data-raw/wsc_drainages` is licenced under the [Open Government Licence - Canada version 2.0](http://open.canada.ca/en/open-government-licence-canada). See LICENSE.Canada-OGL-2.0 in the appropriate directory.

This repository is maintained by [Environmental Reporting BC](http://www2.gov.bc.ca/gov/content?id=FF80E0B985F245CEA62808414D78C41B). Click [here](https://github.com/bcgov/EnvReportBC-RepoList) for a complete list of our repositories on GitHub.
