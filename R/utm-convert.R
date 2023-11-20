#' Convert a data.frame of UTM coordinates to an sf object with a single CRS
#'
#' This can operate on a data frame containing coordinates from multiple UTM zones
#' with a column denoting the zone, or a single zone for the full dataset.
#'
#' It supports data collected in either the NAD83 or WGS84 ellipsoid in
#' the Northern hemisphere
#'
#' @param x data.frame containing UTM coordinates, with a zone column
#' @param easting the name of the 'easting' column
#' @param northing the name of the 'northing' column
#' @param zone the name of the 'zone' column, or a single value if
#'    the data are all in one UTM zone
#' @param crs target CRS. Default BC Albers (EPSG:3005)
#' @param datum The datum of the source data. `"NAD83"` (Default) or `"WGS84"`
#' @param xycols should the X and Y columns be appended to the output? `TRUE` or `FALSE`
#'
#' @return sf object in the chosen CRS
#' @export
#' @examples
#' # Data with multiple zones, and a column denoting the zone
#' df <- data.frame(
#'   animalid = c("a", "b", "c"),
#'   zone = c(10, 11, 11),
#'   easting = c(500000, 800000, 700000),
#'   northing = c(5000000, 3000000, 1000000)
#' )
#' utm_convert(df, easting = "easting", northing = "northing", zone = "zone")
#'
#' # Data all in one zone, specify a single zone:
#' df <- data.frame(
#'   animalid = c("a", "b"),
#'   easting = c(500000, 800000),
#'   northing = c(5000000, 3000000)
#' )
#' utm_convert(df, easting = "easting", northing = "northing", zone = 11)
utm_convert <- function(x, easting, northing, zone, crs = "EPSG:3005",
                        datum = c("NAD83", "WGS84"), xycols = TRUE) {

  one_zone <- !zone %in% names(x) && is.numeric(format_zone(zone))

  datum <- match.arg(datum)

  if (!one_zone && !zone %in% names(x)) {
    stop(zone, " is not a column in x", call. = FALSE)
  }
  if (!easting %in% names(x)) {
    stop(easting, " is not a column in x", call. = FALSE)
  }
  if (!northing %in% names(x)) {
    stop(northing, " is not a column in x", call. = FALSE)
  }

  if (one_zone) {
    res <- convert_from_zone(x, zone, easting, northing, crs, datum, xycols)
    return(cbind(res, x[, setdiff(names(x), names(res))]))
  }

  x_split <- split(x, x[zone])

  x_split <- lapply(x_split, function(z) {
    zone <- z[[zone]][1]
    convert_from_zone(z, zone, easting, northing, crs, datum, xycols)
  })

  res <- do.call("rbind", x_split)
  cbind(res, x[, setdiff(names(x), names(res))])
}

convert_from_zone <- function(x, zone, easting, northing, crs, datum, xycols) {
  epsg <- lookup_epsg_code(zone, datum)
  x <- sf::st_as_sf(x, coords = c(easting, northing), crs = epsg)
  res <- sf::st_transform(x, crs = crs)
  if (xycols) {
    res <- cbind(res, sf::st_coordinates(res))
  }
  res
}

lookup_epsg_code <- function(zone, datum) {
  zone <- format_zone(zone)
  if (!zone %in% utm_zone_lookup[["zone_numeric"]]) {
    stop("Invalid zone: ", zone, call. = FALSE)
  }
  utm_zone_lookup[["epsg_code"]][
    utm_zone_lookup[["zone_numeric"]] == zone &
      utm_zone_lookup[["datum"]] == datum
    ]
}

format_zone <- function(x) {
  if (is.numeric(x)) return(x)

  if (grepl("[Ss]$", x)) {
    stop("It looks like your UTM zones are in the Southern hemisphere", call. = FALSE)
  }

  ret <- suppressWarnings(as.numeric(gsub("[NnUu$]", "", x)))
  if (is.na(ret)) {
    stop("Invalid zone(s): ", x, call. = FALSE)
  }
  ret
}
