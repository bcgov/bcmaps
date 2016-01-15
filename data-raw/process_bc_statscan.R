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

################################################################################
## Convert Statistics Canada 2011 cencus divisions (which are equivalent to BC
## Regional Districts) in to a BC only regional district map. The data are available here:
## http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gcd_000b11a_e.zip
## under the Statistics Canada Open License Agreement: http://www.statcan.gc.ca/eng/reference/licence-eng
library("sp")
library("rgdal")
library("devtools")

url <- "http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gpr_000b11a_e.zip"
path <- "data-raw/prov_territories_statscan"
original_can <- "gpr_000b11a_e"

if (!file.exists(file.path(path, paste0(original_can, ".shp")))) {

    if (!file.exists(file.path(path, paste0(original_can, ".zip")))) {
      download.file(url, destfile = file.path(path, paste0(original_can, ".zip")))
      unzip(file.path(path, paste0(original_can, ".zip")), exdir = path)
    }

}

cd <- readOGR(dsn = path, layer = original_can, stringsAsFactors = FALSE)

bc_bound_hres <- cd[cd$PRUID == 59,]

## Transform to BC Albers
bc <- spTransform(bc_bound_hres, CRS("+init=epsg:3005"))

use_data(bc_bound_hres, overwrite = TRUE, compress = "xz")


