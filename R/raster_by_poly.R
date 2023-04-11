#' Overlay a SpatialPolygonsDataFrame or sf polygons layer on a raster layer
#' and clip the raster to each polygon. Optionally done in parallel
#'
#' @param raster_layer the raster layer
#' @param poly a `SpatialPolygonsDataFrame` layer or `sf` layer
#' @param poly_field the field on which to split the `SpatialPolygonsDataFrame`
#' @param summarize Should the function summarise the raster values in each
#'     polygon to a vector? Default `FALSE`
#' @param parallel process in parallel? Default `FALSE`. If `TRUE`, it is up to
#' the user to call [future::plan()] (or set [options][future::future.options])
#' to specify what parallel strategy to use.
#'
#' @return a list of `RasterLayers` if `summarize = FALSE` otherwise a list of
#'     vectors.
#' @export
raster_by_poly <- function(raster_layer, poly, poly_field, summarize = FALSE,
                           parallel = FALSE) {
  # I'm not deprecating this right now as both raster and sp are not
  # being retired, rather their internal uses of of rgdal and rgeos have been
  # removed, and this function does not require rgdal or rgeos.
  # This will likely be on the block later.

  if (!requireNamespace("raster", quietly = TRUE) &&
      !requireNamespace("sp", quietly = TRUE)) {
    stop("packages sp and raster are required")
  }

  if (any(is.na(poly[[poly_field]]))) {
    stop("NA values exist in the '", poly_field, "' column in ",
         deparse(substitute(poly)), call. = FALSE)
  }

  if (inherits(poly, "sf")) poly <- methods::as(poly, "Spatial")

  # Split spdf into a list with an element for each polygon, and index
  # by original names so order is preserved
  poly_list <- sp::split(poly, poly[[poly_field]])[poly[[poly_field]]]

  if (parallel) {
    check_future_available()
    lply <- future.apply::future_lapply
  } else {
    lply <- base::lapply
  }

  raster_list <- lply(poly_list,
                      function(x) {
                        r <- raster::crop(raster_layer, raster::extent(x))
                        raster::mask(r, x)
                      })

  if (summarize) {
    return(summarize_raster_list(raster_list, parallel))
  } else {
    return(raster_list)
  }
}

#' Summarize a list of rasters into a list of numeric vectors
#'
#' @param raster_list list of rasters
#' @inheritParams raster_by_poly
#'
#' @return a list of numeric vectors
#' @export
#'
summarize_raster_list <- function(raster_list, parallel = FALSE) {
  if (!requireNamespace("raster", quietly = TRUE) &&
      !requireNamespace("sp", quietly = TRUE)) {
    stop("packages sp and raster are required")
  }

  if (parallel) {
    check_future_available()
    lply <- future.apply::future_lapply
  } else {
    lply <- base::lapply
  }

  lply(raster_list,
       function(x) {
         as.numeric(stats::na.omit(as.vector(x)))
       })
}

check_future_available <- function() {
  if (!requireNamespace("future", quietly = TRUE))
    stop("future and future.apply packages required")
  if (!requireNamespace("future.apply", quietly = TRUE))
    stop("future.apply package required")
}
