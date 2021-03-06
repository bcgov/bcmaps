% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shortcuts.R
\name{nr_areas}
\alias{nr_areas}
\title{British Columbia Natural Resource (NR) Areas}
\source{
\code{bcdata::bcdc_get_data(record = 'c1861ba4-abb8-4947-b3e5-7f7c4d7257d5', resource = '4b317896-1a42-4c03-9dbd-bff996d5ea0c')}
}
\usage{
nr_areas(class = "sf", ask = interactive(), force = FALSE)
}
\arguments{
\item{class}{what class you want the object in? \code{"sf"} (default) or \code{"sp"}.}

\item{ask}{Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().}

\item{force}{Should you force download the data?}
}
\value{
The spatial layer of \code{nr_areas} in the desired class
}
\description{
British Columbia Natural Resource (NR) Areas
}
\examples{
\dontrun{
my_layer <- nr_areas()
my_layer_sp <- nr_areas(class = 'sp')
}

}
