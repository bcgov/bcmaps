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

nr_districts_zip <- "data-raw/nr_districts/NR_districts.zip"

unzip(nr_districts_zip, exdir = "data-raw/nr_districts")

nr_districts <- readOGR(dsn = "data-raw/nr_districts/ADM_NR_DST",
                                    layer = "ADM_NR_DST_polygon", stringsAsFactors = FALSE)

nr_districts <- spTransform(nr_districts, CRSobj = CRS("+init=epsg:3005"))

use_data(nr_districts, overwrite = TRUE, compress = "xz")
