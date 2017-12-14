context("test layer download from bcmaps.rdata")

test_that("test that all sf layer function work without error and returns an sf object as default", {
  skip_on_cran()
  skip_if_not_installed("bcmaps.rdata")
  fn_names <- available_layers()$Item
  for (i in seq_along(fn_names)) {
    #cat("\n", fn_names[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(), NA)
    expect_is(layer, "sf")
  }
})


test_that("test that all sp layer function work without error and return a Spatial* object ", {
  skip_on_cran()
  skip_if_not_installed("bcmaps.rdata")
  fn_names_sp <- available_layers()$Item
  for (i in seq_along(fn_names_sp)) {
    #cat("\n", fn_names_sp[i]) #for debugging
    expect_error(layer <- match.fun(fn_names_sp[i])(class="sp"), NA)
    expect_is(layer, "Spatial")
  }
})




