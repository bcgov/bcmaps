# Get Canadian Digital Elevation Model (CDED) as a `raster` object

**\[deprecated\]**.

## Usage

``` r
cded_raster(
  aoi = NULL,
  tiles_50K = NULL,
  .predicate = sf::st_intersects,
  dest_vrt = tempfile(fileext = ".vrt"),
  ask = interactive(),
  check_tiles = TRUE,
  ...
)
```

## Arguments

- aoi:

  Area of Interest. Currently supports sf and sp polygons, stars and
  raster objects.

- tiles_50K:

  a character vector of 1:50,000 NTS mapsheet tiles

- .predicate:

  geometry predicate function used to find the mapsheets from your aoi.
  Default
  [sf::st_intersects](https://r-spatial.github.io/sf/reference/geos_binary_pred.html).

- dest_vrt:

  The location of the vrt file. Defaults to a temporary file, but can be
  overridden if you'd like to save it for a project

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- check_tiles:

  Should the tiles that you already have in your cache be checked to see
  if they need updating? Default `TRUE`. If you are running the same
  code frequently and are confident the tiles haven't changed, setting
  this to `FALSE` will speed things up.

- ...:

  Further arguments passed on to
  [raster::raster](https://rdrr.io/pkg/raster/man/raster.html)

## Value

a `raster` object of the cded tiles for the specified area of interest

## Examples

``` r
if (FALSE) { # \dontrun{
vic <- census_subdivision()[census_subdivision()$CENSUS_SUBDIVISION_NAME == "Victoria", ]
vic_cded <- cded_raster(aoi = vic)
} # }
```
