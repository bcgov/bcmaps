# Overlay a SpatialPolygonsDataFrame or sf polygons layer on a raster layer and clip the raster to each polygon. Optionally done in parallel

Overlay a SpatialPolygonsDataFrame or sf polygons layer on a raster
layer and clip the raster to each polygon. Optionally done in parallel

## Usage

``` r
raster_by_poly(
  raster_layer,
  poly,
  poly_field,
  summarize = FALSE,
  parallel = FALSE
)
```

## Arguments

- raster_layer:

  the raster layer

- poly:

  a `SpatialPolygonsDataFrame` layer or `sf` layer

- poly_field:

  the field on which to split the `SpatialPolygonsDataFrame`

- summarize:

  Should the function summarise the raster values in each polygon to a
  vector? Default `FALSE`

- parallel:

  process in parallel? Default `FALSE`. If `TRUE`, it is up to the user
  to call
  [`future::plan()`](https://future.futureverse.org/reference/plan.html)
  (or set
  [options](https://future.futureverse.org/reference/zzz-future.options.html))
  to specify what parallel strategy to use.

## Value

a list of `RasterLayers` if `summarize = FALSE` otherwise a list of
vectors.
