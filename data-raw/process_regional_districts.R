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

url <- "http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gcd_000b11a_e.zip"
path <- "data-raw/census-divisions_statscan"
original_can_cd <- "gcd_000b11a_e"
original_bc_cd <- "bc_cd_albers"
tolerance <- "100m"
simplified_bc_cd <- paste0("bc_cd_albers_qgis_simplify_", tolerance)

if (!file.exists(file.path(path, paste0(simplified_bc_cd, ".shp")))) {

  if (!file.exists(file.path(path, paste0(original_bc_cd, ".shp")))) {

    if (!file.exists(file.path(path, paste0(original_can_cd, ".zip")))) {
      download.file(url, destfile = file.path(path, paste0(original_can_cd, ".zip")))
      unzip(file.path(path, paste0(original_can_cd, ".zip")), exdir = path)
    }

    cd <- readOGR(dsn = path, layer = original_can_cd)

    bc_cd <- cd[cd$PRUID == 59,]

    ## Transform to BC Albers
    bc <- spTransform(bc_cd, CRS("+init=epsg:3005"))

    writeOGR(bc, path, original_bc_cd, driver = "ESRI Shapefile")
  }
  message("Go into QGIS, import ", original_bc_cd,
      ", use the Simplify Geometries tool and simplify with a tolerance of ",
      tolerance, " and save as '", simplified_bc_cd, ".shp'")
}

regional_districts_analysis <- readOGR(path, layer = original_bc_cd,
                                       stringsAsFactors = FALSE)

regional_districts_disp <- readOGR(path, layer = simplified_bc_cd,
                                   stringsAsFactors = FALSE)

regional_districts_analysis <- regional_districts_analysis[, "CDNAME"]
names(regional_districts_analysis) <- "region_name"

regional_districts_analysis$region_type <- "Regional District"
regional_districts_analysis$region_type[regional_districts_analysis$region_name == "Northern Rockies"] <- "Regional Municipality"
regional_districts_analysis$region_type[regional_districts_analysis$region_name == "Stikine"] <- "Unincorporated Area"

regional_districts_disp <- regional_districts_disp[, "CDNAME"]
names(regional_districts_disp) <- "region_name"

regional_districts_disp$region_type <- "Regional District"
regional_districts_disp$region_type[regional_districts_disp$region_name == "Northern Rockies"] <- "Regional Municipality"
regional_districts_disp$region_type[regional_districts_disp$region_name == "Stikine"] <- "Unincorporated Area"

use_data(regional_districts_disp, overwrite = TRUE, compress = "xz")
use_data(regional_districts_analysis, overwrite = TRUE, compress = "xz")

