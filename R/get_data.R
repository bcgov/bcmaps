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
get_layer <- function(layer, class = c("sf", "sp")) {

  if (!is.character(layer))
    stop("You must refer to the map layer as a character string (in 'quotes')\n
         Use the function available_layers() to get a list of layers")

  class <- match.arg(class)
  available <- available_layers()[["Item"]]

  if (!layer %in% available) {
    stop(layer, "is not an available layer")
  }

  ret <- getExportedValue("bcmaps.rdata", layer)

  if (class == "sp") {
    ret <- convert_to_sp(ret)
  }

  ret

}

convert_to_sp <- function(sf_obj) {
  if (!requireNamespace("sf")) stop("The sf package is required to convert to sp")
  ret <- sf::st_zm(sf_obj, drop = TRUE)
  ret <- methods::as(ret, "Spatial")
}

#' List available data layers
#'
#' A data.frame of all available layers in the bcmaps package. This drawn
#' directly from the bcmaps.rdata package and will therefore be the most current list
#' layers available.
#'
#' @return A data.frame of layers, with Titles, and an additional column `shortcut_function`
#' containing the name of the shortcut function that can be used to return the
#' layer. A value of `NA` in this column means the layer is available via `get_data()` but
#' there is no shortcut function for it.
#'
#' @examples
#' \dontrun{
#' available_layers()
#' }
#' @export
available_layers <- function() {
  hasData()
  datas <- utils::data(package = "bcmaps.rdata")
  layers_df <- as.data.frame(datas[["results"]][, c("Item", "Title")], stringsAsFactors = FALSE)
  layers_df$shortcut_function <- ifelse(layers_df[["Item"]] %in% getNamespaceExports("bcmaps"),
                                        layers_df[["Item"]], NA_character_)
  layers_df
}
