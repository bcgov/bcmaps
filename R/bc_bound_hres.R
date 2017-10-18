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
#' Boundary of British Columbia
#'
#' @param class what class you want the object in? `"sf"` (default) or `"sp"`.
#'
#' @return The spatial layer in the desired class
#'
#' @details A sf or Spatial defining the boundary of each British Columbia. Scale is 1:7.5M
#'
#' Adapted from Statistics Canada, Provinces/Territories Boundary File 2011 Census (gpr_000b11a_e), 2016-01-15.
#' This does not constitute an endorsement by Statistics Canada of this product.
#'   http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gpr_000b11a_e.zip
#'   Available under the \href{http://www.statcan.gc.ca/eng/reference/licence-eng}{Statistics Canada Open License Agreement}
#'
#' @export
bc_bound_hres <- function(class = "sf") {
  get_layer("bc_bound_hres", class = class)
}
