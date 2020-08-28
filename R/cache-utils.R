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
#' @return A logical of whether the file(s) were successful deleted
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
  files <- show_cached_files()

  if(is.null(files_to_delete)) {
    if (interactive()) {
      ans <- ask(paste0("These are all the files you currently have stored locally: \n",
                        paste0(files, collapse = "\n"),
                        "\n \nAre you sure you want to delete all these files: \n"))
      if(!ans) stop("Phewf! Glad you re-considered.", call. = FALSE)
    }
  } else {
    files <- file.path(data_dir(), add_rds_suffix(files_to_delete))
  }

  unlink(files)

  ## return FALSE if any file isn't deleted
  invisible(all(!file.exists(files)))


}

#' @rdname delete_cache
#'
#' @export
#'

show_cached_files <- function() {
  file.path(list.files(data_dir(), full.names = TRUE))
}


add_rds_suffix <- function(x) {
  exts <- tools::file_ext(x)
  ifelse(exts == "" , paste0(x, ".rds"), x)
}
