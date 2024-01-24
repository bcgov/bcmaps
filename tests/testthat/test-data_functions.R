context("test layer load")

avail <- available_layers()
fn_names <- avail$layer_name[!(avail$local) &
                               !grepl("cded_", avail$layer_name)]

# Only test bec and tsa once in a while - they're really big
donttest <- c("bec", "tsa")
# Skip fsa on ci - statcan server can timeout a lot
if (nzchar(Sys.getenv("CI"))) {
  donttest <- c(donttest, "fsa")
}
fn_names <- setdiff(fn_names, donttest)

test_that("All sf layer function work without error and returns an sf object.", {
  skip_on_cran()
  skip_if_offline()

  for (i in seq_along(fn_names)) {
    # cat("\n", fn_names[i]) #for debugging
    expect_error(layer <- match.fun(fn_names[i])(ask = FALSE), NA)
    expect_is(layer, "sf")
    expect_equal(attr(layer, "sf_column"), "geometry")
    expect_true(all(sf::st_is_valid(layer)))
    expect_equal(st_crs(layer)$wkt, st_crs("EPSG:3005")$wkt)
  }
})
