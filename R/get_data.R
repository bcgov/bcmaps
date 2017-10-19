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

  class <- match.arg(class)
  available <- available_layers()[["Item"]]

  if (!layer %in% available) {
    stop(layer, "is not an available layer")
  }

  ret <- getExportedValue("bcmaps.rdata", layer)

  if (class == "sp") {
    if (!requireNamespace("sf")) stop("The sf package is required to convert to sp")
    ret <- as(ret, "Spatial")
  }

  ret

}

#' List available data layers
#'
#' @return A data.frame of layers 
#' @export
available_layers <- function() {
  hasData()
  datas <- data(package = "bcmaps.rdata")
  as.data.frame(datas[["results"]][, c("Item", "Title")], stringsAsFactors = FALSE)
}
