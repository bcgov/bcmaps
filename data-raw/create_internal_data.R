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

## Code to prepare the layers_df internal data
layers_df <- dplyr::arrange(readr::read_csv("data-raw/layers_df.csv"), layer_name)


source("data-raw/mapsheets_250K/process_mapsheet_250K.R")

# layers_df <- layers_df[!is.na(layers_df$record),]
# layers_df <- layers_df[!layers_df$local,]

usethis::use_data(layers_df, mapsheets_250K_data, mapsheets_50K_data,
                  overwrite = TRUE, internal = TRUE, compress = "xz")
