# Copyright 2020 Province of British Columbia
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

#' BC Boundary - High Resolution
#'
#'
#' @param class what class you want the object in? `"sf"` (default) or `"sp"`.
#' @param ask Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().
#' @param force Should you force download the data?
#'
#' @return The spatial layer of `bc_bound_hres` in the desired class
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- bc_bound_hres()
#' my_layer_sp <- bc_bound_hres(class = 'sp')
#' }
#'
#' @source `bcdc_get_data(record = '30aeb5c1-4285-46c8-b60b-15b1a6f4258b',
#'          resource = '3d72cf36-ab53-4a2a-9988-a883d7488384',
#'          layer = 'BC_Boundary_Terrestrial_Multipart')`
#'
#' @export
bc_bound_hres <- function(class = 'sf', ask = interactive(), force = FALSE) {

  dir <- data_dir()
  fpath <- file.path(dir, "bc_bound_hres.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)
    ret <- bcdata::bcdc_get_data(record = '30aeb5c1-4285-46c8-b60b-15b1a6f4258b',
                                 resource = '3d72cf36-ab53-4a2a-9988-a883d7488384',
                                 layer = 'BC_Boundary_Terrestrial_Multipart')
    ret <- rename_sf_col_to_geometry(ret)
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    update_message_once(paste0('bc_bound_hres was updated on ', format(time, "%Y-%m-%d")))
  }
  if (class == "sp") ret <- convert_to_sp(ret)

  ret

}


#' BC Boundary
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `bc_bound` in the desired class
#'
#' @source `bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')`
#'
#' @examples
#' \dontrun{
#' my_layer <- bc_bound()
#' my_layer_sp <- bc_bound(class = 'sp')
#' }
#'
#' @export
bc_bound <- function(class = 'sf', ask = interactive(), force = FALSE) {

  dir <- data_dir()
  fpath <- file.path(dir, "bc_bound.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)
    ret <- bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')
    ret <- ret[ret$ENGLISH_NAME == "British Columbia",]
    ret <- ret[!is.na(ret$ENGLISH_NAME), c("ISLAND")]
    colnames(ret) <- tolower(colnames(ret))
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    update_message_once(paste0('bc_bound_hres was updated on ', format(time, "%Y-%m-%d")))
  }

  if (class == "sp") ret <- convert_to_sp(ret)

  ret
}


#' Boundary of British Columbia, provinces/states and the portion of the Pacific Ocean that borders British Columbia
#'
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `bc_neighbours` in the desired class
#'
#'
#' @source `bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')`
#'
#' @examples
#' \dontrun{
#' my_layer <- bc_neighbours()
#' my_layer_sp <- bc_neighbours(class = 'sp')
#' }
#'
#' @export
bc_neighbours <- function(class = 'sf', ask = interactive(), force = FALSE) {

  dir <- data_dir()
  fpath <- file.path(dir, "bc_neighbours.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)
    ret <- bcdata::bcdc_get_data("b9bd93e1-0226-4351-b943-05c6f80bd5da")
    time <- attributes(ret)$time_downloaded

    ## Square box on projected surface
    coords <- list(matrix(c(
      -142, 59.9, -137.69, 47,
      -114.31, 47, -110, 59.9,
      -142, 59.9
    ),
    ncol = 2,
    byrow = TRUE
    ))

    outside_bc_box <- sf::st_polygon(coords)
    outside_bc_box <- sf::st_sfc(outside_bc_box, crs = 4326)
    outside_bc_box <- transform_bc_albers(outside_bc_box)

    bc_neighbours <- suppressWarnings(sf::st_intersection(ret, outside_bc_box))
    bc_neighbours$iso_a2 <- ifelse(bc_neighbours$NATION_ENGLISH_NAME == "Canada", "CA", "US")
    bc_neighbours <- bc_neighbours[!is.na(bc_neighbours$ENGLISH_NAME), c("iso_a2", "NAME", "STATUS")]
    colnames(bc_neighbours) <- c("iso_a2", "name", "type", "geometry")

    ## Pull out a Pacific Ocean polygon and give it the same cols as bc_neighbours
    bc_oceans_sfc <- sf::st_difference(outside_bc_box, sf::st_union(bc_neighbours))
    bc_oceans <- data.frame(iso_a2 = "OC", name = "Pacific Ocean", type = "Ocean")
    sf::st_geometry(bc_oceans) <- bc_oceans_sfc

    ## Bind the neighbours and ocean data together and aggregate
    ret <- rbind(bc_neighbours, bc_oceans)
    ret <- stats::aggregate(ret, by = list(ret$iso_a2, ret$name, ret$type),
                            FUN = unique, do_union = TRUE)
    ret <- ret[, !grepl("Group\\.", names(ret))]


    class(ret) <- c("sf", "tbl_df", "tbl", "data.frame")
    attr(ret, 'time_downloaded') <- time
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    update_message_once(paste0('bc_neighbours was updated on ', format(time, "%Y-%m-%d")))
  }

  if (class == "sp") ret <- convert_to_sp(ret)

  ret

}
