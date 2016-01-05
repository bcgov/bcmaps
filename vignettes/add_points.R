## ----message=FALSE-------------------------------------------------------
library(sp)
library(rgdal)
library(bcmaps)
library(ggplot2)

## ------------------------------------------------------------------------
set.seed(42)
spp <- data.frame(id = 1:10, spp_present = as.logical(rbinom(10,1,0.5)),
                 lat = runif(10, 49, 60), long = runif(10, -128, -120), 
                 stringsAsFactors = FALSE)
head(spp)

## ------------------------------------------------------------------------
coordinates(spp) <- c("long", "lat")
summary(spp)
plot(spp)

## ------------------------------------------------------------------------
proj4string(spp) <- "+init=epsg:4269"

## ----collapse=TRUE-------------------------------------------------------
proj4string(bc_bound)
proj4string(spp)

## ------------------------------------------------------------------------
spp <- spTransform(spp, CRSobj = proj4string(bc_bound))

## ------------------------------------------------------------------------
plot(bc_bound)
points(spp, pch = 21, bg = spp$spp_present)

## ----message=FALSE-------------------------------------------------------
# Convert the bc_bound SpatialPolygonsDataFrame into a regular data frame for ggplot2 to use
bc_df <- fortify(bc_bound)

# combine the attribute data from spp with the transformed coordinates
spp_df <- cbind(spp@data, coordinates(spp))

ggplot(bc_df, aes(x = long, y = lat, group = group)) + 
  geom_polygon() + 
  geom_point(data = spp_df, 
             aes(x = long, y = lat, group = NULL, colour = spp_present)) + 
  coord_fixed() + 
  theme_minimal() + 
  theme(line = element_blank(), axis.title = element_blank(), axis.text = element_blank())

