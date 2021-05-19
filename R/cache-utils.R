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



#' View and delete cached files
#'
#' @param files_to_delete An optional argument to specify which files or layers should be deleted
#'        from the cache. Defaults to deleting all files pausing for permission from user. If a subset
#'        of files are specified, the files are immediately deleted.
#'
#' @return `delete_cache()`: A logical of whether the file(s) were successful deleted
#'
#' @export
#' @examples
#' \dontrun{
#' ## See which files you have
#' show_cached_files()
#'
#' ## Delete your whole cache
#' delete_cache()
#'
#' ## Specify which files are deleted
#' delete_cache(c('regional_districts.rds', 'bc_cities.rds'))
#' }

delete_cache <- function(files_to_delete = NULL) {
  files <- list_cached_files()

  if (is.null(files_to_delete)) {
    if (interactive()) {
      ans <- ask(paste0("These are all the files you currently have stored locally: \n",
                        paste0(files, collapse = "\n"),
                        "\n \nAre you sure you want to delete all these files: \n"))
      if (!ans) stop("Phewf! Glad you re-considered.", call. = FALSE)
    }
  } else {
    files <- file.path(data_dir(), files_to_delete)
    files <- add_rds_suffix(files)
  }

  unlink(files, recursive = TRUE)

  ## return FALSE if any file isn't deleted
  invisible(all(!file.exists(files)))


}

#' Show the files you have in your cache
#'
#' @rdname delete_cache
#'
#' @return `show_cached_files()`: a data.frame with the columns:
#'  - `file`, the name of the file,
#'  - `size_MB`, file size in MB,
#'  - `is_dir`, is it a directory? If you have cached tiles from the [cded()] functions,
#'  there will be a row in the data frame showing the total size
#'  of the cded tiles cache directory.
#'  - `modified`, date and time last modified
#'
#' @export
show_cached_files <- function() {
  files <- tidy_files(list_cached_files())
  if (any(grepl("cded", files$file))) {
    cded_files <- tidy_files(list_cded_files())
    total_cded_size <- sum(cded_files$size_MB, na.rm = TRUE)
    files$size_MB[grepl("cded", files$file)] <- total_cded_size
  }
  files
}

tidy_files <- function(files) {
  tbl <- file.info(files)
  tbl$file <- rownames(tbl)
  rownames(tbl) <- NULL
  tbl$size_MB <- tbl$size / 1e6
  tbl$modified <- tbl$mtime
  tbl$is_dir <- tbl$isdir
  tbl <- tbl[, c("file", "is_dir", "size_MB", "modified")]
  class(tbl) <-  c("tbl_df", "tbl", "data.frame")
  tbl
}

list_cached_files <- function() {
  list.files(data_dir(), full.names = TRUE)
}

list_cded_files <- function() {
  list.files(file.path(data_dir(), "cded"), full.names = TRUE, recursive = TRUE)
}

add_rds_suffix <- function(x) {
  exts <- tools::file_ext(x)
  ifelse(exts == "" & !dir.exists(x), paste0(x, ".rds"), x)
}

