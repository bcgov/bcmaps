# BC Boundary - High Resolution

BC Boundary - High Resolution

## Usage

``` r
bc_bound_hres(ask = interactive(), force = FALSE)
```

## Source

`bcdc_get_data(record = '30aeb5c1-4285-46c8-b60b-15b1a6f4258b', resource = '3d72cf36-ab53-4a2a-9988-a883d7488384', layer = 'BC_Boundary_Terrestrial_Multipart')`

## Arguments

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- force:

  Should you force download the data?

## Value

The spatial layer of `bc_bound_hres` as an `sf` object

## See also

Other BC layers:
[`airzones()`](http://bcgov.github.io/bcmaps/reference/airzones.md),
[`bc_bound()`](http://bcgov.github.io/bcmaps/reference/bc_bound.md),
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
[`water_precincts()`](http://bcgov.github.io/bcmaps/reference/water_precincts.md),
[`watercourses_15M()`](http://bcgov.github.io/bcmaps/reference/watercourses_15M.md),
[`watercourses_5M()`](http://bcgov.github.io/bcmaps/reference/watercourses_5M.md),
[`wsc_drainages()`](http://bcgov.github.io/bcmaps/reference/wsc_drainages.md)

## Examples

``` r
if (FALSE) { # \dontrun{
my_layer <- bc_bound_hres()
} # }
```
