#' The size of British Columbia
#'
#' Total area, Land area only, or Freshwater area only, in \eqn{km^2}, \eqn{m^2}, or \code{ha}.
#'
#' The sizes are from \href{http://www.statcan.gc.ca/tables-tableaux/sum-som/l01/cst01/phys01-eng.htm}{Statistics Canada}
#'
#' @param what Which part of BC? One of \code{'total'} (default), \code{'land'}, or \code{'freshwater'}.
#' @param units One of \code{'km2'} (square kilometres; default), \code{'m2'} (square metres),
#'          or \code{'ha'} (hectares)
#'
#' @return The area of B.C. in the desired units (numeric vector).
#' @export
#'
#' @examples
#' bc_area("land", "ha")
bc_area <- function(what = "total", units = "km2") {
  what = match.arg(what, c("total", "land", "freshwater"))
  units = match.arg(units, c("km2", "m2", "ha"))

  val_km2 <- switch(what, total = 944735, land = 925186, freshwater = 19549)
  ret <- switch(units, km2 = val_km2, m2 = km2_m2(val_km2), ha = km2_ha(val_km2))
  structure(ret, names = paste(what, units, sep = "_"))
}

km2_m2 <- function(x) {
  x * 1e6
}

km2_ha <- function(x) {
  x * 100
}
