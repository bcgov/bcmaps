#' Overlay a SpatialPolygonsDataFrmae or sf polygons layer on a raster layer
#' and clip the raster to each polygon. Optionally done in parallel
#'
#' @param raster_layer the raster layer
#' @param poly a `SpatialPolygonsDataFrame` layer or `sf` layer
#' @param poly_field the field on which to split the `SpatialPolygonsDataFrame`
#' @param summarize Should the function summarise the raster values in each
#'     polygon to a vector? Default `FALSE`
#' @param parallel process in parallel? Default `FALSE`.
#' @param future_strategy the strategy to use in [future::plan()] for parallel
#' computation. Default `NULL` respects if user has already set a plan using
#' [future::plan()] or an [option][future::future.options],
#' otherwise uses `"multiprocess"`.
#' @param workers number of workers if doing parallel. Default `NULL` uses the
#' default of the future strategy chosen (usually [future::availableCores()]).
#' @param ... passed on to [future::plan()]
#'
#' @return a list of `RasterLayers` if `summarize = FALSE` otherwise a list of
#'     vectors.
#' @export
raster_by_poly <- function(raster_layer, poly, poly_field, summarize = FALSE,
                           parallel = FALSE, future_strategy = NULL,
                           workers = NULL, ...) {
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
    setup_future(future_strategy, workers, ...)
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
                                  future_strategy = NULL,
                                  workers = NULL, ...) {
  if (!requireNamespace("raster", quietly = TRUE) &&
      !requireNamespace("sp", quietly = TRUE)) {
    stop("packages sp and raster are required")
  }

  if (parallel) {
    setup_future(future_strategy, workers, ...)
    lply <- future.apply::future_lapply
  } else {
    lply <- base::lapply
  }

  lply(raster_list,
       function(x) {
         as.numeric(stats::na.omit(as.vector(x)))
       })
}

setup_future <- function(future_strategy, workers, ...) {
  if (!requireNamespace("future.apply", quietly = TRUE))
    stop("future.apply package required")

  # set future.globals.maxSize = Inf to allow for big spatial
  # objects to be transferred to workers
  # See: https://github.com/HenrikBengtsson/future.apply/issues/39
  # capture original options and restore on exit of parent function.
  oopts <- options(future.globals.maxSize = +Inf)
  do.call(on.exit,
          list(substitute(options(oopts)), add = TRUE),
          envir = parent.frame())

  oplan <- future::plan()
  do.call(on.exit,
          list(substitute(future::plan(oplan)), add = TRUE),
          envir = parent.frame())

  # Respect if user has already set a default plan (other than sequential)
  if (is.null(future_strategy)) {
    if (get_future_strategy(oplan) == "sequential") {
      future_strategy <- "multiprocess"
    }
  }
  future::plan(future_strategy, ..., substitute = FALSE)

  if (!is.null(workers)) {
    future::plan(future::tweak(future::plan(), workers = workers),
                 substitute = FALSE)
  }

  strategy <- get_future_strategy(future::plan())

  message("Running in parallel using a '", strategy, "' strategy with ",
          future::nbrOfWorkers(), " workers.")
}

get_future_strategy <- function(plan) {
  setdiff(class(plan),
          c("FutureStrategy", "tweaked", "function"))[1]
}
