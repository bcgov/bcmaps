#' Convert a data.frame of UTM coordinates to a single CRS
#'
#' @param x data.frame containing UTM coordinates, with a zone column
#' @param xcol the name of the 'easting' columnm
#' @param ycol the name of the 'northing' column
#' @param zonecol the name of the 'zone' column
#' @param crs target CRS. Default BC Albers (EPSG:3005)
#'
#' @return sf object in the chosen CRS
#' @export
utm_convert <- function(x, xcol, ycol, zonecol, crs = "EPSG:3005") {
  if (!zonecol %in% names(x)) {
    stop(zonecol, " is not a column in x", call. = FALSE)
  }
  if (!xcol %in% names(x)) {
    stop(xcol, " is not a column in x", call. = FALSE)
  }
  if (!ycol %in% names(x)) {
    stop(ycol, " is not a column in x", call. = FALSE)
  }
  x_split <- split(x, x[zonecol])

  x_split <- lapply(x_split, function(z) {
    # browser()
    epsg <- lookup_nad83_epsg_code(z[[zonecol]][1])
    z <- sf::st_as_sf(z, coords = c(xcol, ycol), crs = epsg)
    sf::st_transform(z, crs = crs)
  })

  res <- dplyr::bind_rows(x_split)
  cbind(res, x[, setdiff(names(x), names(res))])
}

lookup_nad83_epsg_code <- function(zone) {
  nad83_lookup[["epsg_code"]][nad83_lookup[["zone_numeric"]] == as.numeric(zone)]
}
