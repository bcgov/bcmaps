# Copyright 2015 Province of British Columbia
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

#' Regional districts
#'
#' Boundaries of British Columbia Regional Districts.
#'
#' There are two datasets available:
#' \describe{
#'   \item{\code{regional_disricts_disp}}{Polygon boundaries have been simplified to make a smaller file size for display purposes}
#'   \item{\code{regional_districts_analysis}}{Polygon boundaries are faithful to the source data}
#'   }
#'
#' @format A spatialPolygonsDataFrame with 29 polygons defining the boundaries
#'   of each Regional District.
#'
#'   The data slot contains two columns:
#' \describe{
#'   \item{\code{CDUID}}{Unique identifier for Statistics Canada census divisions,
#'    composed of the 2-digit province/territory unique identifier followed
#'    by the 2-digit census division code}
#'   \item{\code{region_type}}{Type of region (27 Regional Districts, one
#'    Unincorporated Area, and one Regional Municipality)}
#'   \item{\code{region_name}}{Name of region}
#' }
#'
#' @source Adapted from Statistics Canada, Census Divisions Boundary File 2011 Census (gcd_000b11a_e), 2015-05-26. This does not
#'   constitute an endorsement by Statistics Canada of this product.
#'   \url{http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gcd_000b11a_e.zip}
#'   Available under the \href{http://www.statcan.gc.ca/eng/reference/licence-eng}{Statistics Canada Open License Agreement}
#'
"regional_districts_disp"

#' @rdname regional_districts_disp
"regional_districts_analysis"
