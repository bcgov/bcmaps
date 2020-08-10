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

###############################################################################
## Get map of BC from Govt of Canada Open Data site:
## ("http://open.canada.ca/data/en/dataset/f77c2027-ed4a-5f6e-9395-067af3e9fc1e")

source("data-raw/utils.R")

bc_bound_zip <- "data-raw/bc_bound/atlas_of_canada_7.5M.zip"
bc_bound_dir <- "data-raw/bc_bound"

## Download the zipfile and unzip:
if (!file.exists(bc_bound_zip)) {
  download.file("http://ftp2.cits.rncan.gc.ca/pub/geott/atlas/base/7.5m_g_shp.zip", destfile = bc_bound_zip)
}

files <- unzip(bc_bound_zip, list = TRUE)
files_to_extract <- c(files$Name[grep("pvp", files$Name)], "read-me.txt")
unzip(bc_bound_zip, files = files_to_extract, exdir = bc_bound_dir)

## Set the coordinate system to NAD 27 (CSRS)
## http://epsg.io/4267
# proj4string(bc_bound) <- CRS("+init=epsg:4267")


bc_bound_raw <- process_file(file.path(bc_bound_dir, "pvp.shp"),
             filter_stmt = NAME_E == "British Columbia", crs = 4267)

## Combine ISLAND with ISLAND_E to get one island column
bc_bound_raw$island <- with(bc_bound_raw, pmax(ISLAND, ISLAND_E, na.rm = TRUE))

bc_bound_raw <- bc_bound_raw[, "island", drop = FALSE]


