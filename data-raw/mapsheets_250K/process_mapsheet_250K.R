# Copyright 2020 Province of British Columbia
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


devtools::load_all()

meta = tempfile(fileext = ".json")
zipfile = tempfile(fileext = ".zip")
shp_dir = file.path(tempdir(), "canada_250k")
download.file("https://open.canada.ca/data/api/action/package_show?id=055919c2-101e-4329-bfd7-1d0c333c0e62", destfile =  meta)
res <- jsonlite::read_json(meta, simplifyVector = TRUE)
zip <- res$result$resources$url[res$result$resources$format == "SHP"]
httr::GET(zip, httr::write_disk(zipfile))
unzip(zipfile = zipfile, exdir = shp_dir)

canada_250k_shp <- list.files(shp_dir, pattern = ".*250.*shp$", full.names = TRUE)
canada_250 <- sf::read_sf(canada_250k_shp)
canada_250$MAP_TILE_DISPLAY_NAME <- tolower(sub("^0+", "", canada_250$NTS_SNRC))
mapsheets_250K_data <- canada_250[canada_250$MAP_TILE_DISPLAY_NAME %in% bc_mapsheet_names(), ]
mapsheets_250K_data <- transform_bc_albers(mapsheets_250K_data)

canada_50k_shp <- list.files(shp_dir, pattern = ".*_50[Kk].*shp$", full.names = TRUE)
canada_50 <- sf::read_sf(canada_50k_shp)
canada_50$grid_250K <- tolower(sub("^0+", "", substr(canada_50$NTS_SNRC, 1, 4)))
mapsheets_50K_data <- canada_50[canada_50$grid_250K %in% bc_mapsheet_names(), ]
mapsheets_50K_data <- transform_bc_albers(mapsheets_50K_data)

# usethis::use_data(mapsheets_250K_data, internal = TRUE, overwrite = TRUE, compress = "xz")
