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

#' BC Boundary
#'
#' Boundary of British Columbia at 1:7.5M scale
#'
#' @format A spatialPolygonsDataFrame defining the boundary of each British Columbia. Scale is 1:7.5M
#'
#'   The data slot contains three columns:
#' \describe{
#'   \item{\code{island}}{Name of island, if applicable}
#'   \item{\code{island_e}}{English name of island, if applicable}
#'   \item{\code{island_f}}{French name of island, if applicable}
#' }
#'
#' @source 1:7.5M Atlas of Canada base maps, downloaded from
#' \href{http://open.canada.ca/data/en/dataset/f77c2027-ed4a-5f6e-9395-067af3e9fc1e}{The Canadian Open Data Portal} on 2015-05-04
#' under the \href{http://open.canada.ca/en/open-government-licence-canada}{Open Government License - Canada} version 2.0.
#'
"bc_bound"
