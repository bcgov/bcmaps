# Get or calculate the attribute of a list-column containing nested dataframes.

**\[defunct\]**

This function is defunct as of bcmaps 2.0.0.

## Usage

``` r
get_poly_attribute(x, col, fun, ...)
```

## Arguments

- x:

  the list-column in the (SpatialPolygons)DataFrame that contains nested
  data.frames

- col:

  the column in the nested data frames from which to retrieve/calculate
  attributes

- fun:

  function to determine the resulting single attribute from overlapping
  polygons

- ...:

  other parameters passed on to `fun`

## Value

An atomic vector of the same length as x
