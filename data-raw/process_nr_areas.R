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

nr_areas_zip <- "data-raw/nr_areas/NR_areas.zip"

unzip(nr_areas_zip, exdir = "data-raw/nr_areas")

nr_areas <- readOGR(dsn = "data-raw/nr_areas/ADM_NR_AR",
                                    layer = "ADM_NR_AR_polygon", stringsAsFactors = FALSE)

nr_areas <- spTransform(nr_areas, CRSobj = CRS("+init=epsg:3005"))

use_data(nr_areas, overwrite = TRUE, compress = "xz")
