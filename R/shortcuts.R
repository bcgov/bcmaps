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

#' BC Boundary
#'
#' Boundary of British Columbia
#'
#' @param class what class you want the object in? `"sf"` (default) or `"sp"`.
#'
#' @return The spatial layer in the desired class
#'
#' @details A sf or Spatial defining the boundary of each British Columbia. Scale is 1:7.5M
#'
#' Adapted from Statistics Canada, Provinces/Territories Boundary File 2011 Census (gpr_000b11a_e), 2016-01-15.
#' This does not constitute an endorsement by Statistics Canada of this product.
#'   http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gpr_000b11a_e.zip
#'   Available under the \href{http://www.statcan.gc.ca/eng/reference/licence-eng}{Statistics Canada Open License Agreement}
#'
#' @export
bc_bound_hres <- function(class = "sf") {
  get_layer("bc_bound_hres", class = class)
}

#' British Columbia watercourses at 1:15M scale.
#'
#' Watercourses at 1:15M scale for British Columbia sourced from Natural Resources Canada GeoGratis data.
#'
#' @inherit bc_bound_hres params return
#'
#' @details  An sf or Spatial object with watercourses at the 1:15M scale for British Columbia.
#'
#' Original data from
#'   \href{https://www.nrcan.gc.ca/earth-sciences/geography/topographic-information/free-data-geogratis/download-directory-documentation/17215}{},
#'    under the
#'   \href{http://open.canada.ca/en/open-government-licence-canada}{Open
#'   Government License - Canada}.
#'
#' @export
watercourses_15M <- function(class = "sf") {
  get_layer("watercourses_15M", class = class)
}
