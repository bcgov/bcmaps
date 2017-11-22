context("data from gh release")

# test.rds is saved on release 0.1.1
test <- function(class = c("sf", "sp")) get_big_data("test", class, "latest")

get_big_data("test", "sf", "latest")

get_big_data("test", "sf", "0.1.1")
get_big_data("test", "sf", "0.1.0") # error
