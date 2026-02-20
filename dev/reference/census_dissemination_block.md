# Current Census Dissemination Blocks

Current Census Dissemination Blocks

## Usage

``` r
census_dissemination_block(ask = interactive(), force = FALSE)
```

## Source

`bcdata::bcdc_get_data(record = '76909e49-8ba8-44b1-b69e-dba1fe9ecfba', resource = '2416c524-ed5e-442c-b235-2c805b920219')`

## Arguments

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- force:

  Should you force download the data?

## Value

The spatial layer of `census_dissemination_block` as an `sf` object.

## See also

Other BC layers:
[`airzones()`](http://bcgov.github.io/bcmaps/dev/reference/airzones.md),
[`bc_bound()`](http://bcgov.github.io/bcmaps/dev/reference/bc_bound.md),
[`bc_bound_hres()`](http://bcgov.github.io/bcmaps/dev/reference/bc_bound_hres.md),
[`bc_cities()`](http://bcgov.github.io/bcmaps/dev/reference/bc_cities.md),
[`bec()`](http://bcgov.github.io/bcmaps/dev/reference/bec.md),
[`census_dissemination_area()`](http://bcgov.github.io/bcmaps/dev/reference/census_dissemination_area.md),
[`census_division()`](http://bcgov.github.io/bcmaps/dev/reference/census_division.md),
[`census_economic()`](http://bcgov.github.io/bcmaps/dev/reference/census_economic.md),
[`census_metropolitan_area()`](http://bcgov.github.io/bcmaps/dev/reference/census_metropolitan_area.md),
[`census_subdivision()`](http://bcgov.github.io/bcmaps/dev/reference/census_subdivision.md),
[`census_tract()`](http://bcgov.github.io/bcmaps/dev/reference/census_tract.md),
[`ecoprovinces()`](http://bcgov.github.io/bcmaps/dev/reference/ecoprovinces.md),
[`ecoregions()`](http://bcgov.github.io/bcmaps/dev/reference/ecoregions.md),
[`ecosections()`](http://bcgov.github.io/bcmaps/dev/reference/ecosections.md),
[`fsa()`](http://bcgov.github.io/bcmaps/dev/reference/fsa.md),
[`gw_aquifers()`](http://bcgov.github.io/bcmaps/dev/reference/gw_aquifers.md),
[`health_chsa()`](http://bcgov.github.io/bcmaps/dev/reference/health_chsa.md),
[`health_ha()`](http://bcgov.github.io/bcmaps/dev/reference/health_ha.md),
[`health_hsda()`](http://bcgov.github.io/bcmaps/dev/reference/health_hsda.md),
[`health_lha()`](http://bcgov.github.io/bcmaps/dev/reference/health_lha.md),
[`hydrozones()`](http://bcgov.github.io/bcmaps/dev/reference/hydrozones.md),
[`mapsheets_250K()`](http://bcgov.github.io/bcmaps/dev/reference/mapsheets_250K.md),
[`mapsheets_50K()`](http://bcgov.github.io/bcmaps/dev/reference/mapsheets_50K.md),
[`municipalities()`](http://bcgov.github.io/bcmaps/dev/reference/municipalities.md),
[`nr_areas()`](http://bcgov.github.io/bcmaps/dev/reference/nr_areas.md),
[`nr_districts()`](http://bcgov.github.io/bcmaps/dev/reference/nr_districts.md),
[`nr_regions()`](http://bcgov.github.io/bcmaps/dev/reference/nr_regions.md),
[`regional_districts()`](http://bcgov.github.io/bcmaps/dev/reference/regional_districts.md),
[`tsa()`](http://bcgov.github.io/bcmaps/dev/reference/tsa.md),
[`water_districts()`](http://bcgov.github.io/bcmaps/dev/reference/water_districts.md),
[`water_precincts()`](http://bcgov.github.io/bcmaps/dev/reference/water_precincts.md),
[`watercourses_15M()`](http://bcgov.github.io/bcmaps/dev/reference/watercourses_15M.md),
[`watercourses_5M()`](http://bcgov.github.io/bcmaps/dev/reference/watercourses_5M.md),
[`wsc_drainages()`](http://bcgov.github.io/bcmaps/dev/reference/wsc_drainages.md)

## Examples

``` r
if (FALSE) { # \dontrun{
my_layer <- census_dissemination_block()
} # }
```
