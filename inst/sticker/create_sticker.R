library(hexSticker)
library(ggplot2) ##dev version
library(bcmaps)

bc_bound_hres <- bc_bound_hres()
water_districts <- water_districts()



p <- ggplot() +
  geom_sf(data = water_districts, aes(fill = DISTRC_NAM), size = 0.05) +
  geom_sf(data = bc_bound_hres, fill = NA, size = 0.05) +
  guides(fill = FALSE) +
  scale_fill_viridis_d() +
  theme_void() +
  theme_transparent()

sticker(p, package="bcmaps",
        p_size=16, p_y = 0.35, p_color = "black", p_family = "wqy-microhei",
        s_x=1, s_y=1,
        s_width=1.3, s_height=1.3,
        h_fill = "white",h_color = "black",
        spotlight = TRUE,
        filename=file.path("inst/sticker/bcmaps.png"))
