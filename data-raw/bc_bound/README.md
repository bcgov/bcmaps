## BC Boundary

Data in this folder is licensed under the ([Open Government Licence - Canada](http://open.canada.ca/en/open-government-licence-canada)) version 2.0. See LICENCE.Canada-OGL-2.0.

The file `atlas_of_canada_7.5M.zip` contains the 1:7.5M Atlas of Canada base maps, downloaded from [The Canadian Open Data Portal](http://open.canada.ca/data/en/dataset/f77c2027-ed4a-5f6e-9395-067af3e9fc1e) on 2015-05-04.

From this collection of base maps, the boundary of British Columbia is extracted using the script `data-raw/process_bc_bound.R`, transformed to the BC Albers projection and added to the package in `data/bc_bound.rda`.
