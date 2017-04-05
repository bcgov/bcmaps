# Copyright 2016 Province of British Columbia
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

library("sp")
library("rgdal")
library("devtools")
library("raster") # for intersect()
library("bcmaps") #for bc_bound

gw_aquifer_zip <- "data-raw/gw_aquifer/BCGW_78757263_1491002090185_10148.zip"

unzip(gw_aquifer_zip, exdir = "data-raw/gw_aquifer")

gw_aquifer <- readOGR(dsn = "data-raw/gw_aquifer/GW_AQUIFER",
                        layer = "GW_AQUIFER_polygon", stringsAsFactors = FALSE)

gw_aquifer <- spTransform(gw_aquifer, "+init=epsg:3005")

gw_aquifer <- intersect(gw_aquifer, bc_bound_hres)

#watercourses_5M <- set_utf8(watercourses_5M)

use_data(gw_aquifer, overwrite = TRUE, compress = "xz")
