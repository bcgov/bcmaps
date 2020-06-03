
## Code to prepare the layers_df internal data
layers_df <- readr::read_csv("data-raw/layers_df.csv")

usethis::use_data(layers_df, overwrite = TRUE)


