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
