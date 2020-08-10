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

source("data-raw/utils.R")

url <- "http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gpr_000b11a_e.zip"
path <- "data-raw/prov_territories_statscan"
original_can <- "gpr_000b11a_e"
zip_path <- file.path(path, paste0(original_can, ".zip"))
shp_path <- file.path(path, paste0(original_can, ".shp"))


if (!file.exists(shp_path)) {

  if (!file.exists(zip_path)) {
    download.file(url, destfile = zip_path)
  }
  unzip(zip_path, exdir = path)

}

bc_bound_hres_raw <- process_file(shp_path, filter_stmt = PRUID == 59)


use_data(bc_bound_hres_raw, bc_bound_raw, layers_df,
         overwrite = TRUE, internal = TRUE, compress = "xz")
