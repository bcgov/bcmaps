context("data from gh release")

# test.rds is saved on release 0.1.1
test <- function(class = c("sf", "sp")) get_big_data("test", class, "latest")

get_big_data("test", "sf", "latest")

get_big_data("test", "sf", "0.1.1")

test_that("get_big_data fails when file doesn't exist", {
  expect_error(get_big_data("test", "sf", "0.1.0"), "No assets matching filename test.rds in 0.1.0 release")
})

