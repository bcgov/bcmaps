% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{bc_bbox}
\alias{bc_bbox}
\title{Get an extent/bounding box for British Columbia}
\usage{
bc_bbox(class = c("sf", "sp", "raster"), crs = 3005)
}
\arguments{
\item{class}{\code{"sf"}, \code{"sp"}, or \code{"raster"}}

\item{crs}{coordinate reference system: integer with the EPSG code,
or character with proj4string. Default \code{3005} (BC Albers).}
}
\value{
an object denoting a bouding box of British Columbia,
of the corresponding class specified in \code{class}. The coordinates will be
in lat-long WGS84 (epsg:4326).
}
\description{
Get an extent/bounding box for British Columbia
}
\examples{
bc_bbox("sf")
bc_bbox("sp")
bc_bbox("raster")
}