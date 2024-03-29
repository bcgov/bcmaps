% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shortcuts.R
\name{municipalities}
\alias{municipalities}
\title{British Columbia Municipalities}
\source{
\code{bcdata::bcdc_get_data(record = 'e3c3c580-996a-4668-8bc5-6aa7c7dc4932', resource = '25c95b07-5882-47ff-970d-36cb243b8355')}
}
\usage{
municipalities(ask = interactive(), force = FALSE)
}
\arguments{
\item{ask}{Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().}

\item{force}{Should you force download the data?}
}
\value{
The spatial layer of \code{municipalities} as an \code{sf} object.
}
\description{
British Columbia Municipalities
}
\examples{
\dontrun{
my_layer <- municipalities()
}

}
\seealso{
\code{\link[=combine_nr_rd]{combine_nr_rd()}} to combine Regional Districts and the Northern Rockies Regional Municipality into one layer

Other BC layers: 
\code{\link{airzones}()},
\code{\link{bc_bound_hres}()},
\code{\link{bc_bound}()},
\code{\link{bc_cities}()},
\code{\link{bec}()},
\code{\link{census_dissemination_area}()},
\code{\link{census_division}()},
\code{\link{census_economic}()},
\code{\link{census_metropolitan_area}()},
\code{\link{census_subdivision}()},
\code{\link{census_tract}()},
\code{\link{ecoprovinces}()},
\code{\link{ecoregions}()},
\code{\link{ecosections}()},
\code{\link{fsa}()},
\code{\link{gw_aquifers}()},
\code{\link{health_chsa}()},
\code{\link{health_ha}()},
\code{\link{health_hsda}()},
\code{\link{health_lha}()},
\code{\link{hydrozones}()},
\code{\link{mapsheets_250K}()},
\code{\link{mapsheets_50K}()},
\code{\link{nr_areas}()},
\code{\link{nr_districts}()},
\code{\link{nr_regions}()},
\code{\link{regional_districts}()},
\code{\link{tsa}()},
\code{\link{water_districts}()},
\code{\link{water_precincts}()},
\code{\link{watercourses_15M}()},
\code{\link{watercourses_5M}()},
\code{\link{wsc_drainages}()}
}
\concept{BC layers}
