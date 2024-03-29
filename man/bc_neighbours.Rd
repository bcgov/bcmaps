% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bc_bound.R
\name{bc_neighbours}
\alias{bc_neighbours}
\title{Boundary of British Columbia, provinces/states and the portion of the Pacific Ocean that borders British Columbia}
\source{
\code{bcdata::bcdc_get_data('b9bd93e1-0226-4351-b943-05c6f80bd5da')}
}
\usage{
bc_neighbours(ask = interactive(), force = FALSE)
}
\arguments{
\item{ask}{Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().}

\item{force}{Should you force download the data?}
}
\value{
The spatial layer of \code{bc_neighbours} as an \code{sf} object
}
\description{
Boundary of British Columbia, provinces/states and the portion of the Pacific Ocean that borders British Columbia
}
\examples{
\dontrun{
my_layer <- bc_neighbours()
}

}
