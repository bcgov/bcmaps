# Convert a data.frame of UTM coordinates to an sf object with a single CRS

This can operate on a data frame containing coordinates from multiple
UTM zones with a column denoting the zone, or a single zone for the full
dataset.

## Usage

``` r
utm_convert(
  x,
  easting,
  northing,
  zone,
  crs = "EPSG:3005",
  datum = c("NAD83", "WGS84"),
  xycols = TRUE
)
```

## Arguments

- x:

  data.frame containing UTM coordinates, with a zone column

- easting:

  the name of the 'easting' column

- northing:

  the name of the 'northing' column

- zone:

  the name of the 'zone' column, or a single value if the data are all
  in one UTM zone

- crs:

  target CRS. Default BC Albers (EPSG:3005)

- datum:

  The datum of the source data. `"NAD83"` (Default) or `"WGS84"`

- xycols:

  should the X and Y columns be appended to the output? `TRUE` or
  `FALSE`

## Value

sf object in the chosen CRS

## Details

It supports data collected in either the NAD83 or WGS84 ellipsoid in the
Northern hemisphere

## Examples

``` r
# Data with multiple zones, and a column denoting the zone
df <- data.frame(
  animalid = c("a", "b", "c"),
  zone = c(10, 11, 11),
  easting = c(500000, 800000, 700000),
  northing = c(5000000, 3000000, 1000000)
)
utm_convert(df, easting = "easting", northing = "northing", zone = "zone")
#> Simple feature collection with 3 features and 6 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 1237767 ymin: -3576605 xmax: 2418043 ymax: 21953.96
#> Projected CRS: NAD83 / BC Albers
#>   animalid zone easting northing       X           Y                 geometry
#> 1        a   10   5e+05    5e+06 1237767    21953.96 POINT (1237767 21953.96)
#> 2        b   11   8e+05    3e+06 2275642 -1807950.91 POINT (2275642 -1807951)
#> 3        c   11   7e+05    1e+06 2418043 -3576604.70 POINT (2418043 -3576605)

# Data all in one zone, specify a single zone:
df <- data.frame(
  animalid = c("a", "b"),
  easting = c(500000, 800000),
  northing = c(5000000, 3000000)
)
utm_convert(df, easting = "easting", northing = "northing", zone = 11)
#> Simple feature collection with 2 features and 5 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 1711595 ymin: -1807951 xmax: 2275642 ymax: 62209.93
#> Projected CRS: NAD83 / BC Albers
#>   animalid easting northing       X           Y                 geometry
#> 1        a   5e+05    5e+06 1711595    62209.93 POINT (1711595 62209.93)
#> 2        b   8e+05    3e+06 2275642 -1807950.91 POINT (2275642 -1807951)
```
