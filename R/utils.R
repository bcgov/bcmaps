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
#' The `Spatial` method has been removed as of bcmaps 2.0.0. The `sf` method is here to stay.
#'
#' @param obj The sf object to transform.
#'
#' @return the sf object in BC Albers projection
#' @export
transform_bc_albers <- function(obj) {
  UseMethod("transform_bc_albers")
}

#' @export
transform_bc_albers.sf <- function(obj) {
  sf::st_transform(obj, 3005)
}

#' @export
transform_bc_albers.sfc <- transform_bc_albers.sf

get_return_type <- function(x) {
  if (is.factor(x)) {
    return_type <- "factor"
  } else {
    return_type <- typeof(x)
  }
}

#' Combine Northern Rockies Regional Municipality with Regional Districts
#'
#' @return A layer where the Northern Rockies Regional Municipality has been
#' combined with the Regional Districts to form a full provincial coverage.
#' @export
combine_nr_rd <- function() {
  rd <- get_layer("regional_districts")
  mun <- get_layer("municipalities")
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
#' @param class `"sf"`, `"raster"`.
#' @param crs coordinate reference system: integer with the EPSG code,
#' or character with proj4string. Default `3005` (BC Albers).
#'
#' @return an object denoting a bounding box of British Columbia,
#' of the corresponding class specified in `class`.
#' @export
#'
#' @examples
#'\dontrun{
#'   bc_bbox("sf")
#'   bc_bbox("raster")
#'   }
bc_bbox <- function(class = c("sf", "raster"), crs = 3005) {
  class <- match.arg(class)
  if (class == "raster" && !requireNamespace("raster")) {
    stop("raster package required to make an object of class Extent")
  }

  if (class == "sp") {
    lifecycle::deprecate_stop(
      "2.0.0",
      "bc_bbox(class = 'sp')",
      I("bc_bbox(class = 'sf') or bc_bbox(class = 'sf')"),
      drop_sp_support_message()
    )
  }

  sf_bbox <- sf::st_bbox(sf::st_transform(bc_bound(), crs))

  raw_bbox <- unclass(sf_bbox)
  attr(raw_bbox, "crs") <- NULL

  switch(class,
         sf = sf_bbox,
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

#' @export
convert_to_sf.sf <- function(obj) {
  obj
}
#' @export
convert_to_sf.sfc <- convert_to_sf.sf

#' @export
convert_to_sf.Spatial <- function(obj) {
  sf::st_as_sf(obj)
}

#' @export
convert_to_sf.Raster <- function(obj) {
  bbox <- sf::st_bbox(obj)
  sf::st_as_sfc(bbox)
}

#' @export
convert_to_sf.stars <- function(obj) {
  bbox <- sf::st_bbox(obj)
  sf::st_as_sfc(bbox)
}

#' @export
convert_to_sf.SpatRaster <- function(obj) {
  bbox <- sf::st_bbox(obj)
  sf::st_as_sfc(bbox)
}

#' @export
convert_to_sf.bbox <- function(obj) {
  sf::st_as_sfc(obj)
}
