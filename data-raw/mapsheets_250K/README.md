## Mapsheet 250K

The [Indexes of the National Topographic System of Canada data](https://open.canada.ca/data/en/dataset/055919c2-101e-4329-bfd7-1d0c333c0e62) in this folder is licensed under the ([Open Government Licence - Canada](http://open.canada.ca/en/open-government-licence-canada)) version 2.0. See LICENCE.OGL-CAN-2.0.

The process_mapsheets_250K.R contains the 1:250,000 scale. The data is provided by [Natural Resources Canada](https://www.nrcan.gc.ca/earth-sciences/geography/topographic-information/free-data-geogratis/download-directory-documentation/17215) and was downloaded from http://ftp.geogratis.gc.ca/pub/nrcan_rncan/vector/index/ on 2020-11-17.

From this collection of vector of Indexes, British Columbia was extracted using the script `data-raw/mapsheets_250K/process_mapsheets_250K.R`, transformed to the BC Albers projection and added to the package in `data/mapsheet_250K.rda`.
