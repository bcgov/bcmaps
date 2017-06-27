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

hydrologic_zip <- "data-raw/hydrozones/BC_hydrologic_zones.zip"

unzip(hydrologic_zip , exdir = "data-raw/hydrozones")

hydrozones <- readOGR(dsn = "data-raw/hydrozones/HYD_BC_H_Z",
                      layer = "HYD_BC_H_Z_polygon", stringsAsFactors = FALSE)

hydrozones <- spTransform(hydrozones, "+init=epsg:3005")

use_data(hydrozones, overwrite = TRUE, compress = "xz")
