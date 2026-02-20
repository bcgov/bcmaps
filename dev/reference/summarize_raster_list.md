# Summarize a list of rasters into a list of numeric vectors

Summarize a list of rasters into a list of numeric vectors

## Usage

``` r
summarize_raster_list(raster_list, parallel = FALSE)
```

## Arguments

- raster_list:

  list of rasters

- parallel:

  process in parallel? Default `FALSE`. If `TRUE`, it is up to the user
  to call
  [`future::plan()`](https://future.futureverse.org/reference/plan.html)
  (or set
  [options](https://future.futureverse.org/reference/zzz-future.options.html))
  to specify what parallel strategy to use.

## Value

a list of numeric vectors
