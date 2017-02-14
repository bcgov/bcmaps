## CanVec 15M Hydro

Data in this folder is licensed under the ([Open Government License - Canada](http://open.canada.ca/en/open-government-licence-canada)) version 2.0. See LICENSE.OGL-CAN-2.0.

The file `CanVec_Catalogue_15M_CA_Hydro_shp.zip` contains the base maps from the National Vector Catalogue Profile (NVCP) Earth Sciences Sector Integrated Model, EXPL, 15M, Hydro Features, downloaded from http://wmsmir.cits.rncan.gc.ca/index.html/pub/canvec/shp/Hydro/ on 2017-02-14.

From this collection of base maps, the 15M watercourses in British Columbia is extracted using the script `data-raw/process_15M_watercourses.R`, transformed to the BC Albers projection and added to the package in `data/watercourses_15M.rda`.
