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

#' British Columbia BEC Map
#'
#' The current and most detailed version of the approved corporate provincial
#' digital Biogeoclimatic Ecosystem Classification (BEC)
#' Zone/Subzone/Variant/Phase map (version 10, August 31st, 2016).
#'
#' @format An `sf` polygons object with B.C.'s Biogeoclimatic Ecosystem
#' Classification (BEC) Zone/Subzone/Variant/Phase map
#'
#' @source Original data from the
#'   \href{https://catalogue.data.gov.bc.ca/dataset/f358a53b-ffde-4830-a325-a5a03ff672c3}{B.C. Data Catalogue},
#'    under the
#'   \href{https://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61}{Open
#'   Government Licence - British Columbia}.
#'
get_bec <- function(class = c("sf", "sp")) {
  get_big_data("bec", class)
}

get_big_data <- function(what, class= c("sf", "sp")) {
  class <- match.arg(class)
  fname <- paste0(what, ".rds")
  dir <- data_dir()
  fpath <- file.path(dir, fname)

  if (!file.exists(fpath)) {
    check_write_to_data_dir(dir)
  }

  ret_path <- download_file_from_release(fname, fpath)
  if (ret_path != fpath)
    stop("Something went wrong. ", fname, " was written to an unexpected place.")

  ret <- readRDS(fpath)

  if (class == "sp") {
    ret <- convert_to_sp(ret)
  }
  ret
}

data_dir <- function() rappdirs::user_data_dir("bcmaps")

check_write_to_data_dir <- function(dir = data_dir()) {
  ans <- readline(paste("bcmaps would like to store data in the directory:",
                        dir, "Is that okay? (y/n)", sep = "\n"))
  if (tolower(ans) != "y") stop("Exiting...", call. = FALSE)

  dir.create(dir, showWarnings = FALSE)
}

download_file_from_release <- function(file, path) {
  release <- get_latest_release()
  # assets <- list_release_assets(release$id)
  assets <- release$assets

  the_asset <- which(vapply(assets, function(x) x$name, FUN.VALUE = character(1)) == file)
  if (!length(the_asset)) {
    stop("No assets matching filename ", file)
  } else if (length(the_asset) > 1) {
    stop("More than one asset matching filename ", file)
  }

  the_asset_url <- assets[[the_asset]][["url"]]

  the_asset_id <- as.character(assets[[the_asset]][["id"]])
  asset_id_file <- gsub("rds$", "gh_asset_id", path)

  if (file.exists(asset_id_file)) {
    old_asset_id <- as.character(readLines(asset_id_file, n = 1L, warn = FALSE))
    if (old_asset_id != the_asset_id) {
      ans <- readline(paste0("There is a newer version of ", basename(file),
                             "available. Would you like to download it and store it at ",
                             path, "? (y/n"))
      if (tolower(ans) == "y") {
        download <- TRUE
      } else {
        download <- FALSE
      }
    } else {
      download <- FALSE
    }
  } else {
    download <- TRUE
  }

  if (download) {
    message("Downlading ", file, "...\n")
    # write the github release asset id to a file for checking version
    cat(the_asset_id,
        file = asset_id_file)
    download_release_asset(the_asset_url, path)
  } else {
    message("Loading file from cache...\n")
    invisible(path)
  }
}

get_latest_release <- function() {
  # List releases
  rels_resp <- httr::GET(base_url())
  httr::stop_for_status(rels_resp)

  rels <- httr::content(rels_resp)

  # List most recent release
  release_resp <- httr::GET(paste0(base_url(), "/", rels[[1]]$id))
  httr::stop_for_status(release_resp)
  httr::content(release_resp)
}

list_release_assets <- function(release_id) {
  resp <- httr::GET(paste0(base_url(), "/", release_id, "/assets"))
  httr::stop_for_status(resp)
  httr::content(resp)
}

download_release_asset <- function(asset_url, path) {
  resp <- httr::GET(asset_url,
     config = httr::add_headers(Accept = "application/octet-stream"),
     httr::write_disk(path, overwrite = TRUE),
     httr::progress("down"))

  httr::stop_for_status(resp)

  invisible(path)
}

base_url <- function() "https://api.github.com/repos/bcgov/bcmaps.rdata/releases"
