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

read_bc_watercourse <- function(x) {
  temp_zip <- file.path(tempdir(), basename(x))
  res <- httr::GET(x, httr::write_disk(temp_zip, overwrite = TRUE))
  httr::stop_for_status(res)
  unzip_path <- utils::unzip(temp_zip, exdir = tempdir())
  gdb_path <- gsub("_fgdb", ".gdb", tools::file_path_sans_ext(temp_zip))
  l <- "watercourse_1"
  sql_l <- sprintf("SELECT * FROM \"%s\" WHERE country = 140 AND political_division = 93", l)
  s <- sf::read_sf(gdb_path, layer = l,
              query = sql_l)
  transform_bc_albers(s)
}



#' British Columbia watercourses at 1:15M scale
#'
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `watercourses_15M` in the desired class
#'
#' @source https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/canvec/fgdb/Hydro/canvec_15M_CA_Hydro_fgdb.zip
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- watercourses_15M()
#' my_layer_sp <- watercourses_15M(class = 'sp')
#' }
#'
#' @export
watercourses_15M <- function(class = 'sf', ask = interactive(), force = FALSE) {
  x <- 'https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/canvec/fgdb/Hydro/canvec_15M_CA_Hydro_fgdb.zip'

  dir <- data_dir()
  fpath <- file.path(dir, "watercourses_15M.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)
    ret <- read_bc_watercourse(x)
    ret <- rename_sf_col_to_geometry(ret)
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    message(paste0('watercourses_15M was updated on ', format(time, "%Y-%m-%d")))
  }
  if (class == "sp") ret <- convert_to_sp(ret)

  ret
}

#' British Columbia watercourses at 1:5M scale
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `watercourses_5M` in the desired class
#'
#' @source https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/canvec/fgdb/Hydro/canvec_5M_CA_Hydro_fgdb.zip
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- watercourses_5M()
#' my_layer_sp <- watercourses_5M(class = 'sp')
#' }
#'
#' @export
watercourses_5M <- function(class = 'sf', ask = interactive(), force = FALSE) {
  x <- 'https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/canvec/fgdb/Hydro/canvec_5M_CA_Hydro_fgdb.zip'

  dir <- data_dir()
  fpath <- file.path(dir, "watercourses_5M.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)
    ret <- read_bc_watercourse(x)
    ret <- rename_sf_col_to_geometry(ret)
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    message(paste0('watercourses_5M was updated on ', format(time, "%Y-%m-%d")))
  }
  if (class == "sp") ret <- convert_to_sp(ret)

  ret
}

#' British Columbia Forward Sortation Areas
#'
#' @inheritParams bc_bound_hres
#'
#' @source http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lfsa000b16a_e.zip
#'
#' @examples
#' \dontrun{
#' my_layer <- fsa()
#' my_layer_sp <- fsa(class = 'sp')
#' }
#' @export
fsa <- function(class = 'sf', ask = interactive(), force = FALSE) {

  link <- 'http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lfsa000b16a_e.zip'
  x <- getOption('fsa_link', default = link)

  dir <- data_dir()
  fpath <- file.path(dir, "fsa.rds")

  if (!file.exists(fpath) | force) {
    check_write_to_data_dir(dir, ask)

    temp_zip <- file.path(tempdir(), basename(x))
    res <- httr::GET(x, httr::write_disk(temp_zip, overwrite = TRUE))
    httr::stop_for_status(res)
    unzip_path <- utils::unzip(temp_zip, exdir = tempdir())
    ret <- sf::read_sf(unzip_path[grepl("\\.shp$", unzip_path)])
    ret <- ret[ret$PRUID == '59',]
    ret <- transform_bc_albers(ret)
    ret <- rename_sf_col_to_geometry(ret)
    saveRDS(ret, fpath)
  } else {
    ret <- readRDS(fpath)
    time <- attributes(ret)$time_downloaded
    message(paste0('fsa was updated on ', format(time, "%Y-%m-%d")))
  }
  if (class == "sp") ret <- convert_to_sp(ret)

  ret

}

#' NTS 250K Grid - Digital Baseline Mapping at 1:250,000 (NTS)
#'
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `mapsheets_250K` in the desired class
#'
#' @source https://open.canada.ca/data/en/dataset/055919c2-101e-4329-bfd7-1d0c333c0e62
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- mapsheets_250K()
#' my_layer_sp <- mapsheets_250K(class = 'sp')
#' }
#'
#' @export
mapsheets_250K <- function(class = 'sf') {

  ret <- mapsheets_250K_data

  # Re-assign CRS using installed sf/GDAL/PROJ stack so it is
  # in a format usable by that stack
  ret <- set_bc_albers(ret)

  if (class == "sp") ret <- convert_to_sp(ret)

  ret
}
#' NTS 50K Grid - Digital Baseline Mapping at 1:50,000 (NTS)
#'
#'
#' @inheritParams bc_bound_hres
#'
#' @return The spatial layer of `mapsheets_50K` in the desired class
#'
#' @source https://open.canada.ca/data/en/dataset/055919c2-101e-4329-bfd7-1d0c333c0e62
#'
#'
#'
#' @examples
#' \dontrun{
#' my_layer <- mapsheets_50K()
#' my_layer_sp <- mapsheets_50K(class = 'sp')
#' }
#'
#' @export
mapsheets_50K <- function(class = 'sf') {

  ret <- mapsheets_50K_data
  # Re-assign CRS using installed sf/GDAL/PROJ stack so it is
  # in a format usable by that stack
  ret <- set_bc_albers(ret)

  if (class == "sp") ret <- convert_to_sp(ret)

  ret
}
