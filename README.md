
<!-- README.md is generated from README.Rmd. Please edit that file and re-knit-->

# bcmaps <img src="tools/readme/bcmaps-sticker.png" height="139" align="right"/>

### Version 0.18.1

<!-- badges: start -->

[![dev](https://assets.bcdevexchange.org/images/badges/delivery.svg)](https://github.com/BCDevExchange/assets/blob/master/README.md)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![R build
status](https://github.com/bcgov/bcmaps/workflows/R-CMD-check/badge.svg)](https://github.com/bcgov/bcmaps/actions)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/bcmaps)](https://cran.r-project.org/package=bcmaps)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/bcmaps?color=brightgreen)](https://CRAN.R-project.org/package=bcmaps)
<!-- badges: end -->

## Overview

An [R](http://r-project.org) package of spatial map layers for British
Columbia.

## Features

Provides access to various spatial layers of British Columbia, such as
administrative boundaries, natural resource management boundaries,
watercourses etc. All layers are available in the [BC
Albers](http://spatialreference.org/ref/epsg/nad83-bc-albers/)
projection, which is the B.C. Government standard as `sf` or `Spatial`
objects.

Layers are stored in the
[bcmapsdata](https://github.com/bcgov/bcmapsdata) package and loaded by
this package, following the strategy recommended by [Anderson and
Eddelbuettel](https://journal.r-project.org/archive/2017/RJ-2017-026/index.html).

## Installation

You can install `bcmaps` from CRAN:

``` r
install.packages("bcmaps")
```

To install the development version of the `bcmaps` package, you need to
install the `remotes` package then the `bcmaps` package.

``` r
install.packages("remotes")
remotes::install_github("bcgov/bcmaps")
```

## Usage

To get full usage of the package, you will also need to install the
[**bcmapsdata**](https://github.com/bcgov/bcmapsdata) package, which
holds all of the datasets.

*Note that unlike most packages it is not necessary to actually load the
**bcmapsdata** package (i.e., with `library(bcmapsdata)`) - in fact it
is less likely to cause problems if you don’t.*

``` r
install.packages('bcmapsdata', repos='https://bcgov.github.io/drat/')
```

To see the layers that are available, run the `available_layers()`
function:

    #> Loading required package: sf
    #> Linking to GEOS 3.8.1, GDAL 2.4.4, PROJ 7.0.0

``` r
library(bcmaps)
available_layers()
```

Most layers are accessible by a shortcut function by the same name as
the object. Then you can use the data as you would any `sf` or `Spatial`
object. For example:

``` r
library(sf)

bc <- bc_bound()
plot(st_geometry(bc))
```

![](tools/readme/unnamed-chunk-7-1.png)<!-- -->

Alternatively, you can use the `get_layer` function - simply type
`get_layer('layer_name')`, where `'layer_name'` is the name of the layer
of interest. The `get_layer` function is useful if the back-end
`bcmapsdata` package has had a layer added to it, but there is as yet no
shortcut function created in `bcmaps`.

``` r
library(sf)
library(dplyr)

ws <- get_layer("wsc_drainages", class = "sf")

plot(ws["SUB_SUB_DRAINAGE_AREA_NAME"], key.pos = NULL)
```

![](tools/readme/unnamed-chunk-8-1.png)<!-- -->

### Simple Features objects

By default, all layers are returned as [`sf` spatial
objects](https://cran.r-project.org/package=sf):

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

![](tools/readme/plot-maps-1.png)<!-- -->

### It’s a beautiful day in the neighbourhood

A handy layer for creating maps for display is the `bc_neighbours`
layer, accessible with the function by the same name. This example also
illustrates using the popular [ggplot2](https://ggplot2.tidyverse.org/)
package to plot maps in R using `geom_sf`:

``` r
library(ggplot2)
ggplot() + 
  geom_sf(data = bc_neighbours(), mapping = aes(fill = name)) + 
  geom_sf(data = bc_cities()) +
  coord_sf(datum = NA) +
  scale_fill_discrete(name = "Jurisdiction") +
  theme_minimal()
```

![](tools/readme/bc_neighbours-1.png)<!-- -->

### Biogeoclimatic Zones

As of version 0.15.0 the B.C. BEC (Biogeoclimatic Ecosystem
Classification) map is available via the `bec()` function, and an
accompanying function `bec_colours()` function to colour it:

``` r
bec <- bec()
library(ggplot2)
ggplot() +
  geom_sf(data = bec[bec$ZONE %in% c("BG", "PP"),],
          aes(fill = ZONE, col = ZONE)) +
  scale_fill_manual(values = bec_colors()) +
  scale_colour_manual(values = bec_colours())
```

![](tools/readme/bec-1.png)<!-- -->

### Spatial (sp) objects

If you aren’t using the `sf` package and prefer the old standard
[`sp`](https://cran.r-project.org/package=sp) way of doing things, set
`class = "sp"` in either `get_layer` or the shortcut functions:

``` r
library("sp")
# Load watercourse data and plot with boundaries of B.C.
plot(get_layer("bc_bound", class = "sp"))
plot(watercourses_15M(class = "sp"), add = TRUE)
```

![](tools/readme/watercourses-1.png)<!-- -->

### Vignettes

After installing the package you can view vignettes by typing
`browseVignettes("bcmaps")` in your R session.

### Utility Functions

The package also contains a couple of handy utility functions:

1.  `fix_geo_problems()` for fixing invalid topologies in `sf` or
    `Spatial` objects such as orphaned holes and self-intersections
2.  `transform_bc_albers()` for transforming any `sf` or `Spatial`
    object to [BC Albers](https://epsg.io/3005) projection.
3.  `self_union()` Union a `SpatialPolygons*` object with itself to
    remove overlaps, while retaining attributes

## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/bcmaps/issues/).

## How to Contribute

Pull requests of new B.C. layers are welcome. If you would like to
contribute to the package, please see our
[CONTRIBUTING](https://github.com/bcgov/bcmaps/blob/master/CONTRIBUTING.md)
guidelines.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/bcgov/bcmaps/blob/master/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

## Source Data

The source datasets used in this package come from various sources under
open licences, including [DataBC](http://data.gov.bc.ca) ([Open
Government Licence - British
Columbia](http://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61))
and [Statistics Canada](http://www.statcan.gc.ca/start-debut-eng.html)
([Statistics Canada Open Licence
Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng)). See the
`data-raw` folder for details on each source dataset.

## Licence

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

This repository is maintained by [Environmental Reporting
BC](http://www2.gov.bc.ca/gov/content?id=FF80E0B985F245CEA62808414D78C41B).
Click [here](https://github.com/bcgov/EnvReportBC-RepoList) for a
complete list of our repositories on GitHub.
