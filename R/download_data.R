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

data_dir <- function() {
  # Use tools::R_user_dir on R >= 4.0, rappdirs otherwise.
  R_user_dir <- getNamespace("tools")$R_user_dir
  if (!is.null(R_user_dir)) {
    getOption("bcmaps.data_dir", default = R_user_dir("bcmaps", "cache"))
  } else {
    getOption("bcmaps.data_dir", default = rappdirs::user_cache_dir("bcmaps"))
  }
}


check_write_to_data_dir <- function(dir, ask) {

  if (ask) {
    ans <- ask(paste("bcmaps would like to store this layer in the directory:",
                     dir, "Is that okay?", sep = "\n"))
    if (!ans) stop("Exiting...", call. = FALSE)
  }

  if (!dir.exists(dir)) {
    message("Creating directory to hold bcmaps data at ", dir)
    dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  } else {
    message("Saving to bcmaps data directory at ", dir)
  }


}

add_user_agent <- function() {
  httr::user_agent("https://github.com/bcgov/bcmaps")
}
