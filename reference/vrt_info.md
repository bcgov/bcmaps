# Get metadata about a .vrt file

Get metadata about a .vrt file

## Usage

``` r
vrt_info(vrt, options = character(0), quiet = FALSE)
```

## Arguments

- vrt:

  path to a .vrt file

- options:

  options to pass to `gdalinfo`. See
  [here](https://gdal.org/en/stable/programs/gdalinfo.html) for possible
  options.

- quiet:

  suppress output to the console (default `FALSE`)

## Value

character of vrt metadata
