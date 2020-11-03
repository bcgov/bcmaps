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

#' Canadian Digital Elevation Model (CDED)
#'
#' Digital Elevation Model (DEM) for British Columbia produced by GeoBC. This data is the
#' TRIM DEM converted to the Canadian Digital Elevation Data (CDED) format. The data consists
#' of an ordered array of ground or reflective surface elevations, recorded in metres, at regularly
#' spaced intervals. The spacing of the grid points is .75 arc seconds north/south. The data was
#' converted into 1:50,000 grids for distribution. The scale of this modified data is
#' 1:250,000 which was captured from the original source data which was at a scale of 1:20,000.
#'
#' @param aoi Area of Interest. An sf polygon.
#' @param mapsheets Mapsheets grid to retrieve raster tiles. Defaults to mapsheets_250K
#' @param ... Further arguments passed to sf::st_filter so that predicates can be specified
#'
#' @export
#'
#' @examples
#' vic <- census_subdivision()[census_subdivision()$CENSUS_SUBDIVISION_NAME == "Victoria",]
#' vic_cded <- cded(aoi = vic)


cded <- function(aoi = NULL, mapsheets = NULL, ...) {
  if (!is.null(mapsheets)) {
    mapsheets <- tolower(mapsheets)
    if (!all(mapsheets %in% bc_mapsheet_names())) {
      stop("You have entered invalid mapsheets", call. = FALSE)
    }
  } else {
    mapsheets_sf <- st_filter(mapsheets_250K(), aoi, ...)
    mapsheets <- tolower(mapsheets_sf$MAP_TILE_DISPLAY_NAME)
  }


  cache_dir <- file.path(data_dir(), "cded")

  make_mapsheet_dirs(cache_dir)

  mapsheets <- lapply(mapsheets, get_mapsheet_tiles, dir = cache_dir)


}

make_mapsheet_dirs <- function(dest_dir) {
  dir_list <- file.path(dest_dir, bc_mapsheet_names())
  lapply(dir_list, dir.create, showWarnings = FALSE, recursive = TRUE)
  dir_list
}

get_mapsheet_tiles <- function(mapsheet, dir) {
  if (!mapsheet %in% bc_mapsheet_names()) {
    stop("invalid mapsheet")
  }

  dem_resources <- bcdata::bcdc_tidy_resources(
    "https://catalogue.data.gov.bc.ca/dataset/7b4fef7e-7cae-4379-97b8-62b03e9ac83d"
  )

  url <- dem_resources$url[grepl("zipped dem", tolower(dem_resources$name))]
  url <- paste0(url, "/", mapsheet)
  resp <- httr::GET(url, config = httr::config(dirlistonly = 1L, ftp_use_epsv = 1L))
  httr::stop_for_status(resp)

  link_list <- xml2::xml_find_all(httr::content(resp), ".//a")

  file_pattern <- ".+>([0-9a-z_]+\\.dem\\.zip(\\.md5)?)<.+"
  files <- link_list[grepl(file_pattern, link_list)]
  files <- gsub(file_pattern, "\\1", files)

  md5s <- files[grepl("md5$", files)]
  zips <- setdiff(files, md5s)
  stopifnot(length(md5s) == length(zips))

  local_zips <- file.path(dir, mapsheet, zips)

  # find which ones we have
  zips_have <- local_zips[file.exists(sub("\\.dem\\.zip$", "\\.tif", local_zips))]
  zips_need <- setdiff(local_zips, zips_have)

  # for those that we already have, check the md5 hash
  if (length(zips_have)) {
    lapply(zips_have, function(f) {
      md5 <- paste0(f, ".md5")
      remote_hash <- readLines(paste0(url, "/", basename(md5)), warn = FALSE)
      local_hash <- readLines(md5, warn = FALSE)
      if (remote_hash != local_hash) {
        # Add to list of dems we need to download
        message("hash mismatch, re-downloading ", basename(f))
        zips_need <<- c(zips_need, basename(f))
      }
    })
  }

  if (length(zips_need)) {
    # download the ones we need
    lapply(zips_need, function(f) {
      md5 <- paste0(f, ".md5")
      download.file(paste0(url, "/", basename(f)),
                    destfile = f)
      unzip(f, overwrite = TRUE, exdir = dirname(f))
      file.remove(f)
      download.file(paste0(url, "/", basename(md5)),
                    destfile = md5)
    })
  }

  dem_to_tif(sub(".\\zip$", "", local_zips))

}

bc_mapsheet_names <- function() {
  c("95d", "95c", "95b", "95a", "94p", "94o", "94n", "94m", "94l",
    "94k", "94j", "94i", "94h", "94g", "94f", "94e", "94d", "94c",
    "94b", "94a", "93p", "93o", "93n", "93m", "93l", "93k", "93j",
    "93i", "93h", "93g", "93f", "93e", "93d", "93c", "93b", "93a",
    "92p", "92o", "92n", "92m", "92l", "92k", "92j", "92i", "92h",
    "92g", "92f", "92e", "92c", "92b", "92a", "85d", "84m", "84l",
    "84e", "84d", "83m", "83l", "83e", "83d", "83c", "82o", "82n",
    "82m", "82l", "82k", "82j", "82h", "82g", "82f", "82e", "82d",
    "82c", "82b", "82a", "115b", "115a", "114p", "114o", "114i",
    "105d", "105c", "105b", "105a", "104p", "104o", "104n", "104m",
    "104l", "104k", "104j", "104i", "104h", "104g", "104f", "104c",
    "104b", "104a", "103p", "103o", "103k", "103j", "103i", "103h",
    "103g", "103f", "103c", "103b", "103a", "102p", "102o", "102i"
  )
}


