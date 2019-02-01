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

#' This generates a data frame of layers that are stored as assets on the bcmapsdata release.
#' It needs to be updated manually when you add a new big (>100MB) layer.
#' @noRd
big_data_layers <- function() {
  data.frame(
    layer_name = c("bec", "tsa"),
    title = c("British Columbia BEC Map", "B.C. Timber Supply Areas & TSA Blocks"),
    shortcut_function = TRUE,
    local = FALSE,
    stringsAsFactors = FALSE
  )
}

#' British Columbia BEC Map
#'
#' The current and most detailed version of the approved corporate provincial
#' digital Biogeoclimatic Ecosystem Classification (BEC)
#' Zone/Subzone/Variant/Phase map (version 10, August 31st, 2016).
#'
#' @inheritParams get_big_data
#' @param ... arguments passed on to [get_big_data]
#'
#' @format An `sf` or `Spatial` polygons object with B.C.'s Biogeoclimatic Ecosystem
#' Classification (BEC) Zone/Subzone/Variant/Phase map
#'
#' @source Original data from the
#'   \href{https://catalogue.data.gov.bc.ca/dataset/f358a53b-ffde-4830-a325-a5a03ff672c3}{B.C. Data Catalogue},
#'    under the
#'   \href{https://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61}{Open
#'   Government Licence - British Columbia}.
#'
#' @export
#'
bec <- function(class = c("sf", "sp"), ...) {
  class <- match.arg(class)
  get_big_data("bec", class, ...)
}

#' British Columbia Timber Supply Areas and TSA Blocks
#'
#' The spatial representation for a Timber Supply Area or TSA Supply Block:
#' A Timber Supply Area is the primary unit for allowable annual cut (AAC)
#' determination. A TSA Supply Block is a designated area within the TSA
#' where the Ministry approves the allowable annual cuts.
#'
#' Updated 2017-11-03
#'
#' @inheritParams get_big_data
#' @param ... arguments passed on to [get_big_data]
#'
#' @format An `sf` or `Spatial` polygons object with B.C.'s Timber Supply
#' Areas and TSA Blocks
#'
#' @source Original data from the
#'   \href{https://catalogue.data.gov.bc.ca/dataset/8daa29da-d7f4-401c-83ae-d962e3a28980}{B.C. Data Catalogue},
#'    under the
#'   \href{https://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61}{Open
#'   Government Licence - British Columbia}.
#'
#' @export
#'
tsa <- function(class = c("sf", "sp"), ...) {
  class <- match.arg(class)
  get_big_data("tsa", class, ...)
}


#' Download a large data file
#'
#' @param what The name of the object to download
#' @param class class of object to import; one of `"sf"` (default) or `"sp"`.
#' @param release Specific version of bcmapsdata to get the desired dataset from. Default `"latest"`
#' @param force Force downloading and overwriting existing dataset. Default `FALSE`
#' @param ask Ask whether or not to write to the default data directory for bcmaps. Default `TRUE`
#' @export
#'
get_big_data <- function(what, class= c("sf", "sp"), release = "latest", force = FALSE, ask = TRUE) {
  class <- match.arg(class)
  fname <- paste0(what, ".rds")
  dir <- data_dir()
  fpath <- file.path(dir, fname)

  if (!file.exists(fpath)) {
    check_write_to_data_dir(dir, ask)
  }

  ret_path <- download_file_from_release(fname, fpath, release = release, force = force)
  if (ret_path != fpath)
    stop("Something went wrong. ", fname, " was written to an unexpected place.")

  ret <- readRDS(fpath)

  if (class == "sp") {
    ret <- convert_to_sp(ret)
  }
  ret
}

data_dir <- function() rappdirs::user_data_dir("bcmaps")

check_write_to_data_dir <- function(dir, ask) {
  if (ask) {
    ans <- ask(paste("bcmaps would like to store this layer in the directory:",
                     dir, "Is that okay?", sep = "\n"))
    if (!ans) stop("Exiting...", call. = FALSE)
  }
  message("Creating directory to hold bcmaps data ", dir)
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)
}

download_file_from_release <- function(file, path, release = "latest", force = FALSE) {
  the_release <- get_gh_release(release)
  assets <- the_release$assets

  the_asset <- which(vapply(assets, function(x) x$name, FUN.VALUE = character(1)) == file)

  if (!length(the_asset)) {
    stop("No assets matching filename ", file, " in ", release, " release.")
  } else if (length(the_asset) > 1) {
    stop("More than one asset matching filename ", file, " in ", release, " release.")
  }

  the_asset_url <- assets[[the_asset]][["url"]]

  the_asset_id <- as.character(assets[[the_asset]][["id"]])
  asset_id_file <- gsub("rds$", "gh_asset_id", path)

  if (file.exists(asset_id_file) && !force) {
    # Read the asset id of the previously written file
    old_asset_id <- as.character(readLines(asset_id_file, n = 1L, warn = FALSE))
    if (old_asset_id == the_asset_id) {
      # the current one on disk is the same asset as on GH so don't download again
      download <- FALSE
    } else {
      ans <- ask(paste0("There is a newer version of ", basename(file),
                        " available. Would you like to download it and store it at ",
                        path, "?"))
      download <- ans
    }
  } else {
    # Hasn't been downloaded before, so must download it now
    download <- TRUE
  }

  if (download) {
    message("Downloading ", file, "...\n")
    # write the github release asset id to a file for checking version
    cat(the_asset_id,
        file = asset_id_file)
    download_release_asset(the_asset_url, path)
  } else {
    message("Loading file from cache...\n")
  }
  invisible(path)
}

get_gh_release <- function(release) {
  # List releases
  rels_resp <- httr::GET(auth_url(base_url()))
  httr::stop_for_status(rels_resp)

  rels <- httr::content(rels_resp)
  # Most recent release
  if (release == "latest") {
    rels[[1]]
  } else {
    rels[vapply(rels, function(x) x$tag_name == as.character(release), FUN.VALUE = logical(1))][[1]]
  }
}

download_release_asset <- function(asset_url, path) {
  resp <- httr::GET(auth_url(asset_url),
                    httr::add_headers(Accept = "application/octet-stream"),
                    httr::write_disk(path, overwrite = TRUE),
                    httr::progress("down"))

  httr::stop_for_status(resp)

  invisible(path)
}

auth_url <- function(url) {
  pat <- Sys.getenv("GITHUB_PAT")
  if (nzchar(pat)) {
    return(paste0(url, "?access_token=", pat))
  }
  url
}

base_url <- function() "https://api.github.com/repos/bcgov/bcmapsdata/releases"

