# bcmaps 0.16.0
* Added two new functions: `raster_by_poly` to overlay a SpatialPolygonsDataFrmae or sf polygons layer on a raster layer and clip the raster to each polygon, and `summarize_raster_list` to summarize the results of `raster_to_poly`

# bcmaps 0.15.1
* `get_layer()` now only accepts characters (#31)
* Fixes bug in `check_write_to_data_dir` where it was not creating data directory
* Update README installation instructions so that vignettes aren't built before bcmaps.rdata is installed (#29)


# bcmaps 0.15.0
* Added the ability to download Biogeoclimatic Zone map - as it was too big to 
fit in the bcmaps.rdata package, it is hosted as an asset on a GitHub release of bcmaps.rdata, 
and downloaded via the function `bec()`, which uses the new function `get_big_data()` (#28).
* Added function `bec_colours()` (and alias `bec_colors()`) to generate a vector of colours 
that match the standard colours used to colour Biogeoclimatic Zone maps.

# bcmaps 0.14.0
* Changed the lookup for exported objected to `getNamespaceExports("bcmaps")` so that you can 
call layers without loading the package via `bcmaps::`
* Removed `watersheds` layer from package
* Added `ecosections` to package

# bcmaps 0.13.0

This is a major new release with breaking changes. 

All data has been removed from the `bcmaps` package and moved to the `bcmaps.rdata` 
package, which is hosted on the bcgov drat repository: https://github.com/bcgov/drat. 
That package must be installed in order for `bcmaps` to access the data. It can 
be installed with: `install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')`

In previous versions of `bcmaps`, data was stored in the package and loaded by 
calling `data("layername")` or simply `layername` (e.g., `data("bc_bound")` or `bc_bound`).

Now loading data requires a function call - either using a shortcut function that
is the same name as the dataset (e.g., `bc_bound()` whereas previously one would 
simply use `bc_bound`). Alternatively, one can use the `get_layer()` function 
(e.g., `get_layer("bc_bound")`).

Another major change is that all the layers are now returned as `sf` classes by 
default, rather than `Spatial` classes. `Spatial` versions of the data can still be
obtained by setting the `class` argument to `"sp"` in `get_layer()` and the shortcut
functions (E.g., `bc_bound(class = "sp")` or `get_layer("bc_bound", class = "sp")`).

# bcmaps 0.12.0

* Added `wsc_drainages`

# bcmaps 0.11.0

* Added `hydrozones` dataset.

# bcmaps 0.10.1

* Fixed ring self-intersctions in `bc_bound_hres` and `airzones` (#13)

# bcmaps 0.10.0

* Added `water_districts` and `water_precincts` datasets.

# bcmaps 0.9.0

* Added `gw_aquifers` dataset.

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
