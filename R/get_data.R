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

#' Get a B.C. spatial layer
#'
#' @param layer the name of the layer. The list of available layers can be
#' obtained by running `available_layers()`
#' @param class The class of the layer returned. Can be either `"sf"` (default) or `"sp"`
#' @param ... arguments passed on to [get_big_data] if the layer needs to be downloaded. Ignored if the
#' layer is available locally in `bcmapsdata`.
#'
#' @return the layer requested
#' @export
#'
#' @examples
#' \dontrun{
#'  get_layer("bc_bound_hres")
#'
#'  # As a "Spatial" (sp) object
#'  get_layer("watercourses_15M")
#' }
get_layer <- function(layer, class = c("sf", "sp"), ...) {

  if (!is.character(layer))
    stop("You must refer to the map layer as a character string (in 'quotes')\n
         Use the function available_layers() to get a list of layers")

  class <- match.arg(class)
  available <- available_layers()

  available_row <- available[available[["layer_name"]] == layer, ]

  if (nrow(available_row) != 1L && layer != "test") {
    stop(layer, " is not an available layer")
  }

  if (!available_row[["local"]] || layer == "test") {
    ret <- get_big_data(layer, class, ...)
  } else {
    ret <- getExportedValue("bcmapsdata", layer)
    ret <- rename_sf_col_to_geometry(ret)

    if (class == "sp") {
      ret <- convert_to_sp(ret)
    }
  }

  ret

}

rename_sf_col_to_geometry <- function(x) {
  geom_col_name <- attr(x, "sf_column")
  if (geom_col_name == "geometry") return(x)

  names(x)[names(x) == geom_col_name] <- "geometry"
  attr(x, "sf_column") <- "geometry"
  x
}

convert_to_sp <- function(sf_obj) {
  if (!requireNamespace("sf")) stop("The sf package is required to convert to sp")
  ret <- sf::st_zm(sf_obj, drop = TRUE)
  ret <- methods::as(ret, "Spatial")
}

#' List available data layers
#'
#' A data.frame of all available layers in the bcmaps package. This drawn
#' directly from the bcmapsdata package and will therefore be the most current list
#' layers available.
#'
#' @return A `data.frame` of layers, with titles, and a `shortcut_function` column
#' denoting whether or not a shortcut function exists that can be used to return the
#' layer. If `TRUE`, the name of the shortcut function is the same as the `layer_name`.
#' A value of `FALSE` in this column means the layer is available via `get_data()` but
#' there is no shortcut function for it.
#'
#' A value of `FALSE` in the `local` column means that the layer is not stored in the
#' bcmapsdata package but will be downloaded from the internet and cached
#' on your hard drive.
#'
#' @examples
#' \dontrun{
#' available_layers()
#' }
#' @export
available_layers <- function() {
  hasData()
  datas <- utils::data(package = "bcmapsdata")
  layers_df <- as.data.frame(datas[["results"]][, c("Item", "Title")], stringsAsFactors = FALSE)
  layers_df$shortcut_function <- layers_df[["Item"]] %in% getNamespaceExports("bcmaps")
  layers_df$local <- TRUE
  names(layers_df)[1:2] <- c("layer_name", "title")
  layers_df <- rbind(layers_df, big_data_layers())
  structure(layers_df, class = c("avail_layers", "tbl_df", "tbl", "data.frame"))
}

#' @export
print.avail_layers <- function(x, ...) {
  print(structure(x, class = setdiff(class(x), "avail_layers")))
  cat("\n------------------------\n")
  cat("Layers with a value of TRUE in the 'shortcut_function' column can be accessed\n")
  cat("with a function with the same name as the layer (e.g., `bc_bound()`),\n")
  cat("otherwise it needs to be accessed with the get_layer function.\n")
  cat("\n")
  cat("Layers with a value of FALSE in the 'local' column are not stored in the\n")
  cat("bcmapsdata package but will be downloaded from the internet and cached\n")
  cat("on your hard drive.")
}
