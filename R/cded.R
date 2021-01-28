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
#' @param aoi Area of Interest. Currently supports sf and sp polygons, stars and raster objects.
#' @param tiles_50K a character vector of 1:50,000 NTS mapsheet tiles
#' @param .predicate geometry predicate function used to find the mapsheets from your aoi. Default [sf::st_intersects].
#' @param dest_vrt The location of the vrt file. Defaults to a temporary file, but can be overridden if you'd like to save it for a project
#' @param check_tiles Should the tiles that you already have in your cache be checked to see if they need updating? Default `TRUE`.
#'                    If you are running the same code frequently and are confident the tiles haven't changed, setting this to `FALSE`
#'                    will speed things up.
#' @inheritParams bc_bound_hres
#'
#' @return path to a .vrt file of the cded tiles for the specified area of interest
#'
#'
#' @export
#'
#' @examples
#' \dontrun{
#' vic <- census_subdivision()[census_subdivision()$CENSUS_SUBDIVISION_NAME == "Victoria", ]
#' vic_cded <- cded(aoi = vic)
#' }
cded <- function(aoi = NULL, tiles_50K = NULL, .predicate = sf::st_intersects,
                 dest_vrt = tempfile(fileext = ".vrt"), ask = interactive(),
                 check_tiles = TRUE) {

  if (!grepl("\\.vrt$", dest_vrt)) {
    stop("You have specified an invalid filename for your vrt file", call. = FALSE)
  }

  cded_dir <- file.path(data_dir(), "cded")

  if (!dir.exists(cded_dir)) check_write_to_data_dir(cded_dir, ask)

  if (!is.null(tiles_50K)) {
    # Make lowercase and make sure padding zeroes are there so 50K
    # mapsheet is always 6 characters
    tiles_50K <- tolower(sprintf("%06s", tiles_50K))

    # Remove leading zeros and 50k identifiers to make 250K mapsheets
    mapsheets <- unique(gsub("(^0)|([0-9]{2}$)", "", substr(tiles_50K, 1, 4)))

    if (!all(mapsheets %in% bc_mapsheet_250K_names())) {
      stop("You have entered invalid mapsheets", call. = FALSE)
    }

  } else {
    aoi <- convert_to_sf(aoi)
    aoi <- transform_bc_albers(aoi)
    tiles_50K_sf <- sf::st_filter(mapsheets_50K(), aoi, .predicate = .predicate)
    tiles_50K <- tolower(tiles_50K_sf$NTS_SNRC)
    mapsheets <- unique(tolower(tiles_50K_sf$grid_250K))
  }

  make_mapsheet_dirs(cded_dir)

  all_tiles <- unlist(lapply(mapsheets, get_mapsheet_tiles,
                             dir = cded_dir, check_tiles = check_tiles))

  tiles <- all_tiles[substr(basename(all_tiles), 1, 6) %in% tiles_50K]

  bbox <- if (!is.null(aoi)) sf::st_bbox(sf::st_transform(aoi, 4269))

  build_vrt(tiles, dest_vrt, bbox = bbox)
}

#' Get Canadian Digital Elevation Model (CDED) as a `stars` object
#'
#' @inheritParams cded
#' @param ... Further arguments passed on to [stars::read_stars]
#'
#' @return a `stars` object of the cded tiles for the specified area of interest
#' @export
#'
#' @examples
#' \dontrun{
#' vic <- census_subdivision()[census_subdivision()$CENSUS_SUBDIVISION_NAME == "Victoria", ]
#' vic_cded <- cded_stars(aoi = vic)
#' }
cded_stars <- function(aoi = NULL, tiles_50K = NULL, .predicate = sf::st_intersects,
                       dest_vrt = tempfile(fileext = ".vrt"),
                       check_tiles = TRUE, ...) {
  if (!requireNamespace("stars", quietly = TRUE)) {
    stop("stars package required to use this function. Please install it.",
         call. = FALSE)
  }
  vrt <- cded(aoi = aoi, tiles_50K = tiles_50K,
              .predicate = .predicate, dest_vrt = dest_vrt,
              check_tiles = check_tiles, ...)

  stats::setNames(stars::read_stars(vrt, ...), "elevation")
}

#' Get Canadian Digital Elevation Model (CDED) as a `raster` object
#'
#' @inheritParams cded
#' @param ... Further arguments passed on to [raster::raster]
#'
#' @return a `raster` object of the cded tiles for the specified area of interest
#' @export
#'
#' @examples
#' \dontrun{
#' vic <- census_subdivision()[census_subdivision()$CENSUS_SUBDIVISION_NAME == "Victoria", ]
#' vic_cded <- cded_raster(aoi = vic)
#' }
cded_raster <- function(aoi = NULL, tiles_50K = NULL, .predicate = sf::st_intersects,
                        dest_vrt = tempfile(fileext = ".vrt"),
                        check_tiles = TRUE, ...) {
  if (!requireNamespace("raster", quietly = TRUE)) {
    stop("raster package required to use this function. Please install it.",
         call. = FALSE)
  }
  vrt <- cded(aoi = aoi, tiles_50K = tiles_50K,
              .predicate = .predicate, dest_vrt = dest_vrt,
              check_tiles = check_tiles, ...)

  stats::setNames(raster::raster(vrt, ...), "elevation")
}

make_mapsheet_dirs <- function(dest_dir) {
  dir_list <- file.path(dest_dir, bc_mapsheet_250K_names())
  lapply(dir_list, dir.create, showWarnings = FALSE, recursive = TRUE)
  dir_list
}

get_mapsheet_tiles <- function(mapsheet, dir, check_tiles = TRUE) {
  if (!mapsheet %in% bc_mapsheet_250K_names()) {
    stop("invalid mapsheet")
  }

  dem_resources <- bcdata::bcdc_tidy_resources(
    "https://catalogue.data.gov.bc.ca/dataset/7b4fef7e-7cae-4379-97b8-62b03e9ac83d"
  )

  url <- dem_resources$url[grepl("zipped dem", tolower(dem_resources$name))]
  url <- paste0(url, "/", mapsheet,"/")

  files <- list_mapsheet_files(url)

  md5s <- files[grepl("md5$", files)]
  zips <- setdiff(files, md5s)
  stopifnot(length(md5s) == length(zips))

  local_tiles <- file.path(dir, mapsheet, zips)
  local_tiffs <- sub("\\.dem\\.zip$", "\\.tif", local_tiles)

  # find which ones we have
  tiles_have <- local_tiles[file.exists(local_tiffs)]
  tiles_need <- setdiff(local_tiles, tiles_have)

  # for those that we already have, check the md5 hash
  if (length(tiles_have) && check_tiles) {
    message(paste0("checking your existing tiles for mapsheet ", mapsheet, " are up to date"))
    tiles_need <- check_hashes(tiles_have, tiles_need, url)
  }


  if (length(tiles_need)) {
    dir.create(dirname(tiles_need[1]), showWarnings = FALSE)
    message("Fetching tiles for mapsheet ", mapsheet)
    # download the ones we need
    pb <- progress::progress_bar$new(
      total = length(tiles_need),
      format = "  downloading :n cded tiles for mapsheet :tn [:bar] :percent eta: :eta",
      clear = FALSE,
      width = 100
    )
    pb$tick(0)
    for (i in seq_along(tiles_need)) {
      pb$tick(tokens = list(
        n = length(tiles_need),
        tn = mapsheet
      ))
      f <- tiles_need[i]
      md5 <- paste0(f, ".md5")
      download.file(paste0(url, "/", basename(f)),
                    quiet = TRUE,
                    destfile = f
      )
      unzip(f, overwrite = TRUE, exdir = dirname(f))
      file.remove(f)
      download.file(paste0(url, "/", basename(md5)),
                    quiet = TRUE,
                    destfile = md5
      )
    }
    dem_to_tif(sub(".\\zip$", "", local_tiles))
  }

  local_tiffs
}

bc_mapsheet_250K_names <- function() {
  c(
    "95d", "95c", "95b", "95a", "94p", "94o", "94n", "94m", "94l",
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

list_mapsheet_files <- function(url) {
  resp <- httr::GET(url, config = httr::config(
    dirlistonly = 1L,
    ftp_use_epsv = 1L
  ))
  httr::stop_for_status(resp)

  link_list <- xml2::xml_find_all(httr::content(resp), ".//a")

  file_pattern <- ".+>([0-9a-z_]+\\.dem\\.zip(\\.md5)?)<.+"
  files <- link_list[grepl(file_pattern, link_list)]
  gsub(file_pattern, "\\1", files)
}

check_hashes <- function(tiles_have, tiles_need, url) {
  md5_files <- paste0(tiles_have, ".md5")

  local_hashes <- vapply(md5_files, readChar, character(1), nchars = 40L)

  remote_hashes <- vapply(md5_files, function(f) {
    readChar(paste0(url, "/", basename(f)), nchars = 40L)
  }, character(1))

  tiles_to_be_refreshed <- tiles_have[local_hashes != remote_hashes]

  if (length(tiles_to_be_refreshed)) {
    message(
      "hash mismatch in tile(s) ",
      paste(basename(tiles_to_be_refreshed), collapse = " "),
      ". They will be re-downloaded"
    )
  }

  c(tiles_need, tiles_to_be_refreshed)
}

build_vrt <- function(tif_files, dest_vrt, bbox = NULL) {

  opts <- if (!is.null(bbox)) {
    c("-te", unname(bbox))
  } else {
    character(0)
  }

  sf::gdal_utils(
    util = "buildvrt",
    source = tif_files,
    destination = dest_vrt,
    options = opts
  )
  dest_vrt
}

#' Get metadata about a .vrt file
#'
#' @param vrt path to a .vrt file
#' @param options options to pass to `gdalinfo`. See
#'   [here](https://gdal.org/programs/gdalinfo.html) for
#'   possible options.
#' @param quiet suppress output to the console (default
#'   `FALSE`)
#'
#' @return character of vrt metadata
#' @export
vrt_info <- function(vrt, options = character(0), quiet = FALSE) {
  if (!file.exists(vrt)) {
    stop("file ", vrt, " does not exist", call. = FALSE)
  }

  sf::gdal_utils("info", source = vrt, options = options, quiet = quiet)
}

#' List the files that a vrt is built on
#'
#' @param vrt path to a .vrt file
#' @param omit_vrt omit the listing of the original vrt. Default `FALSE`
#'
#' @return character vector of tiles
#' @export
vrt_files <- function(vrt, omit_vrt = FALSE) {
  info <- vrt_info(vrt, options = "-json", quiet = TRUE)
  files <- jsonlite::fromJSON(info)$files
  if (omit_vrt) {
    return(setdiff(files, vrt))
  }
  files
}
