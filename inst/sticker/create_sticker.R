library(hexSticker)
library(ggplot2) ##dev version
library(bcmaps)
library(sf)
library(dplyr)
library(rmapshaper)

rd_terr <- st_intersection(combine_nr_rd(), bc_bound()) %>%
  select(ADMIN_AREA_NAME) %>%
  ms_simplify()

(p <- ggplot() +
  geom_sf(data = rd_terr, aes(fill = ADMIN_AREA_NAME), size = 0.05) +
  guides(fill = FALSE) +
  scale_fill_viridis_d() +
  theme_void() +
  theme_transparent() +
  theme(panel.grid.major = element_line(colour = "grey60", size = 0.1)))

sysfonts::font_add("Century Gothic", "/Library/Fonts/Microsoft/Century Gothic")

sticker(p, package = "bcmaps",
        p_size = 5, # This seems to behave very differently on a Mac vs PC
        p_y = 0.4, p_color = "#482475", p_family = "Century Gothic",
        s_x = 1, s_y = 1.05,
        s_width = 1.3, s_height = 1.3,
        h_fill = "white",h_color = "#482475",
        filename = file.path("inst/sticker/bcmaps.png"))
