context("test layer load")


avail <- available_layers()
fn_names <- avail$layer_name[!is.na(avail$local)]


test_that("test that all sf layer function work without error and returns an sf object as default", {
  skip_on_cran()
  for (i in seq_along(fn_names)) {
    #cat("\n", fn_names[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(ask = FALSE), NA)
    expect_is(layer, "sf")
    expect_equal(attr(layer, "sf_column"), "geometry")
  }
})

test_that("test that all sp layer function work without error and return a Spatial* object ", {
  skip_on_cran()
  for (i in seq_along(fn_names)) {
    #cat("\n", fn_names_sp[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(class = "sp", ask = FALSE), NA)
    expect_is(layer, "Spatial")
  }
})

