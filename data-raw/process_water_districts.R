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

library("sp")
library("rgdal")
library("devtools")

water_districts_zip <- "data-raw/water_districts/BCGW_78757263_1494953755959_11056.zip"

unzip(water_districts_zip, exdir = "data-raw/water_districts")

water_districts <- readOGR(dsn = "data-raw/water_districts/LWADM_DA",
                        layer = "LWADM_DA_polygon", stringsAsFactors = FALSE)

water_districts <- spTransform(water_districts, "+init=epsg:3005")

use_data(water_districts, overwrite = TRUE, compress = "xz")
