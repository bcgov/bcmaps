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
#'
#' For use in showing the 4th level drainages (sub-sub-drainages) in the national Drainage Area Framework and
#' for use in determining the Water Survey of Canada alphanumeric codes that are used in hydrometric station numbering.
#'
#' Atlas of Canada 1,000,000 National Frameworks Data, Hydrology - Drainage Areas (WSC sub-sub drainage areas)
#' from the Natural Resources Canada GeoGratis website. The dataset has been clipped to drainage areas within
#' or adjacent to B.C.
#'
#'
#'
#' @format Water Survey of Canada Sub-Sub-Drainage Areas
#'
#' @details Downloaded from Natural Resources Canada GeoGratis website (http://geogratis.gc.ca/api/en/nrcan-rncan/ess-sst/30b33615-6dda-51a5-a9dd-308802714a28.html)
#' and clipped to the area around B.C, then re-projected to BC Albers projection. Some attribute fields were removed, and other
#' attribute field names were changed.
#'
#'
#' @source Original data from
#'   \href{https://catalogue.data.gov.bc.ca/dataset/water-survey-of-canada-sub-sub-drainage-areas}{DataBC},
#'    under the
#'   \href{http://open.canada.ca/en/open-government-licence-canada}{Open Government License - Canada} version 2.0.

"wsc_drainages"
