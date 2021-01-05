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

bc_data_dir <- options('bcmaps.data_dir'= tempdir(check = TRUE))
silence_update_message_value <- options('silence_update_message' = TRUE)

if (identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {
  httr::set_config(httr::config(ssl_verifypeer = FALSE, timeout = 40))
}

# Unset BCDC_KEY env var so no 'authenticating with your API Key messages'
bcdc_key <- Sys.getenv("BCDC_KEY")
Sys.unsetenv("BCDC_KEY")
