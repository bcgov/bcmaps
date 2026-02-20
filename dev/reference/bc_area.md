# The size of British Columbia

Total area, Land area only, or Freshwater area only, in the units of
your choosing.

## Usage

``` r
bc_area(what = "total", units = "km2")
```

## Arguments

- what:

  Which part of BC? One of `'total'` (default), `'land'`, or
  `'freshwater'`.

- units:

  One of `'km2'` (square kilometres; default), `'m2'` (square metres),
  `'ha'` (hectares), `'acres'`, or `'sq_mi'` (square miles)

## Value

The area of B.C. in the desired units (numeric vector).

## Details

The sizes are from [Statistics
Canada](https://www150.statcan.gc.ca/cgi-bin/tableviewer.pl?page=l01/cst01/phys01-eng.htm)

## Examples

``` r
## With no arguments, gives the total area in km^2:
bc_area()
#> total_km2 
#>    944735 

## Get the area of the land only, in hectares:
bc_area("land", "ha")
#>  land_ha 
#> 92518600 
```
