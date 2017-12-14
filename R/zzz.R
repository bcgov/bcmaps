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

.bcmaps_env <- new.env(parent=emptyenv())

.onLoad  <- function(libname, pkgname) {
  has_data <- requireNamespace("bcmaps.rdata", quietly = TRUE)
  .bcmaps_env[["has_data"]] <- has_data
}

.onAttach <- function(libname, pkgname) {
  if (!.bcmaps_env$has_data) {
    msg <- has_no_data_msg()
  } else {
    msg <- check_for_data_pkg_update()
  }
  if (!is.null(msg) && interactive()) packageStartupMessage(msg)
}

hasData <- function() {
  if (!.bcmaps_env$has_data) {
    msg <- has_no_data_msg()
    stop(msg)
  }
}

has_no_data_msg <- function() {
  paste("To use the data in this package, you must install the\n",
        "bcmaps.rdata package. To install that package, run:\n",
        "install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')")
}

check_for_data_pkg_update <- function() {
  pkgs <- utils::packageStatus(.libPaths(), repositories = 'https://bcgov.github.io/drat/src/contrib')
  bcmaps_rdata_local <- pkgs$inst[pkgs$inst$Package == "bcmaps.rdata", ]
  bcmaps_rdata_drat <- pkgs$avail[pkgs$avail$Package == "bcmaps.rdata", ]
  if (bcmaps_rdata_local$Status == "upgrade") {
    msg <- paste("There is a new version of bcmaps.rdata available to install.\n",
          "You have version", bcmaps_rdata_local$Version, "and version",
          bcmaps_rdata_drat$Version, "is available.\n", "Install it with:\n",
          "install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')")
  } else {
    msg <- NULL
  }
  msg
}
