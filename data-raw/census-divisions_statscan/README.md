## Canadian Census Divisions - BC Regional Districts.

The file `gcd_000b11a_e.zip` is the original 2011 Canadian Census divisions geospatial data, downloaded from http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/gcd_000b11a_e.zip under the [Statistics Canada Open License Agreement](http://www.statcan.gc.ca/eng/reference/licence-eng) on 2015-05-26. It is fully described in `92-160-g2011001-eng.pdf`.

The file `bc_cd_albers.shp` (and associated files) is an extract of British Columbia census divisions from `gcd_000b11a_e.zip`, and has been transformed to the BC Albers projection. It is added to the package in `data/regional_districts_analysis.rda`.

The file `bc_cd_albers_qgis_simplify_100m.shp` (and associated files) is the above extract that has been simplified using the Simplify Geometries tool in QGIS 2.8 with a tolerance of 100m. It is added to the package in `data/regional_districts_disp.rda`

Adapted from Statistics Canada, Census Divisions Boundary File 2011 Census (gcd_000b11a_e), 2015-05-26. This does not constitute an endorsement by Statistics Canada of this product.

