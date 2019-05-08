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
#' @param future_strategy the strategy to use in `future::plan()` for parallel
#' computation. Defaults to `"multisession"`.
#' @param workers number of workers if doing parallel. Default `NULL` uses
#' `future::availableCores()`
#' @param ... passed on to `future::plan()`
#'
#' @return a list of `RasterLayers` if `summarize = FALSE` otherwise a list of
#'     vectors.
#' @export
raster_by_poly <- function(raster_layer, poly, poly_field, summarize = FALSE,
                           parallel = FALSE, future_strategy = "multisession",
                           workers = NULL, ...) {
  if (!requireNamespace("raster", quietly = TRUE) &&
      !requireNamespace("sp", quietly = TRUE))
    stop("packages sp and raster are required")

  if (any(is.na(poly[[poly_field]]))) {
    stop("NA values exist in the '", poly_field, "' column in ",
         deparse(substitute(poly)), call. = FALSE)
  }


  if (inherits(poly, "sf")) poly <- methods::as(poly, "Spatial")

  # Split spdf into a list with an element for each polygon, and index
  # by original names so order is preserved
  poly_list <- sp::split(poly, poly[[poly_field]])[poly[[poly_field]]]

  arg_list <- list(
    poly_list,
    function(x) {
      r <- raster::crop(raster_layer, raster::extent(x))
      raster::mask(r, x)
    })

  lply <- get_lapply_function(parallel, future_strategy, workers, ...)

  if (parallel) {
    arg_list <- c(arg_list, list(future.packages = c("raster", "sp")))
    # Reset pre-existing parallel option when function exits
    oopts <- options(future.globals.maxSize = +Inf)
    oplan <- future::plan()
    on.exit(options(oopts), add = TRUE)
    on.exit(future::plan(oplan), add = TRUE)
  }

  raster_list <- do.call(lply, arg_list)

  if (summarize) {
    return(summarize_raster_list(raster_list, parallel, future_strategy,
                                 workers, ...))
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
summarize_raster_list <- function(raster_list, parallel = FALSE,
                                  future_strategy = "multisession",
                                  workers = NULL, ...) {
  if (!requireNamespace("raster", quietly = TRUE) &&
      !requireNamespace("sp", quietly = TRUE))
    stop("packages sp and raster are required")

  lply <- get_lapply_function(parallel, future_strategy, workers, ...)

  arg_list <- list(
    raster_list,
    function(x) {
      as.numeric(stats::na.omit(as.vector(x)))
    })

  if (parallel) {
    arg_list <- c(arg_list, list(future.packages = c("raster", "sp")))
    # Reset pre-existing parallel option when function exits
    oopts <- options(future.globals.maxSize = +Inf)
    oplan <- future::plan()
    on.exit(options(oopts), add = TRUE)
    on.exit(future::plan(oplan), add = TRUE)
  }

  do.call(lply, arg_list)
}

get_lapply_function <- function(parallel, future_strategy, workers, ...) {
  if (parallel) {
    if (!requireNamespace("future.apply", quietly = TRUE))
      stop("future.apply package required")
    if (is.null(workers)) workers <- future::availableCores()
    future::plan(future_strategy, workers = workers, ..., substitute = FALSE)
    message("Running in parallel using ", future::nbrOfWorkers(),
            " workers using a ", future_strategy, " strategy")
    return(future.apply::future_lapply)
  }
  lapply
}
