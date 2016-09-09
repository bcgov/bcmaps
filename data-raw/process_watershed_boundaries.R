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

watersheds_zip <- "data-raw/watershed_boundaries/BCGW_watershed_boundaries.zip"

unzip(watersheds_zip, exdir = "data-raw/watershed_boundaries")

watersheds <- readOGR(dsn = "data-raw/watershed_boundaries/HYD_WB_PLY",
                        layer = "HYD_WB_PLY_polygon", stringsAsFactors = FALSE)

watersheds <- spTransform(watersheds, "+init=epsg:3005")

use_data(watersheds, overwrite = TRUE, compress = "xz")
