#' bcmaps: A data package providing varies map layers for British Columbia
#'
#' Various layers of B.C., including administrative boundaries, natural
#' resource management boundaries, etc. All layers are available as sp objects,
#' and are in \href{http://spatialreference.org/ref/epsg/nad83-bc-albers/}{BC Albers}
#' projection, which is the
#' \href{https://www.for.gov.bc.ca/hts/risc/pubs/other/mappro/index.htm}{B.C. government standard}.
#' The layers are sourced from various places under open licenses, including
#' \href{DataBC}{http://data.gov.bc.ca}, the Governmment of Canada
#' \href{Open Data Portal}{http://open.canada.ca/en/open-data}, and
#' \href{Statistics Canada}{http://www.statcan.gc.ca/eng/reference/licence-eng}.
#' Each layer's help page contians a section describing the source for the data.
#'
#' @import sp
#'
#' @section Available layers:
#' \describe{
#'  \item{\link{bc_bound}}{British Columbia Boundary}
#'  \item{\link{regional_districts_disp}}{Regional district boundaries (for display)}
#'  \item{\link{regional_districts_analysis}}{Regional district boundaries (for analysis)}
#' }
#'
#' @docType package
#' @name bcmaps
NULL
