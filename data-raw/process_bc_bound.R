###############################################################################
## Get map of BC from Govt of Canada Open Data site:
## ("http://open.canada.ca/data/en/dataset/f77c2027-ed4a-5f6e-9395-067af3e9fc1e")

library("sp")
library("rgdal")
library("devtools")

bc_bound_zip <- "data-raw/bc_bound/bc_bound.zip"
bc_bound_dir <- "data-raw/bc_bound"

## Download the zipfile and unzip:
if (!file.exists(bc_bound_zip)) {
  download.file("http://ftp2.cits.rncan.gc.ca/pub/geott/atlas/base/7.5m_g_shp.zip", destfile = bc_bound_zip)
}

files <- unzip(bc_bound_zip, list = TRUE)
files_to_extract <- c(files$Name[grep("pvp", files$Name)], "read-me.txt")
unzip(bc_bound_zip, files = files_to_extract, exdir = bc_bound_dir)

## Import the "pvp" shapefile, which has provinical boundaries
bc_bound <- readOGR(bc_bound_dir, "pvp", stringsAsFactors = FALSE)

## Subset to get only BC
bc_bound <- bc_bound[bc_bound$NAME_E == "British Columbia" & !is.na(bc_bound$NAME_E),]

## Set the coordinate system to NAD 27 (CSRS)
## http://epsg.io/4267
proj4string(bc_bound) <- CRS("+init=epsg:4267")

## Project to BC Albers (Standard in BC; an equal-area projection:
## http://epsg.io/3005)
bc_bound <- spTransform(bc_bound, CRS("+init=epsg:3005"))

bc_bound <- bc_bound[, grep("ISLAND", names(bc_bound))]


use_data(bc_bound, overwrite = TRUE, compress = "xz")

