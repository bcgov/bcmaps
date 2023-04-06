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

bcmaps_env <- new.env(parent = emptyenv())

.onLoad <- function(...) {
  assign("bcmaps_update_message", FALSE, envir = bcmaps_env)
}


bcmapsStartupMessage <- function() {
  msg <- "Support for Spatial objects (`sp`) was deprecated in {bcmaps} v1.2.0, and will be removed altogether in the Summer 2023. Please use `sf` objects with {bcmaps}."
}

.onAttach <- function(lib, pkg)
{
  # startup message
  msg <- bcmapsStartupMessage()
  packageStartupMessage(msg)
  invisible()
}

deprecate_sp <- function(what,
                         env = rlang::caller_env(),
                         user_env = rlang::caller_env(2)) {
  lifecycle::deprecate_warn(
    when = "1.2.0",
    what = what,
    details = "Please use `sf` objects with {bcmaps}, support for Spatial objects (sp) will be removed in Summer 2023.",
    env = env,
    user_env = user_env
  )
}
