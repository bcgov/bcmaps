#' @export
transform_bc_albers.Spatial <- function(obj) {
  lifecycle::deprecate_stop(
    "2.0.0",
    "transform_bc_albers.Spatial()",
    "transform_bc_albers.sf()",
    details = drop_sp_support_message()
  )
}

#' Check and fix polygons that self-intersect, and sometimes can fix orphan holes
#'
#' @description
#' `r lifecycle::badge("defunct")`.
#'
#' This function is defunct as of bcmaps 2.0.0.
#' For `sf` objects simply use `sf::st_make_valid()`
#'
#' @param obj The SpatialPolygons* or sf object to check/fix.
#'
#' @return The `SpatialPolygons*` or `sf` object, repaired if necessary
#' @keywords internal
#' @export
fix_geo_problems <- function(obj) {
  lifecycle::deprecate_stop(
    "2.0.0",
    "fix_geo_problems()",
    "sf::st_make_valid()"
  )
}

#' Union a SpatialPolygons* object with itself to remove overlaps, while retaining attributes
#'
#' @description
#' `r lifecycle::badge("defunct")`
#'
#' This function is defunct as of bcmaps 2.0.0.
#' Use `raster::union()` for `SpatialPolygonsDataFrame`s, or
#' `sf::st_union()` with `sf` objects instead.
#'
#' @param x A `SpatialPolygons` or `SpatialPolygonsDataFrame` object
#'
#' @return A `SpatialPolygons` or `SpatialPolygonsDataFrame` object
#'
#' @keywords internal
#' @export
self_union <- function(x) {
  lifecycle::deprecate_stop(
    "2.0.0",
    "self_union()",
    "sf::st_union()",
    details = drop_sp_support_message()
  )
}

#' Get or calculate the attribute of a list-column containing nested dataframes.
#'
#' @description
#' `r lifecycle::badge("defunct")`
#'
#' This function is defunct as of bcmaps 2.0.0.
#'
#' @param x the list-column in the (SpatialPolygons)DataFrame that contains nested data.frames
#' @param col the column in the nested data frames from which to retrieve/calculate attributes
#' @param fun function to determine the resulting single attribute from overlapping polygons
#' @param ... other parameters passed on to `fun`
#'
#' @return An atomic vector of the same length as x
#'
#' @keywords internal
#' @export
get_poly_attribute <- function(x, col, fun, ...) {
  lifecycle::deprecate_stop(
    "2.0.0",
    "get_poly_attribute()",
    details = drop_sp_support_message()
  )
}

drop_sp_support_message <- function() {
  "bcmaps has dropped support for Spatial* objects."
}
