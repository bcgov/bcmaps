context("test layer load from bcmaps.rdata")

if (requireNamespace("bcmaps.rdata", quietly = TRUE)) {
  avail <- available_layers()
  fn_names <- avail[avail$local & avail$shortcut_function, "layer_name"]
}

test_that("test that all sf layer function work without error and returns an sf object as default", {
  skip_on_cran()
  skip_if_not_installed("bcmaps.rdata")
  for (i in seq_along(fn_names)) {
    #cat("\n", fn_names[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(), NA)
    expect_is(layer, "sf")
  }
})

test_that("test that all sp layer function work without error and return a Spatial* object ", {
  skip_on_cran()
  skip_if_not_installed("bcmaps.rdata")
  for (i in seq_along(fn_names)) {
    #cat("\n", fn_names_sp[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(class = "sp"), NA)
    expect_is(layer, "Spatial")
  }
})
