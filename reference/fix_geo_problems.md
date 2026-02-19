# Check and fix polygons that self-intersect, and sometimes can fix orphan holes

**\[defunct\]**.

This function is defunct as of bcmaps 2.0.0. For `sf` objects simply use
[`sf::st_make_valid()`](https://r-spatial.github.io/sf/reference/valid.html)

## Usage

``` r
fix_geo_problems(obj)
```

## Arguments

- obj:

  The SpatialPolygons\* or sf object to check/fix.

## Value

The `SpatialPolygons*` or `sf` object, repaired if necessary
