# Don't need to run this again, but this is how we got the utm zone-lookup table

library(rvest)
library(janitor)
library(dplyr)

html <- read_html("https://docs.up42.com/data/reference/utm")

nad83_lookup <- html_table(html)[[3]] |>
  clean_names() |>
  mutate(zone_numeric = as.numeric(gsub("N", "", utm_zone)),
         datum = "NAD83")

wgs84_lookup <- html_table(html)[[1]] |>
  clean_names() |>
  mutate(zone_numeric = as.numeric(gsub("N", "", utm_zone)),
         datum = "WGS84")

bind_rows(nad83_lookup, wgs84_lookup) |>
  readr::write_csv("data-raw/zone-lookup.csv")
