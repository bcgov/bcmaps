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

source("data-raw/utils.R")

watercourses_5M_zip <- "data-raw/canvec_5M_hydro/canvec_5M_CA_Hydro_shp.zip"

unzip(watercourses_5M_zip, exdir = "data-raw/canvec_5M_hydro")

watercourses_5M <- readOGR(dsn = "data-raw/canvec_5M_hydro",
                        layer = "watercourse_1", stringsAsFactors = FALSE)

watercourses_5M <- spTransform(watercourses_5M, "+init=epsg:3005")

watercourses_5M <- intersect(watercourses_5M, bc_bound_hres)

watercourses_5M <- set_utf8(watercourses_5M)

use_data(watercourses_5M, overwrite = TRUE, compress = "xz")
