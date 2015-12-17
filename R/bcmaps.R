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

#' bcmaps: A data package providing various map layers for British Columbia
#'
#' Various layers of B.C., including administrative boundaries, natural
#' resource management boundaries, etc. All layers are available as sp objects,
#' and are in \href{http://spatialreference.org/ref/epsg/nad83-bc-albers/}{BC Albers}
#' projection, which is the
#' \href{https://www.for.gov.bc.ca/hts/risc/pubs/other/mappro/index.htm}{B.C. government standard}.
#' The layers are sourced from various places under open licenses, including
#' \href{http://data.gov.bc.ca}{DataBC}, the Governmment of Canada
#' \href{http://open.canada.ca/en/open-data}{Open Data Portal}, and
#' \href{http://www.statcan.gc.ca/eng/reference/licence-eng}{Statistics Canada}.
#' Each layer's help page contians a section describing the source for the data.
#'
#' @import sp
#'
#' @section Available layers:
#' \describe{
#'  \item{\link{bc_bound}}{British Columbia Boundary}
#'  \item{\link{regional_districts_disp}}{Regional district boundaries (for display)}
#'  \item{\link{regional_districts_analysis}}{Regional district boundaries (for analysis)}
#'  \item{\link{airzones}}{British Columbia Air Zones}
#' }
#'
#' @docType package
#' @name bcmaps
NULL
