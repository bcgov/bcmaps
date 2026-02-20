# Union a SpatialPolygons\* object with itself to remove overlaps, while retaining attributes

**\[defunct\]**

This function is defunct as of bcmaps 2.0.0. Use
[`raster::union()`](https://rdrr.io/r/base/sets.html) for
`SpatialPolygonsDataFrame`s, or
[`sf::st_union()`](https://r-spatial.github.io/sf/reference/geos_combine.html)
with `sf` objects instead.

## Usage

``` r
self_union(x)
```

## Arguments

- x:

  A `SpatialPolygons` or `SpatialPolygonsDataFrame` object

## Value

A `SpatialPolygons` or `SpatialPolygonsDataFrame` object
