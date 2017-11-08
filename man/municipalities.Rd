% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shortcuts.R
\name{municipalities}
\alias{municipalities}
\title{British Columbia Municipalities}
\usage{
municipalities(class = "sf")
}
\arguments{
\item{class}{what class you want the object in? \code{"sf"} (default) or \code{"sp"}.}
}
\value{
The spatial layer of \code{municipalities} in the desired class
}
\description{
You must have the \code{bcmaps.rdata} package installed to use this function.
}
\details{
See \link[bcmaps.rdata:municipalities]{bcmaps.rdata::municipalities} for details.
}
\examples{
\dontrun{
my_layer <- municipalities()
my_layer_sp <- municipalities(class = 'sp')
}

}