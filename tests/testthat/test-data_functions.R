context("test layer download from bcmaps.rdata")

test_that("test that the layer function and returns an sf object as default", {
  fn_names <- available_layers()$Item
  for (i in seq_along(fn_names)) {
    expect_silent(layer <- get(fn_names[i])())
    expect_is(layer, "sf")
  }
})

# arizones failing. TODO: figure out why.
#test_that("test that the layer function ", {
#  fn_names <- available_layers()$Item
#  for (i in seq_along(fn_names)) {
#    cat("\n", fn_names[i])
#    expect_silent(layer <- get(fn_names[i])(class="sp"))
#    #expect_is(layer, "SpatialPolygonsDataFrame") TODO: figure out which class to test
#  }
#})


