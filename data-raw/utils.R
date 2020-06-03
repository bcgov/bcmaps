# Copyright 2017 Province of British Columbia
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
library("devtools")

set_utf8 <- function(sf_obj) {
  char_cols <- names(sf_obj)[vapply(sf_obj, is.character, FUN.VALUE = logical(1))]

  for (col in char_cols) {
    Encoding(sf_obj[[col]]) <- "UTF-8"
  }

  sf_obj
}

#' Prepare a spatial file for inclusion in bcmapsdata package
#'
#' @param file path to shp or gdb
#' @param transform transform to BC Albers (default `TRUE`)
#' @param repair Repair toplogy (default `TRUE`)
#' @param filter_stmt An optional filter statement - bare, unquoted. E.g., `PRUID == 59`
#' @param clip_bc Does it require clipping to BC boundary? Default `FALSE`
#'
#' @return processed sf object
process_file <- function(file, layer, transform = TRUE, repair = TRUE, filter_stmt,
                         clip_bc = FALSE, crs = NULL) {

  if (!requireNamespace("sf")) {
    stop("sf package required but not availahble")
  }

  bcmaps_avail <- requireNamespace("bcmaps")

  obj <- sf::read_sf(file, layer = layer)

  if (!is.null(crs)) sf::st_crs(obj) <- crs

  if (!missing(filter_stmt)) {
    if (!requireNamespace("dplyr") || !requireNamespace("rlang")) {
      stop("dplyr and rlang required for filtering")
    }
    f_q <- rlang::enquo(filter_stmt)
    obj <- dplyr::filter(obj, !!f_q)
  }

  if (transform) {
    if (!bcmaps_avail) stop("bcmaps package required")
    obj <- bcmaps::transform_bc_albers(obj)
  }

  if (clip_bc) {
    load("data/bc_bound_hres.rda")
    obj <- sf::st_intersection(obj, bc_bound_hres)
  }

  if (repair) {
    if (requireNamespace("sf")) {
      obj <- sf::st_make_valid(obj)
    } else {
      if (!bcmaps_avail) stop("bcmaps package required")
      obj <- bcmaps::fix_geo_problems(obj)
    }
  }

  obj
}

process_from_bcdc <- function(record_id, resource_id = NULL) {
  if (!requireNamespace("bcdata")) stop("bcdata package required")

  data <- bcdc_get_data(record_id, resource = resource_id)
  class(data) <- setdiff(class(data), "bcdc_sf")
  data
}
