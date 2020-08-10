
## Code to prepare the layers_df internal data
layers_df <- readr::read_csv("data-raw/layers_df.csv")

layers_df <- layers_df[!is.na(layers_df$record),]

usethis::use_data(layers_df, internal = TRUE, overwrite = TRUE, compress = "xz")


