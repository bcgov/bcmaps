# Changelog

## bcmaps 2.3.0

- Added new census boundary layer:
  [`census_dissemination_block()`](http://bcgov.github.io/bcmaps/reference/census_dissemination_block.md)
  ([\#150](https://github.com/bcgov/bcmaps/issues/150)).
- Bumped minimum version of bcdata so no indirect dependency on
  soon-to-be-archived `leaflet.extras` package
  ([\#152](https://github.com/bcgov/bcmaps/issues/152))

## bcmaps 2.2.1

- In the `cded_()` functions, the `ask` argument, which controls if the
  user is asked to store data in the cache, was ignored. It is now
  respected ([\#147](https://github.com/bcgov/bcmaps/issues/147)).
- [`utm_convert()`](http://bcgov.github.io/bcmaps/reference/utm_convert.md)
  now respects `tibble` classes
  ([\#143](https://github.com/bcgov/bcmaps/issues/143),
  [\#148](https://github.com/bcgov/bcmaps/issues/148)).
- Fixed a bug in
  [`utm_convert()`](http://bcgov.github.io/bcmaps/reference/utm_convert.md)
  where new coordinates could be mismatched with the wrong rows from the
  input data frame.
  ([\#146](https://github.com/bcgov/bcmaps/issues/146),
  [\#148](https://github.com/bcgov/bcmaps/issues/148))

## bcmaps 2.2.0

- Added function
  [`utm_convert()`](http://bcgov.github.io/bcmaps/reference/utm_convert.md)
  to convert tabular data with X and Y coordinates in (possibly
  multiple) UTM zones to a single CRS.

## bcmaps 2.1.0

- Added function
  [`cded_terra()`](http://bcgov.github.io/bcmaps/reference/cded_terra.md)
- Deprecated function
  [`cded_raster()`](http://bcgov.github.io/bcmaps/reference/cded_raster.md) -
  this will be removed in a future version.

## bcmaps 2.0.0

### Removal of `sp` and `raster` support

We’ve removed support for the `sp` and `raster` packages, especially
those parts that require the use of the `rgdal` and `rgeos` packages,
which will be retired in October 2023. See the [r-spatial
blog](https://r-spatial.org/r/2022/04/12/evolution.html) for details of
this evolution.

- Removed the `class` argument in all of the data download functions:
  [`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
  and all of the wrapper shortcuts such as
  [`bc_bound()`](http://bcgov.github.io/bcmaps/reference/bc_bound.md),
  [`census_tract()`](http://bcgov.github.io/bcmaps/reference/census_tract.md),
  etc. These functions will now only return `sf` objects.
- The `Spatial` method of
  [`transform_bc_albers()`](http://bcgov.github.io/bcmaps/reference/transform_bc_albers.md)
  is removed.
- [`fix_geo_problems()`](http://bcgov.github.io/bcmaps/reference/fix_geo_problems.md)
  is removed. For `sf` objects simply use
  [`sf::st_make_valid()`](https://r-spatial.github.io/sf/reference/valid.html)
- [`self_union()`](http://bcgov.github.io/bcmaps/reference/self_union.md)
  is removed. Use [`raster::union()`](https://rdrr.io/r/base/sets.html)
  for `SpatialPolygonsDataFrame`s, or
  [`sf::st_union()`](https://r-spatial.github.io/sf/reference/geos_combine.html)
  with `sf` objects instead.
- [`get_poly_attribute()`](http://bcgov.github.io/bcmaps/reference/get_poly_attribute.md)
  is removed.
- [`raster_by_poly()`](http://bcgov.github.io/bcmaps/reference/raster_by_poly.md)
  is retained for now as it does not rely on `rgdal` or `rgeos`, just
  `sp` and `raster`, which are still being maintained.

### Documentation improvements

- Added a `pkgdown` site for `bcmaps` <https://bcgov.github.io/bcmaps/>
  ([\#63](https://github.com/bcgov/bcmaps/issues/63))
- Moved the detailed user documentation from the `README` to a Get
  Started with `bcmaps` article/vignette
  ([\#42](https://github.com/bcgov/bcmaps/issues/42))
- Better documentation for
  [`bc_bound_hres()`](http://bcgov.github.io/bcmaps/reference/bc_bound_hres.md)
  ([\#124](https://github.com/bcgov/bcmaps/issues/124))

## bcmaps 1.2.0

### Deprecation of `sp` and `raster` support

We’ve started the process of removing support for the `sp` and `raster`
packages, especially those parts of that require the use of the `rgdal`
and `rgeos` packages, which will be retired in October 2023. See the
[r-spatial blog](https://r-spatial.org/r/2022/04/12/evolution.html) for
details of this evolution. We will fully remove support for `Spatial`
classes (from package `sp`) in the next release in Summer 2023.

- Added deprecation warnings for the `class` argument in all of the data
  download functions:
  [`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
  and all of the wrapper shortcuts such as
  [`bc_bound()`](http://bcgov.github.io/bcmaps/reference/bc_bound.md),
  [`census_tract()`](http://bcgov.github.io/bcmaps/reference/census_tract.md),
  etc. This argument will be removed in the next version of `bcmaps` as
  these functions will only return `sf` objects.
- The `Spatial` method of
  [`transform_bc_albers()`](http://bcgov.github.io/bcmaps/reference/transform_bc_albers.md)
  is deprecated.
- [`fix_geo_problems()`](http://bcgov.github.io/bcmaps/reference/fix_geo_problems.md)
  is deprecated and will be removed completely in Summer

2023. For `sf` objects simply use
      [`sf::st_make_valid()`](https://r-spatial.github.io/sf/reference/valid.html)

- [`self_union()`](http://bcgov.github.io/bcmaps/reference/self_union.md)
  is deprecated and will be removed in Summer 2023. Use
  [`raster::union()`](https://rdrr.io/r/base/sets.html) for
  `SpatialPolygonsDataFrame`s, or
  [`sf::st_union()`](https://r-spatial.github.io/sf/reference/geos_combine.html)
  with `sf` objects instead.
- [`get_poly_attribute()`](http://bcgov.github.io/bcmaps/reference/get_poly_attribute.md)
  is deprecated because it had a very niche application for calculating
  attributes on a `SpatialPolygonsDataFrame`, which we are removing
  support for. It will be removed completely in Summer 2023.

## bcmaps 1.1.0

- `bec` and `tsa` layers are now downloaded directly from the BC Data
  Catalogue. This ensures that these are up-to-date and means that we do
  not rely on the manual updating of these layers at
  <https://github.com/bcgov/bcmapsdata>.
  ([\#62](https://github.com/bcgov/bcmaps/issues/62),
  [\#115](https://github.com/bcgov/bcmaps/issues/115))
- Package startup message about no longer needing the `bcmapsdata`
  package has been removed.

## bcmaps 1.0.3

- New behaviour of shortcut functions ensures that all spatial objects
  (`sf` or `Spatial`) returned are topologically valid and in the
  standard CRS of “EPSG:3005” (BC Albers).
  [\#96](https://github.com/bcgov/bcmaps/issues/96)
- More robust behaviour of getting and checking cache of `cded` files.

## bcmaps 1.0.2

- New helper function
  [`show_cached_files()`](http://bcgov.github.io/bcmaps/reference/delete_cache.md)
  to show the files that you have cached (and how much space they’re
  taking up on your computer).
  ([\#92](https://github.com/bcgov/bcmaps/issues/92),
  [\#93](https://github.com/bcgov/bcmaps/issues/93))

## bcmaps 1.0.1

- When R version is \>= 4.0, bcmaps will use
  `tools::R_user_dir("bcmaps", "cache")` to determine the cache
  directory, while when R version is \< 4.0, it will use
  `rappdirs::user_cache_dir("bcmaps")`. This is to align with CRAN’s
  storage policy using the `tools` approach while maintaining backwards
  compatibility with older R versions. Unfortunately this will require
  users who updated to version 1.0 to re-download layers because we are
  caching layers in a different location on your file system from that
  version. Users wishing to clear the old cache location could run
  [`bcmaps::delete_cache()`](http://bcgov.github.io/bcmaps/reference/delete_cache.md)
  before updating to bcmaps 1.0.1.
  ([\#83](https://github.com/bcgov/bcmaps/issues/83))
- `cded_raster` and `cded_stars` directly accepts a bounding box
  generated by
  [`sf::st_bbox`](https://r-spatial.github.io/sf/reference/st_bbox.html)
  as an aoi. ([\#87](https://github.com/bcgov/bcmaps/issues/87))
- Fixed a bug where bundled datasets (e.g.,
  [`mapsheets_50K()`](http://bcgov.github.io/bcmaps/reference/mapsheets_50K.md),
  [`mapsheets_250K()`](http://bcgov.github.io/bcmaps/reference/mapsheets_250K.md))
  would not work if `sf` was linked to older GDAL/PROJ libraries due to
  different formats of coordinate reference systems.
  ([\#85](https://github.com/bcgov/bcmaps/issues/85))
- Added new census boundary layers:
  [`census_dissemination_area()`](http://bcgov.github.io/bcmaps/reference/census_dissemination_area.md),
  [`census_metropolitan_area()`](http://bcgov.github.io/bcmaps/reference/census_metropolitan_area.md),
  [`census_tract()`](http://bcgov.github.io/bcmaps/reference/census_tract.md)
  ([\#82](https://github.com/bcgov/bcmaps/issues/82)).
- Add missing layers to `available_layers`

## bcmaps 1.0

- Drop dependency on {bcmapsdata} in favour of directly retrieving
  layers (where present) from the B.C. Data Catalogue (via {bcdata}) and
  storing in a local cache. Some additional layers are retrieved from
  Statistics Canada.
- Some layers may not be identical to what was previously in {bcmaps}.
  For example `bc_neighbours` previously used data from Natural Earth.
  The availability of a Hi-Res B.C. boundaries over WFS from the B.C.
  Data Catalogue means that the layer can now be created directly by
  {bcmaps}.
- Added forward sortation area (`fsa`), health boundaries (`health_*`)
  and some census boundaries (`census_*`).
- Added ability to retrieve and cache CDED ([BC Digital Elevation
  Model](https://catalogue.data.gov.bc.ca/dataset/digital-elevation-model-for-british-columbia-cded-1-250-000)
  data, returning either `stars` or `raster` objects
  ([\#73](https://github.com/bcgov/bcmaps/issues/73))
- Use of parallelism in functions that allow it
  ([`raster_by_poly()`](http://bcgov.github.io/bcmaps/reference/raster_by_poly.md)
  &
  [`summarize_raster_list()`](http://bcgov.github.io/bcmaps/reference/summarize_raster_list.md))
  is now reliant on users setting up their own
  [`future::plan()`](https://future.futureverse.org/reference/plan.html)
  to specify strategy and number of workers, rather than setting
  defaults (this is the best practice according to the author of the
  future package [@HenrikBengtsson](https://github.com/HenrikBengtsson),
  [\#69](https://github.com/bcgov/bcmaps/issues/69))
- Fixed bug where errors would occur if a user’s system GEOS was a
  development version (e.g., 3.9.0dev;
  [\#71](https://github.com/bcgov/bcmaps/issues/71))

## bcmaps 0.18.1

- Fixed an error where
  [`fix_geo_problems()`](http://bcgov.github.io/bcmaps/reference/fix_geo_problems.md)
  would fail depending on the version of `GEOS` upon which `sf` was
  built.
- [`raster_by_poly()`](http://bcgov.github.io/bcmaps/reference/raster_by_poly.md)
  fails informatively when there are `NA` values in the column on which
  the polygons are to be split
  ([\#48](https://github.com/bcgov/bcmaps/issues/48), thanks
  [@j-galloway](https://github.com/j-galloway))
- [`raster_by_poly()`](http://bcgov.github.io/bcmaps/reference/raster_by_poly.md)
  (and
  [`summarize_raster_list()`](http://bcgov.github.io/bcmaps/reference/summarize_raster_list.md))
  now uses the
  [`future.apply`](https://cran.r-project.org/package=future.apply)
  package for parallelism, enabling easy parallelization across
  platforms ([\#49](https://github.com/bcgov/bcmaps/issues/49))
- [`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
  (and in turn, any of the individual layer functions) now sets the
  `crs` so the `crs` representation will always be up to date with the
  user’s `sf` version
  ([\#51](https://github.com/bcgov/bcmaps/issues/51),
  <https://github.com/r-spatial/sf/issues/1225>)

## bcmaps 0.18.0

- Added
  [`bc_neighbours()`](http://bcgov.github.io/bcmaps/reference/bc_neighbours.md)
  function to call layers containing adjacent jurisdictions.
- Ensured the `geometry` column in all layers is consistently named
  `"geometry"` (Thanks [@boshek](https://github.com/boshek))
- Moving sf package to Depends to take advantage of sf print methods.
- Added
  [`bc_bbox()`](http://bcgov.github.io/bcmaps/reference/bc_bbox.md) to
  get a bounding box for British Columbia
  ([\#40](https://github.com/bcgov/bcmaps/issues/40)).
- All references to external data package now point to `bcmapsdata`
  because of this R bug
  (<https://bugs.r-project.org/bugzilla/show_bug.cgi?id=17520>)

## bcmaps v0.17.1

- Fixed an issue where
  [`self_union()`](http://bcgov.github.io/bcmaps/reference/self_union.md)
  would fail due to a change in the `raster` package (30cef3438)

## bcmaps 0.17.0

- Output of
  [`available_layers()`](http://bcgov.github.io/bcmaps/reference/available_layers.md)
  has changed: `shortcut_function` column is now logical, uses better
  column names, and has a custom print function that gives more
  information. ([\#34](https://github.com/bcgov/bcmaps/issues/34))
- Add links to
  [`combine_nr_rd()`](http://bcgov.github.io/bcmaps/reference/combine_nr_rd.md)
  function from
  [`regional_districts()`](http://bcgov.github.io/bcmaps/reference/regional_districts.md)
  and
  [`municipalities()`](http://bcgov.github.io/bcmaps/reference/municipalities.md).
  This function combines Regional Districts with the Northern Rockies
  Regional Municipalities to create a full provincial layer of
  ‘Regional-District-like’ polygons.
- Added Timber Supply Areas and BC cities shortcut function and to
  [`available_layers()`](http://bcgov.github.io/bcmaps/reference/available_layers.md)
- `bec` (and other large downloadable layers) show up in the output of
  [`available_layers()`](http://bcgov.github.io/bcmaps/reference/available_layers.md),
  [`bec()`](http://bcgov.github.io/bcmaps/reference/bec.md) works, and
  `get_layer("bec")` works so that getting downloadable datasets is
  indistinguishable from getting local datasets.
  ([\#32](https://github.com/bcgov/bcmaps/issues/32))
- Some utility functions use `sf` functions that have been moved to the
  `lwgeom` package. They now use the `lwgeom` function (Fixes CRAN CHECK
  NOTE; [\#33](https://github.com/bcgov/bcmaps/issues/33)).
- Added new layer:
  [`bc_cities()`](http://bcgov.github.io/bcmaps/reference/bc_cities.md)
  which is a point layer of B.C.’s major cities.

## bcmaps 0.16.0

- First release to CRAN
- Added two new functions: `raster_by_poly` to overlay a
  SpatialPolygonsDataFrmae or sf polygons layer on a raster layer and
  clip the raster to each polygon, and `summarize_raster_list` to
  summarize the results of `raster_to_poly`

## bcmaps 0.15.1

- [`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
  now only accepts characters
  ([\#31](https://github.com/bcgov/bcmaps/issues/31))
- Fixes bug in `check_write_to_data_dir` where it was not creating data
  directory
- Update README installation instructions so that vignettes aren’t built
  before bcmaps.rdata is installed
  ([\#29](https://github.com/bcgov/bcmaps/issues/29))

## bcmaps 0.15.0

- Added the ability to download Biogeoclimatic Zone map - as it was too
  big to fit in the bcmaps.rdata package, it is hosted as an asset on a
  GitHub release of bcmaps.rdata, and downloaded via the function
  [`bec()`](http://bcgov.github.io/bcmaps/reference/bec.md), which uses
  the new function `get_big_data()`
  ([\#28](https://github.com/bcgov/bcmaps/issues/28)).
- Added function
  [`bec_colours()`](http://bcgov.github.io/bcmaps/reference/bec_colours.md)
  (and alias
  [`bec_colors()`](http://bcgov.github.io/bcmaps/reference/bec_colours.md))
  to generate a vector of colours that match the standard colours used
  to colour Biogeoclimatic Zone maps.

## bcmaps 0.14.0

- Changed the lookup for exported objected to
  `getNamespaceExports("bcmaps")` so that you can call layers without
  loading the package via `bcmaps::`
- Removed `watersheds` layer from package
- Added `ecosections` to package

## bcmaps 0.13.0

This is a major new release with breaking changes.

All data has been removed from the `bcmaps` package and moved to the
`bcmaps.rdata` package, which is hosted on the bcgov drat repository:
<https://github.com/bcgov/drat>. That package must be installed in order
for `bcmaps` to access the data. It can be installed with:
`install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')`

In previous versions of `bcmaps`, data was stored in the package and
loaded by calling `data("layername")` or simply `layername` (e.g.,
`data("bc_bound")` or `bc_bound`).

Now loading data requires a function call - either using a shortcut
function that is the same name as the dataset (e.g.,
[`bc_bound()`](http://bcgov.github.io/bcmaps/reference/bc_bound.md)
whereas previously one would simply use `bc_bound`). Alternatively, one
can use the
[`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
function (e.g., `get_layer("bc_bound")`).

Another major change is that all the layers are now returned as `sf`
classes by default, rather than `Spatial` classes. `Spatial` versions of
the data can still be obtained by setting the `class` argument to `"sp"`
in [`get_layer()`](http://bcgov.github.io/bcmaps/reference/get_layer.md)
and the shortcut functions (E.g., `bc_bound(class = "sp")` or
`get_layer("bc_bound", class = "sp")`).

## bcmaps 0.12.0

- Added `wsc_drainages`

## bcmaps 0.11.0

- Added `hydrozones` dataset.

## bcmaps 0.10.1

- Fixed ring self-intersections in `bc_bound_hres` and `airzones`
  ([\#13](https://github.com/bcgov/bcmaps/issues/13))

## bcmaps 0.10.0

- Added `water_districts` and `water_precincts` datasets.

## bcmaps 0.9.0

- Added `gw_aquifers` dataset.

## bcmaps 0.8.2

- Added a `tries` argument to `fix_geo_problems` function to set the
  maximum number of iterations it should go through in attempting to
  repair topological issues.

## bcmaps 0.8.1

- Set character encoding of `watercourses_15M` and `watercourses_5M`
  datasets to UTF-8.

## bcmaps 0.8.0

- Added `watercourses_15M` and `watercourses_5M` datasets.

## bcmaps 0.7.1

- `fix_geo_problems` and `transform_bc_albers` are Generic functions
  with methods for `sf` objects as well as `Spatial` objects
- `fix_self_intersect` is now defunct

## bcmaps 0.6.2

- `fix_self_intersect` has been renamed to `fix_geo_problems` (but kept
  as an alias for now)
- `fix_geo_problems` can often also fix orphaned holes in addition to
  self-intersections.

## bcmaps 0.6.0

- Added `watersheds` dataset
  ([\#15](https://github.com/bcgov/bcmaps/issues/15),
  [@markjohnsonubc](https://github.com/markjohnsonubc))
- Added a `NEWS.md` file to track changes to the package.

## bcmaps 0.5.0

Added two new functions to create and work with
SpatailPolygonsDataFrames with nested data frames:

- `self_union` performs a union on a single `SpatialPolygons*` object to
  take into account overlaps. Polygon attributes are combined in a
  nested dataframe.
- `get_poly_attribute` allows you to easily parse a nested data frame
  column (created by `self_union`) to extract or calculate the
  attributes you want

## bcmaps 0.4.0

Added a couple of convenience functions:

- [`transform_bc_albers()`](http://bcgov.github.io/bcmaps/reference/transform_bc_albers.md)
  transforms a Spatial object to BC Albers projection
- `fix_self_intersect()` checks for and repairs self-intersecting
  polygons

## bcmaps 0.3.0

Added 3 Natural Resource layers (areas, regions and districts)

## bcmaps 0.2.0

Added high resolution BC boundaries (`bc_bound_hres`)

## bcmaps 0.1.0

Added `bc_area` function
