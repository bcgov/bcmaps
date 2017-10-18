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
    msg <- paste("To use this package, you must install the",
                 "bcmaps.rdata package. To install that ",
                 "package, run `install.packages('bcmaps.rdata',",
                 "repos='https://bcgov.github.io/drat/', type='source')`.")
    msg <- paste(strwrap(msg), collapse="\n")
    packageStartupMessage(msg)
  }
}

hasData <- function(has_data = .pkgenv$has_data) {
  if (!has_data) {
    msg <- paste("To use this package, you must install the",
                 "bcmaps.rdata package. To install that ",
                 "package, run `install.packages('bcmaps.rdata',",
                 "repos='https://bcgov.github.io/drat/', type='source')`.")
    msg <- paste(strwrap(msg), collapse="\n")
    stop(msg)
  }
}
