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
#' @param ask Should the function ask the user before downloading the data to a cache?
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
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    message(paste0('bc_bound_hres was updated on ', format(time, "%Y-%m-%d")))
  }
  if (class == "sp") ret <- convert_to_sp(ret)

  ret

}


#' BC Boundary
#'
#' @param class what class you want the object in? `"sf"` (default) or `"sp"`.
#'
#' @return The spatial layer of `bc_bound` in the desired class
#'
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- bc_bound()
#' my_layer_sp <- bc_bound(class = 'sp')
#' }
#'
#' @export
bc_bound <- function(class = 'sf') {

  d <- bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')
  d <- d[d$ENGLISH_NAME == "British Columbia",]
  d <- d[!is.na(d$ENGLISH_NAME),c("ISLAND")]
  colnames(d) <- tolower(colnames(d))

  if (class == "sp") d <- convert_to_sp(d)

  d
}
