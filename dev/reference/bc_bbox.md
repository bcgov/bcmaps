# Get an extent/bounding box for British Columbia

Get an extent/bounding box for British Columbia

## Usage

``` r
bc_bbox(class = c("sf", "raster"), crs = 3005)
```

## Arguments

- class:

  `"sf"`, `"raster"`.

- crs:

  coordinate reference system: integer with the EPSG code, or character
  with proj4string. Default `3005` (BC Albers).

## Value

an object denoting a bounding box of British Columbia, of the
corresponding class specified in `class`.

## Examples

``` r
if (FALSE) { # \dontrun{
  bc_bbox("sf")
  bc_bbox("raster")
  } # }
```
