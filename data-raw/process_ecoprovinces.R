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

library("sp")
library("rgdal")
library("devtools")

ecoprov_zip <- "data-raw/ecoprovinces/BCGW_ecoprovinces.zip"

unzip(ecoprov_zip, exdir = "data-raw/ecoprovinces")

ecoprovinces <- readOGR(dsn = "data-raw/ecoprovinces/ERC_ECOPRO", layer = "ERC_ECOPRO_polygon", stringsAsFactors = FALSE)

use_data(ecoprovinces, overwrite = TRUE, compress = "xz")
