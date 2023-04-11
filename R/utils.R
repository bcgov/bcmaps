# Copyright 2016 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

#' The size of British Columbia
#'
#' Total area, Land area only, or Freshwater area only, in the units of your choosing.
#'
#' The sizes are from \href{https://www150.statcan.gc.ca/cgi-bin/tableviewer.pl?page=l01/cst01/phys01-eng.htm}{Statistics Canada}
#'
#' @param what Which part of BC? One of `'total'` (default), `'land'`, or `'freshwater'`.
#' @param units One of `'km2'` (square kilometres; default), `'m2'` (square metres),
#'          `'ha'` (hectares), `'acres'`, or `'sq_mi'` (square miles)
#'
#' @return The area of B.C. in the desired units (numeric vector).
#' @export
#'
#' @examples
#' ## With no arguments, gives the total area in km^2:
#' bc_area()
#'
#' ## Get the area of the land only, in hectares:
#' bc_area("land", "ha")
bc_area <- function(what = "total", units = "km2") {
  what <- match.arg(what, c("total", "land", "freshwater"))
  units <- match.arg(units, c("km2", "m2", "ha", "acres", "sq_mi"))

  val_km2 <- switch(what, total = 944735, land = 925186, freshwater = 19549)
  ret <- switch(units, km2 = val_km2, m2 = km2_m2(val_km2), ha = km2_ha(val_km2),
                acres = km2_acres(val_km2), sq_mi = km2_sq_mi(val_km2))

  ret <- round(ret, digits = 0)
  structure(ret, names = paste(what, units, sep = "_"))
}

km2_m2 <- function(x) {
  x * 1e6
}

km2_ha <- function(x) {
  x * 100
}

km2_acres <- function(x) {
  x * 247.105
}

km2_sq_mi <- function(x) {
  x * 0.386102
}

#' Transform a Spatial* object to BC Albers projection
#'
#' The `Spatial` method has been deprecated as of bcmaps 1.2.0 because `sp` is being superseded by `sf`,
#' and will be removed in Summer 2023. The `sf` method is here to stay.
#'
#' @param obj The Spatial* or sf object to transform. `r lifecycle::badge('deprecated')`
#' Support for `sp` Spatial objects are deprecated.
#'
#' @return the Spatial* or sf object in BC Albers projection
#' @export
transform_bc_albers <- function(obj) {
  UseMethod("transform_bc_albers")
}

#' @export
transform_bc_albers.Spatial <- function(obj) {

  lifecycle::deprecate_warn(
    "1.2.0",
    "transform_bc_albers.Spatial()",
    "transform_bc_albers.sf()",
    details = "bcmaps will be dropping support for Spatial objects in Summer 2023."
  )

  if (!requireNamespace("rgdal", quietly = TRUE)) {
    stop("Package rgdal could not be loaded", call. = FALSE)
  }

  sp::spTransform(obj, sp::CRS("+init=epsg:3005"))
}

#' @export
transform_bc_albers.sf <- function(obj) {
  sf::st_transform(obj, 3005)
}

#' @export
transform_bc_albers.sfc <- transform_bc_albers.sf

#' Check and fix polygons that self-intersect, and sometimes can fix orphan holes
#'
#' @description
#' `r lifecycle::badge("deprecated")`.
#'
#' This function is deprecated as of bcmaps 1.2.0 because it relies on `rgeos`
#' for operations on `Spatial` objects, which is being retired. It will be removed
#' completely in Summer 2023.
#' For `sf` objects simply use `sf::st_make_valid()`
#'
#' @param obj The SpatialPolygons* or sf object to check/fix.
#' @param tries The maximum number of attempts to repair the geometry. Ignored for `sf` objects.
#'
#' @return The `SpatialPolygons*` or `sf` object, repaired if necessary
#' @keywords internal
#' @export
fix_geo_problems <- function(obj, tries = 5) {
  UseMethod("fix_geo_problems")
}

#' @export
fix_geo_problems.Spatial <- function(obj, tries = 5) {

  lifecycle::deprecate_warn(
    "1.2.0",
    "fix_geo_problems.Spatial()",
    "sf::st_make_valid()",
    details = "This function requires rgeos which is being retired by its maintainers. The `Spatial` method will be removed in Summer 2023."
  )

  if (!requireNamespace("rgeos", quietly = TRUE)) {
    stop("Package rgeos required but not available", call. = FALSE)
  }

  is_valid <- suppressWarnings(rgeos::gIsValid(obj))

  if (is_valid) {
    message("Geometry is valid")
    return(obj)
  }

  ## If not valid, repair. Try max tries times
  i <- 1L
  message("Problems found - Attempting to repair...")
  while (i <= tries) {
    message("Attempt ", i, " of ", tries)
    obj <- rgeos::gBuffer(obj, byid = TRUE, width = 0)
    is_valid <- suppressWarnings(rgeos::gIsValid(obj))
    if (is_valid) {
      message("Geometry is valid")
      return(obj)
    } else {
      i <- i + 1
    }
  }
  warning("Tried ", tries, " times but could not repair geometry")
  obj
}

#' @export
fix_geo_problems.sf <- function(obj, tries = 5) {

  lifecycle::deprecate_warn(
    "1.2.0",
    "fix_geo_problems()",
    "sf::st_make_valid()"
  )

  ## Check if the overall geomtry is valid, if it is, exit and return input
  is_valid <- suppressWarnings(suppressMessages(sf::st_is_valid(obj)))

  if (all(is_valid)) {
    message("Geometry is valid")
    return(obj)
  }

  message("Problems found - Attempting to repair...")

  make_valid(obj)
}

#' @export
fix_geo_problems.sfc <- fix_geo_problems.sf

#' Union a SpatialPolygons* object with itself to remove overlaps, while retaining attributes
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated as of bcmaps 1.2.0, and will be removed in Summer 2023.
#' Use `raster::union()` for `SpatialPolygonsDataFrame`s, or
#' `sf::st_union()` with `sf` objects instead.
#'
#' The IDs of source polygons are stored in a list-column called
#' `union_ids`, and original attributes (if present) are stored as nested
#' dataframes in a list-column called `union_df`.
#'
#' @param x A `SpatialPolygons` or `SpatialPolygonsDataFrame` object
#'
#' @return A `SpatialPolygons` or `SpatialPolygonsDataFrame` object
#'
#' @keywords internal
#' @export
self_union <- function(x) {
  if (!inherits(x, "SpatialPolygons")) {
    stop("x must be a SpatialPolygons or SpatialPolygonsDataFrame")
  }

  if (!requireNamespace("raster", quietly = TRUE)) {
    stop("Package raster could not be loaded", call. = FALSE)
  }

  lifecycle::deprecate_warn(
    "1.2.0",
    "self_union()",
    "sf::st_union()",
    details = "This function requires rgeos which is being retired by its maintainers. The `Spatial` method will be removed in Summer 2023."
  )

  unioned <- raster::union(x)
  unioned$union_ids <- get_unioned_ids(unioned)

  export_cols <- c("union_count", "union_ids")

  if (inherits(x, "SpatialPolygonsDataFrame")) {
    unioned$union_df <- lapply(unioned$union_ids, function(y) x@data[y, ])
    export_cols <- c(export_cols, "union_df")
  }

  names(unioned)[names(unioned) == "count"] <- "union_count"
  unioned[, export_cols]
}

## For each new polygon in a SpatialPolygonsDataFrame that has been unioned with
## itself (raster::union(SPDF, missing)), get the original polygon ids that
## compose it
get_unioned_ids <- function(unioned_sp) {
  id_cols <- grep("^ID\\.", names(unioned_sp@data))
  unioned_sp_data <- as.matrix(unioned_sp@data[, id_cols])
  colnames(unioned_sp_data) <- gsub("ID\\.", "", colnames(unioned_sp_data))

  unioned_ids <- apply(unioned_sp_data, 1, function(i) {
    as.numeric(colnames(unioned_sp_data)[i > 0])
  })

  names(unioned_ids) <- rownames(unioned_sp_data)
  unioned_ids
}

#' Get or calculate the attribute of a list-column containing nested dataframes.
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated as of bcmaps 1.2.0 because it had a very niche application for
#' calculating attributes on a `SpatialPolygonsDataFrame`, which we are removing
#' support for. It will be removed completely in Summer 2023.
#'
#' For example, `self_union` produces a `SpatialPolygonsDataFrame`
#' that has a column called `union_df`, which contains a `data.frame`
#' for each polygon with the attributes from the constituent polygons.
#'
#' @param x the list-column in the (SpatialPolygons)DataFrame that contains nested data.frames
#' @param col the column in the nested data frames from which to retrieve/calculate attributes
#' @param fun function to determine the resulting single attribute from overlapping polygons
#' @param ... other parameters passed on to `fun`
#'
#' @return An atomic vector of the same length as x
#'
#' @keywords internal
#' @export
get_poly_attribute <- function(x, col, fun, ...) {

  lifecycle::deprecate_warn(
    "1.2.0",
    "get_poly_attribute()",
    details = "Support for `Spatial` objects (package sp) will be dropped in Summer 2023."
  )

  if (!inherits(x, "list")) stop("x must be a list, or list-column in a data frame")
  if (!all(vapply(x, is.data.frame, logical(1)))) stop("x must be a list of data frames")
  if (!col %in% names(x[[1]])) stop(col, " is not a column in the data frames in x")
  if (!is.function(fun)) stop("fun must be a function")

  test_data <- x[[1]][[col]]

  return_type <- get_return_type(test_data)

  is_fac <- FALSE

  if (return_type == "factor") {
    is_fac <- TRUE
    lvls <- levels(test_data)
    ordered <- is.ordered(test_data)
    return_type <- "integer"
  }

  fun_value <- eval(call(return_type, 1))

  ret <- vapply(x, function(y) {
    fun(y[[col]], ...)
  }, FUN.VALUE = fun_value)

  if (is_fac) {
    ret <- factor(lvls[ret], ordered = ordered, levels = lvls)
  }

  ret
}

get_return_type <- function(x) {
  if (is.factor(x)) {
    return_type <- "factor"
  } else {
    return_type <- typeof(x)
  }
}

#' Combine Northern Rockies Regional Municipality with Regional Districts
#'
#' @inheritParams get_layer
#'
#' @return A layer where the Northern Rockies Regional Municipality has been
#' combined with the Regional Districts to form a full provincial coverage.
#' @export
combine_nr_rd <- function(class = deprecated()) {

  if (lifecycle::is_present(class)) {
    deprecate_sp('bcmaps::combine_nr_rd(class)')
    class <- match.arg(class, choices = c('sf', 'sp'))
  }

  rd <- get_layer("regional_districts", class = class)
  mun <- get_layer("municipalities", class = class)
  rbind(rd, mun[mun$ADMIN_AREA_ABBREVIATION == "NRRM",])
}

#' @noRd
ask <- function(...) {
  choices <- c("Yes", "No")
  cat(paste0(..., collapse = ""))
  utils::menu(choices) == which(choices == "Yes")
}

#' Biogeoclimatic Zone Colours
#'
#' Standard colours used to represent Biogeoclimatic Zone colours to be used in plotting.
#'
#' @return named vector of hexadecimal colour codes. Names are standard
#' abbreviations of Zone names.
#' @export
#'
#' @examples
#' \dontrun{
#' if (require(sf) && require(ggplot2)) {
#'  bec <- bec()
#'  ggplot() +
#'    geom_sf(data = bec[bec$ZONE %in% c("BG", "PP"),],
#'            aes(fill = ZONE, col = ZONE)) +
#'    scale_fill_manual(values = bec_colors()) +
#'    scale_colour_manual(values = bec_colours())
#' }
#' }
bec_colours <- function() {
  bec_colours <- c(BAFA = "#E5D8B1", SWB = "#A3D1AB", BWBS = "#ABE7FF",
    ESSF = "#9E33D3", CMA = "#E5C7C7", SBS = "#2D8CBD",
    MH = "#A599FF", CWH = "#208500", ICH = "#85A303",
    IMA = "#B2B2B2", SBPS = "#36DEFC", MS = "#FF46A3",
    IDF = "#FFCF00", BG = "#FF0000", PP = "#DE7D00",
    CDF = "#FFFF00")
  bec_colours[sort(names(bec_colours))]
}

#' @rdname bec_colours
#' @export
bec_colors <- bec_colours

#' Get an extent/bounding box for British Columbia
#'
#' @param class `"sf"`, `"raster"`. `r lifecycle::badge("deprecated")`. `class = "sp"`
#' is deprecated as of bcmaps 1.2.0 and will be removed in Summer 2023.
#' @param crs coordinate reference system: integer with the EPSG code,
#' or character with proj4string. Default `3005` (BC Albers).
#'
#' @return an object denoting a bounding box of British Columbia,
#' of the corresponding class specified in `class`. The coordinates will be
#' in lat-long WGS84 (epsg:4326).
#' @export
#'
#' @examples
#'\dontrun{
#'   bc_bbox("sf")
#'   bc_bbox("raster")
#'   }
bc_bbox <- function(class = c("sf", "sp", "raster"), crs = 3005) {
  class <- match.arg(class)
  if (class == "raster" && !requireNamespace("raster")) {
    stop("raster package required to make an object of class Extent")
  }

  if (class == "sp") {
    lifecycle::deprecate_warn(
      "1.2.0",
      "bc_bbox(class = 'sp')",
      I("bc_bbox(class = 'sf') or bc_bbox(class = 'sf')"),
      "Support for `Spatial` objects (package sp) will be dropped in Summer 2023."
    )
  }

  sf_bbox <- sf::st_bbox(sf::st_transform(bc_bound(), crs))

  raw_bbox <- unclass(sf_bbox)
  attr(raw_bbox, "crs") <- NULL

  switch(class,
         sf = sf_bbox,
         sp = structure(unname(raw_bbox), .Dim = c(2L, 2L),
                        .Dimnames = list(c("x", "y"), c("min", "max"))),
         raster = raster::extent(unname(raw_bbox[c("xmin", "xmax", "ymin", "ymax")]))
  )

}

set_bc_albers <- function(x) {
  # Only try to set crs if it is sf/sfc, otherwise just return it.
  # This should always be sf/sfc
  if (!inherits(x, c("sf", "sfc"))) {
    return(x)
  }
  suppressWarnings(sf::st_set_crs(x, 3005))
}

make_valid <- function(x) {
  if (old_sf_geos() && !requireNamespace("lwgeom")) {
    stop("sf built with old GEOS, lwgeom package required.", call. = FALSE)
  }
  sf::st_make_valid(x)
}

old_sf_geos <- function() {
  geos_ver <- clean_geos_version()
  unname(numeric_version(geos_ver) < numeric_version("3.8"))
}

clean_geos_version <- function(geos_version = sf::sf_extSoftVersion()["GEOS"]) {
  # replace non-numeric version components with 9999 (eg. "dev")
  geos_version <- gsub("[-.]?([^0-9.-])+[-.]?", "-9999-", geos_version)
  # remove trailing "-"
  gsub("-$", "", geos_version)
}

make_bcdata_fn <- function(fn_title) {
  layers <- shortcut_layers()
  fn_meta <- layers[layers$title == fn_title$title,]
  glue::glue("bcdc_get_data(record = '{fn_meta$record}', resource = '{fn_meta$resource}')")
}


update_message_once <- function(...) {
  silence <- isTRUE(getOption("silence_update_message"))
  messaged <- bcmaps_env$bcmaps_update_message
  if (!silence && !messaged) {
    message(...)
    assign("bcmaps_update_message", TRUE, envir = bcmaps_env)
  }
}

dem_to_tif <- function(dem_file) {
  trans <- vapply(dem_file, function(x) {
    sf::gdal_utils(util = "translate",
                   source = x,
                   destination = paste0(tools::file_path_sans_ext(x),".tif"),
                   options = c("-ot","Int16","-of", "GTiff"))
  }, FUN.VALUE = logical(1), USE.NAMES = FALSE)

  unlink(dem_file)
  paste0(tools::file_path_sans_ext(dem_file),".tif")

}


convert_to_sf <- function(obj) {
  UseMethod("convert_to_sf")
}

convert_to_sf.sf <- function(obj) {
  obj
}
convert_to_sf.sfc <- convert_to_sf.sf
convert_to_sf.Spatial <- function(obj) {
  sf::st_as_sf(obj)
}

convert_to_sf.Raster <- function(obj) {
  bbox <- sf::st_bbox(obj)
  sf::st_as_sfc(bbox)
}

convert_to_sf.stars <- function(obj) {
  bbox <- sf::st_bbox(obj)
  sf::st_as_sfc(bbox)
}

convert_to_sf.bbox <- function(obj) {
  sf::st_as_sfc(obj)
}
