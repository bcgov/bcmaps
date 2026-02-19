# British Columbia's Water Management Precincts

British Columbia's Water Management Precincts

## Usage

``` r
water_precincts(ask = interactive(), force = FALSE)
```

## Source

`bcdata::bcdc_get_data(record = 'b5f436b4-532c-4ee2-ba27-90d55ec8c73f', resource = 'e482fd4a-be58-4541-8e0d-c39a764fd0a3')`

## Arguments

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- force:

  Should you force download the data?

## Value

The spatial layer of `water_precincts` as an `sf` object.

## See also

Other BC layers:
[`airzones()`](http://bcgov.github.io/bcmaps/reference/airzones.md),
[`bc_bound()`](http://bcgov.github.io/bcmaps/reference/bc_bound.md),
[`bc_bound_hres()`](http://bcgov.github.io/bcmaps/reference/bc_bound_hres.md),
[`bc_cities()`](http://bcgov.github.io/bcmaps/reference/bc_cities.md),
[`bec()`](http://bcgov.github.io/bcmaps/reference/bec.md),
[`census_dissemination_area()`](http://bcgov.github.io/bcmaps/reference/census_dissemination_area.md),
[`census_dissemination_block()`](http://bcgov.github.io/bcmaps/reference/census_dissemination_block.md),
[`census_division()`](http://bcgov.github.io/bcmaps/reference/census_division.md),
[`census_economic()`](http://bcgov.github.io/bcmaps/reference/census_economic.md),
[`census_metropolitan_area()`](http://bcgov.github.io/bcmaps/reference/census_metropolitan_area.md),
[`census_subdivision()`](http://bcgov.github.io/bcmaps/reference/census_subdivision.md),
[`census_tract()`](http://bcgov.github.io/bcmaps/reference/census_tract.md),
[`ecoprovinces()`](http://bcgov.github.io/bcmaps/reference/ecoprovinces.md),
[`ecoregions()`](http://bcgov.github.io/bcmaps/reference/ecoregions.md),
[`ecosections()`](http://bcgov.github.io/bcmaps/reference/ecosections.md),
[`fsa()`](http://bcgov.github.io/bcmaps/reference/fsa.md),
[`gw_aquifers()`](http://bcgov.github.io/bcmaps/reference/gw_aquifers.md),
[`health_chsa()`](http://bcgov.github.io/bcmaps/reference/health_chsa.md),
[`health_ha()`](http://bcgov.github.io/bcmaps/reference/health_ha.md),
[`health_hsda()`](http://bcgov.github.io/bcmaps/reference/health_hsda.md),
[`health_lha()`](http://bcgov.github.io/bcmaps/reference/health_lha.md),
[`hydrozones()`](http://bcgov.github.io/bcmaps/reference/hydrozones.md),
[`mapsheets_250K()`](http://bcgov.github.io/bcmaps/reference/mapsheets_250K.md),
[`mapsheets_50K()`](http://bcgov.github.io/bcmaps/reference/mapsheets_50K.md),
[`municipalities()`](http://bcgov.github.io/bcmaps/reference/municipalities.md),
[`nr_areas()`](http://bcgov.github.io/bcmaps/reference/nr_areas.md),
[`nr_districts()`](http://bcgov.github.io/bcmaps/reference/nr_districts.md),
[`nr_regions()`](http://bcgov.github.io/bcmaps/reference/nr_regions.md),
[`regional_districts()`](http://bcgov.github.io/bcmaps/reference/regional_districts.md),
[`tsa()`](http://bcgov.github.io/bcmaps/reference/tsa.md),
[`water_districts()`](http://bcgov.github.io/bcmaps/reference/water_districts.md),
[`watercourses_15M()`](http://bcgov.github.io/bcmaps/reference/watercourses_15M.md),
[`watercourses_5M()`](http://bcgov.github.io/bcmaps/reference/watercourses_5M.md),
[`wsc_drainages()`](http://bcgov.github.io/bcmaps/reference/wsc_drainages.md)

## Examples

``` r
if (FALSE) { # \dontrun{
my_layer <- water_precincts()
} # }
```
