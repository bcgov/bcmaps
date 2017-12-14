
<!-- README.md is generated from README.Rmd. Please edit that file and re-knit-->
bcmaps <img src="tools/readme/bcmaps-sticker.png" height="139" align="right"/>
==============================================================================

### Version 0.16.0

<a id="devex-badge" rel="Delivery" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="In production, but maybe in Alpha or Beta. Intended to persist and be supported." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/delivery.svg" title="In production, but maybe in Alpha or Beta. Intended to persist and be supported." /></a> [![Travis-CI Build Status](https://travis-ci.org/bcgov/bcmaps.svg?branch=master)](https://travis-ci.org/bcgov/bcmaps)

Overview
--------

An [R](http://r-project.org) package of spatial map layers for British Columbia.

Features
--------

Provides access to various spatial layers of British Columbia, such as administrative boundaries, natural resource management boundaries, watercourses etc. All layers are available in the [BC Albers](http://spatialreference.org/ref/epsg/nad83-bc-albers/) projection, which is the [B.C. Government standard](https://www.for.gov.bc.ca/hts/risc/pubs/other/mappro/index.htm) as `sf` or `Spatial` objects.

Layers are stored in the [bcmaps.rdata](https://github.com/bcgov/bcmaps.rdata) package and loaded by this package, following the strategy recommended by [Anderson and Eddelbuettel](https://journal.r-project.org/archive/2017/RJ-2017-026/index.html).

Installation
------------

The package is not available on CRAN, but can be installed from github:

``` r
# install.packages("devtools")
devtools::install_github("bcgov/bcmaps")
```

Usage
-----

To get full usage of the package, you will also need to install the [**bcmaps.rdata**](https://github.com/bcgov/bcmaps.rdata) package, which holds all of the datasets.

*Note that unlike most package it is not necessary to actually load the **bcmaps.rdata** package (i.e., with `library(bcmaps.rdata)`) - in fact it is less likely to cause problems if you don't.*

``` r
install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')
```

To see the layers that are available, run the `available_layers()` function:

``` r
library(bcmaps)
available_layers()
#>                  Item                                              Title
#> 1            airzones                         British Columbia Air Zones
#> 2            bc_bound                                        BC Boundary
#> 3       bc_bound_hres                      BC Boundary - High Resolution
#> 4        ecoprovinces                      British Columbia Ecoprovinces
#> 5          ecoregions                        British Columbia Ecoregions
#> 6         ecosections                       British Columbia Ecosections
#> 7         gw_aquifers British Columbia's developed ground water aquifers
#> 8          hydrozones     Hydrologic Zone Boundaries of British Columbia
#> 9      municipalities                    British Columbia Municipalities
#> 10           nr_areas       British Columbia Natural Resource (NR) Areas
#> 11       nr_districts   British Columbia Natural Resource (NR) Districts
#> 12         nr_regions     British Columbia Natural Resource (NR) Regions
#> 13 regional_districts                British Columbia Regional Districts
#> 14    water_districts      British Columbia's Water Management Districts
#> 15    water_precincts      British Columbia's Water Management Precincts
#> 16   watercourses_15M       British Columbia watercourses at 1:15M scale
#> 17    watercourses_5M        British Columbia watercourses at 1:5M scale
#> 18      wsc_drainages      Water Survey of Canada Sub-Sub-Drainage Areas
#>     shortcut_function
#> 1            airzones
#> 2            bc_bound
#> 3       bc_bound_hres
#> 4        ecoprovinces
#> 5          ecoregions
#> 6         ecosections
#> 7         gw_aquifers
#> 8          hydrozones
#> 9      municipalities
#> 10           nr_areas
#> 11       nr_districts
#> 12         nr_regions
#> 13 regional_districts
#> 14    water_districts
#> 15    water_precincts
#> 16   watercourses_15M
#> 17    watercourses_5M
#> 18      wsc_drainages
```

Most layers are accessible by a shortcut function by the same name as the object. Then you can use the data as you would any `sf` or `Spatial` object. For example:

``` r
library(sf)
#> Linking to GEOS 3.6.1, GDAL 2.1.3, proj.4 4.9.3

bc <- bc_bound()
plot(st_geometry(bc))
```

![](tools/readme/unnamed-chunk-5-1.png)

Alternatively, you can use the `get_layer` function - simply type `get_layer('layer_name')`, where `'layer_name'` is the name of the layer of interest. The `get_layer` function is useful if the back-end `bcmaps.rdata` package has had a layer added to it, but there is as yet no shortcut function created in `bcmaps`.

``` r
library(sf)
library(dplyr)

ws <- get_layer("wsc_drainages", class = "sf")

plot(ws["SUB_SUB_DRAINAGE_AREA_NAME"], key.pos = NULL)
```

![](tools/readme/unnamed-chunk-6-1.png)

### Simple Features objects

By default, all layers are returned as [`sf` spatial objects](https://cran.r-project.org/package=sf):

``` r
library(bcmaps)
library(sf)

# Load and plot the boundaries of B.C.

bc <- bc_bound()
plot(st_geometry(bc))

## Next load the Regional Districts data, then extract and plot the Kootenays
rd <- regional_districts()
kootenays <- rd[rd$ADMIN_AREA_NAME == "Regional District of Central Kootenay", ]
plot(st_geometry(kootenays), col = "lightseagreen", add = TRUE)
```

![](tools/readme/plot-maps-1.png)

### Spatial (sp) objects

If you aren't using the `sf` package and prefer the old standard [`sp`](https://cran.r-project.org/package=sp) way of doing things, set `class = "sp"` in either `get_layer` or the shortcut functions:

``` r
library("sp")
# Load watercourse data and plot with boundaries of B.C.
plot(get_layer("bc_bound", class = "sp"))
plot(watercourses_15M(class = "sp"), add = TRUE)
```

![](tools/readme/watercourses-1.png)

### Biogeoclimatic Zones

As of version 0.15.0 the B.C. BEC (Biogeoclimatic Ecosystem Classification) map is available via the `bec()` function, and an accompanying function `bec_colours()` function to colour it:

``` r
# This example requires the development version of ggplot2 which has the 
# `geom_sf()` function:
# remotes::install_github("tidyverse/ggplot2")
bec <- bec()
library(ggplot2)
ggplot() +
  geom_sf(data = bec[bec$ZONE %in% c("BG", "PP"),],
          aes(fill = ZONE, col = ZONE)) +
  scale_fill_manual(values = bec_colors()) +
  scale_colour_manual(values = bec_colours())
```

![](tools/readme/bec-1.png)

### Vignettes

We have written a short vignette on plotting points on one of the layers from `bcmaps`. You can view the vignette online [here](/vignettes/add_points.md) or if you installed the package using `devtools::install_github("bcgov/bcmaps", build_vignettes = TRUE)` you can open it using `browseVignettes("bcmaps")`.

### Utility Functions

The package also contains a couple of handy utility functions:

1.  `fix_geo_problems()` for fixing invalid topologies in `sf` or `Spatial` objects such as orphaned holes and self-intersections
2.  `transform_bc_albers()` for transforming any `sf` or `Spatial` object to [BC Albers](https://epsg.io/3005) projection.
3.  `self_union()` Union a `SpatialPolygons*` object with itself to remove overlaps, while retaining attributes

Project Status
--------------

Under active development

Getting Help or Reporting an Issue
----------------------------------

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/bcmaps/issues/).

How to Contribute
-----------------

Pull requests of new B.C. layers are welcome. If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

Source Data
-----------

The source datasets used in this package come from various sources under open licences, including [DataBC](http://data.gov.bc.ca) ([Open Government Licence - British Columbia](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61)) and [Statistics Canada](http://www.statcan.gc.ca/start-debut-eng.html) ([Statistics Canada Open Licence Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng)). See the `data-raw` folder for details on each source dataset.

Licence
-------

    # Copyright 2017 Province of British Columbia
    # 
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    # 
    # http://www.apache.org/licenses/LICENSE-2.0
    # 
    # Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and limitations under the License.

This repository is maintained by [Environmental Reporting BC](http://www2.gov.bc.ca/gov/content?id=FF80E0B985F245CEA62808414D78C41B). Click [here](https://github.com/bcgov/EnvReportBC-RepoList) for a complete list of our repositories on GitHub.
