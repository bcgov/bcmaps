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
#' You must have the `bcmapsdata` package installed to use this function.
#'
#' @param class what class you want the object in? `"sf"` (default) or `"sp"`.
#'
#' @return The spatial layer of `bc_bound_hres` in the desired class
#'
#' @details Type `?bcmapsdata::bc_bound_hres` for details.
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- bc_bound_hres()
#' my_layer_sp <- bc_bound_hres(class = 'sp')
#' }
#'
#' @export
bc_bound_hres <- function(class = 'sf') {
  bc_bound_hres_raw
}
