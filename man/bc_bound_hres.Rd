% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bc_bound.R
\name{bc_bound_hres}
\alias{bc_bound_hres}
\title{BC Boundary - High Resolution}
\source{
\code{bcdc_get_data(record = '30aeb5c1-4285-46c8-b60b-15b1a6f4258b', resource = '3d72cf36-ab53-4a2a-9988-a883d7488384', layer = 'BC_Boundary_Terrestrial_Multipart')}
}
\usage{
bc_bound_hres(ask = interactive(), force = FALSE)
}
\arguments{
\item{ask}{Should the function ask the user before downloading the data to a cache? Defaults to the value of interactive().}

\item{force}{Should you force download the data?}
}
\value{
The spatial layer of \code{bc_bound_hres} as an \code{sf} object
}
\description{
BC Boundary - High Resolution
}
\examples{
\dontrun{
my_layer <- bc_bound_hres()
}

}
\seealso{
Other BC layers: 
\code{\link{airzones}()},
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
\code{\link{municipalities}()},
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
