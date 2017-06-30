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

wsc_drainages_zip <- "data-raw/wsc_drainages/wsc_drainages.zip"

unzip(wsc_drainages_zip, exdir = "data-raw/wsc_drainages")

wsc_drainages <- readOGR(dsn = "data-raw/wsc_drainages/SSDA",
                        layer = "SSDA_polygon", stringsAsFactors = FALSE)

wsc_drainages <- spTransform(wsc_drainages, "+init=epsg:3005")

use_data(wsc_drainages, overwrite = TRUE, compress = "xz")
