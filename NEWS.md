# bcmaps 0.8.3

* Fixed ring self-intersctions in `bc_bound_hres` and `airzones`

# bcmaps 0.8.2

* Added a `tries` argument to `fix_geo_problems` function to set the maximum number of iterations it should go through in attempting to repair topological issues.

# bcmaps 0.8.1

* Set character encoding of `watercourses_15M` and `watercourses_5M` datasets to UTF-8.

# bcmaps 0.8.0

* Added `watercourses_15M` and `watercourses_5M` datasets.

# bcmaps 0.7.1

* `fix_geo_problems` and `transform_bc_albers` are Generic functions with methods for `sf` objects as well as `Spatial` objects
* `fix_self_intersect` is now defunct

# bcmaps 0.6.2

* `fix_self_intersect` has been renamed to `fix_geo_problems` (but kept as an alias for now)
* `fix_geo_problems` can often also fix orphaned holes in addition to self-intersections.

# bcmaps 0.6.0

* Added `watersheds` dataset (#15, @markjohnsonubc)
* Added a `NEWS.md` file to track changes to the package.

# bcmaps 0.5.0

Added two new functions to create and work with SpatailPolygonsDataFrames with nested data frames:

- `self_union` performs a union on a single `SpatialPolygons*` object to take into account overlaps. Polygon attributes are combined in a nested dataframe.
- `get_poly_attribute` allows you to easily parse a nested data frame column (created by `self_union`) to extract or calculate the attributes you want

# bcmaps 0.4.0

Added a couple of convenience functions:

- `transform_bc_albers()` transforms a Spatial object to BC Albers projection
- `fix_self_intersect()` checks for and repairs self-intersecting polygons

# bcmaps 0.3.0

Added 3 Natural Resource layers (areas, regions and districts)

# bcmaps 0.2.0

Added high resolution BC boundaries (`bc_bound_hres`)

# bcmaps 0.1.0

Added `bc_area` function
