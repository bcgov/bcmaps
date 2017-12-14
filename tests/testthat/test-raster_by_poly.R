context("raster_by_poly")

if (require("raster") && require("sp")) {
  # A raster
  r <- raster(system.file("external/test.grd", package = "raster"))

  # Make a SPDF of two polygons that covers the raster
  rl <- crop(r, extent(c(178400, 180000, 329400, 334000)))
  pl <- SpatialPolygonsDataFrame(aggregate(rasterToPolygons(rl)), data = data.frame(name = "Left"))
  rr <- mask(r, pl, inverse = TRUE)
  pr <- SpatialPolygonsDataFrame(aggregate(rasterToPolygons(rr)), data = data.frame(name = "Right"))
  p <- raster::bind(pl, pr)

  ex <- raster::extract(r, p)

  r_by_p <- raster_by_poly(r, p, "name")
  r_by_p_sum <- raster_by_poly(r, p, "name", summarize = TRUE)

  test_that("raster_by_poly works", {
    expect_is(r_by_p, "list")
    expect_is(r_by_p[[1]], "RasterLayer")
    expect_is(r_by_p[[2]], "RasterLayer")
  })

  test_that("raster_by_poly works with sf", {
    expect_equal(raster_by_poly(r, sf::st_as_sf(p), "name"), r_by_p)
  })

  test_that("summarize_raster_list works", {
    expect_equal(r_by_p_sum, summarize_raster_list(r_by_p))
    expect_equal(lapply(ex, sort), unname(lapply(r_by_p_sum, sort)))
  })

  if (requireNamespace("doMC", quietly = TRUE)) {
    test_that("parallel works", {
      skip("skipping parallel test") # This fails in R CMD check but not running testthat::test_package()
      expect_equal(r_by_p_sum, raster_by_poly(r, p, "name", summarize = TRUE, parallel = TRUE, cores = 2))
    })
  }
}
