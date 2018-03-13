#' Overlay a SpatialPolygonsDataFrmae or sf polygons layer on a raster layer
#' and clip the raster to each polygon.
#'
#' @param raster_layer the raster layer
#' @param poly a `SpatialPolygonsDataFrame` layer or `sf` layer
#' @param poly_field the field on which to split the `SpatialPolygonsDataFrame`
#' @param summarize Should the function summarise the raster values in each
#'     polygon to a vector? Default `FALSE`
#' @param parallel process in parallel? Default `FALSE`. Not currently
#'     available on Windows.
#' @param cores number of cores if doing parallel. Default `NULL` uses half the
#'     number detected
#' @param ... passed on to `doMC::registerDoMC`
#'
#' @return a list of `RasterLayers` if `summarize = FALSE` otherwise a list of
#'     vectors.
#' @export
raster_by_poly <- function(raster_layer, poly, poly_field, summarize = FALSE,
                           parallel = FALSE, cores = NULL, ...) {

  check_inputs(parallel, cores, ...)

  if (inherits(poly, "sf")) poly <- methods::as(poly, "Spatial")

  # Split spdf into a list with an element for each polygon, and index
  # by original names so order is preserved
  poly_list <- sp::split(poly, poly[[poly_field]])[poly[[poly_field]]]

  raster_list <- plyr::llply(poly_list, function(x) {
    r <- raster::crop(raster_layer, raster::extent(x))
    raster::mask(r, x)
  },
  .parallel = parallel,
  .paropts = list(.packages = c("raster", "sp"))
  )

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
summarize_raster_list <- function(raster_list, parallel = FALSE, cores = NULL, ...) {

  check_inputs(parallel, cores, ...)

  plyr::llply(raster_list, function(x) {
    as.numeric(stats::na.omit(as.vector(x)))
  },
  .parallel = parallel,
  .paropts = list(.packages = c("raster", "sp")))
}

check_inputs <- function(parallel, cores, ...) {
  if (!requireNamespace("raster", quietly = TRUE) && !requireNamespace("sp", quietly = TRUE))
    stop("packages sp and raster are required")
  if (!requireNamespace("plyr", quietly = TRUE)) stop("plyr package required")
  # Make this work on windows:
  # https://stackoverflow.com/questions/6780091/simple-working-example-of-ddply-in-parallel-on-windows
  if (parallel) {
    if (.Platform$OS.type == "windows") {
      stop("Parallel is currently not supported on Windows")
    }
    if (!requireNamespace("doMC")) {
      stop("package doMC required for parallel processing")
    }
    doMC::registerDoMC(cores = cores, ...)
  }
}
