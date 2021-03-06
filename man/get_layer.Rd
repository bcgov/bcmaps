% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data.R
\name{get_layer}
\alias{get_layer}
\title{Get a B.C. spatial layer}
\usage{
get_layer(layer, class = c("sf", "sp"), ask = TRUE, force = FALSE, ...)
}
\arguments{
\item{layer}{the name of the layer. The list of available layers can be
obtained by running \code{available_layers()}}

\item{class}{what class you want the object in? \code{"sf"} (default) or \code{"sp"}.}

\item{ask}{Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().}

\item{force}{Should you force download the data?}

\item{...}{arguments passed on to \link{get_big_data} if the layer needs to be downloaded from a
\code{bcmapsdata} release.}
}
\value{
the layer requested
}
\description{
Get a B.C. spatial layer
}
\examples{
\dontrun{
 get_layer("bc_bound_hres")

 # As a "Spatial" (sp) object
 get_layer("watercourses_15M")
}
}
