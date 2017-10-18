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
