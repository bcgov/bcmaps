## ----message=FALSE-------------------------------------------------------
library(sf)
library(bcmaps)

## ------------------------------------------------------------------------
set.seed(42)
spp <- data.frame(id = 1:10, spp_present = as.logical(rbinom(10,1,0.5)),
                 lat = runif(10, 49, 60), long = runif(10, -128, -120), 
                 stringsAsFactors = FALSE)
head(spp)

## ------------------------------------------------------------------------
spp <- st_as_sf(spp, coords = c("long", "lat"))
summary(spp)
plot(spp[, "spp_present"])

## ------------------------------------------------------------------------
spp <- st_set_crs(spp, 4326)

## ----collapse=TRUE-------------------------------------------------------
bc_bound <- get_layer("bc_bound")
st_crs(bc_bound)
st_crs(spp)

## ------------------------------------------------------------------------
spp <- st_transform(spp, st_crs(bc_bound))

## ------------------------------------------------------------------------
plot(bc_bound)
plot(spp, add = TRUE)

## ----message=FALSE-------------------------------------------------------
# Convert the bc_bound SpatialPolygonsDataFrame into a regular data frame for ggplot2 to use
# bc_df <- fortify(bc_bound)
# 
# # combine the attribute data from spp with the transformed coordinates
# spp_df <- cbind(spp@data, coordinates(spp))
# 
# ggplot(bc_df, aes(x = long, y = lat, group = group)) + 
#   geom_polygon() + 
#   geom_point(data = spp_df, 
#              aes(x = long, y = lat, group = NULL, colour = spp_present)) + 
#   coord_fixed() + 
#   theme_minimal() + 
#   theme(line = element_blank(), axis.title = element_blank(), axis.text = element_blank())

