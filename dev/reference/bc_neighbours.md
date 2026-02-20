# Boundary of British Columbia, provinces/states and the portion of the Pacific Ocean that borders British Columbia

Boundary of British Columbia, provinces/states and the portion of the
Pacific Ocean that borders British Columbia

## Usage

``` r
bc_neighbours(ask = interactive(), force = FALSE)
```

## Source

`bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')`

## Arguments

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- force:

  Should you force download the data?

## Value

The spatial layer of `bc_neighbours` as an `sf` object

## Examples

``` r
if (FALSE) { # \dontrun{
my_layer <- bc_neighbours()
} # }
```
