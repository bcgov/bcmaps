context("raster_by_poly")

if (require("raster") && require("sp")) {
  # A raster
  r <- raster(system.file("external/test.grd", package = "raster"))

  # Make a SPDF of two polygons that covers the raster
  rl <- crop(r, extent(c(178400, 180000, 329400, 334000)))
  pl <- SpatialPolygonsDataFrame(aggregate(rasterToPolygons(rl)),
                                 data = data.frame(name = "Left", stringsAsFactors = FALSE))
  rr <- mask(r, pl, inverse = TRUE)
  pr <- SpatialPolygonsDataFrame(aggregate(rasterToPolygons(rr)),
                                 data = data.frame(name = "Right", stringsAsFactors = FALSE))
  p <- raster::bind(pl, pr)

  ex <- raster::extract(r, p)

  r_by_p <- raster_by_poly(r, p, "name")
  r_by_p_sum <- raster_by_poly(r, p, "name", summarize = TRUE)

  test_that("raster_by_poly works", {
    expect_is(r_by_p, "list")
    expect_is(r_by_p[[1]], "RasterLayer")
    expect_is(r_by_p[[2]], "RasterLayer")
  })

  test_that("raster_by_poly works with parallel", {
    skip_if_not_installed("future.apply")
    oplan <- future::plan(future::multisession(workers = ifelse(future::nbrOfWorkers() > 1L, 2L, 1L)))
    expect_equal(raster_by_poly(r, p, "name", parallel = TRUE), r_by_p)
    expect_equal(raster_by_poly(r, p, "name", summarize = TRUE, parallel = TRUE),
                 r_by_p_sum)
    on.exit(future::plan(oplan), add = TRUE)
  })

  test_that("raster_by_poly fails when a name is NA", {
    p$name[2] <- NA
    expect_error(raster_by_poly(r, p, "name"),
                 "NA values exist in the 'name' column in p")
  })

  test_that("raster_by_poly works with sf", {
    expect_equal(raster_by_poly(r, sf::st_as_sf(p), "name"), r_by_p)
  })

  test_that("summarize_raster_list works", {
    expect_equal(r_by_p_sum, summarize_raster_list(r_by_p))
    expect_equal(lapply(ex, sort), unname(lapply(r_by_p_sum, sort)))
  })
}
