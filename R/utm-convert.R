#' Convert a data.frame of UTM coordinates to an sf object with a single CRS
#'
#' This can operate on a data frame containing coordinates from multiple zones
#' with a column denoting the zone, or a single zone for the full dataset.
#'
#' @param x data.frame containing UTM coordinates, with a zone column
#' @param xcol the name of the 'easting' columnm
#' @param ycol the name of the 'northing' column
#' @param zone the name of the 'zone' column, or a single numeric value if
#'    the data are all in one UTM zone
#' @param crs target CRS. Default BC Albers (EPSG:3005)
#' @param xycols should the X and Y columns be appended
#'
#' @return sf object in the chosen CRS
#' @export
utm_convert <- function(x, xcol, ycol, zone, crs = "EPSG:3005", xycols = TRUE) {

  one_zone <- is.numeric(zone) && !zone %in% names(x)

  if (!one_zone && !zone %in% names(x)) {
    stop(zone, " is not a column in x", call. = FALSE)
  }
  if (!xcol %in% names(x)) {
    stop(xcol, " is not a column in x", call. = FALSE)
  }
  if (!ycol %in% names(x)) {
    stop(ycol, " is not a column in x", call. = FALSE)
  }

  if (one_zone) {
    convert_from_zone(x, x[[zone]][1], xcol, ycol, crs, xycols)
    return(cbind(res, x[, setdiff(names(x), names(res))]))
  }
  x_split <- split(x, x[zone])

  x_split <- lapply(x_split, function(z) {
    # browser()
    convert_from_zone(z, z[[zone]][1], xcol, ycol, crs, xycols)
  })

  res <- dplyr::bind_rows(x_split)
  cbind(res, x[, setdiff(names(x), names(res))])
}

lookup_nad83_epsg_code <- function(zone) {
  zone <- as.numeric(zone)
  if (!zone %in% nad83_lookup[["zone_numeric"]]) {
    stop("invalid zone: ", zone, call. = FALSE)
  }
  nad83_lookup[["epsg_code"]][nad83_lookup[["zone_numeric"]] == zone]
}

convert_from_zone <- function(x, zone, xcol, ycol, crs, xycols) {
  epsg <- lookup_nad83_epsg_code(zone)
  x <- sf::st_as_sf(x, coords = c(xcol, ycol), crs = epsg)
  res <- sf::st_transform(x, crs = crs)
  if (xycols) {
    res <- cbind(res, st_coordinates(res))
  }
  res
}
