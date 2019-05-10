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
    # Ensure options that are changed inside the functions are restored
    omax_global_size <- getOption("future.globals.maxSize")
    oplan <- future::plan()
    expect_equal(raster_by_poly(r, p, "name", parallel = TRUE), r_by_p)
    expect_equal(raster_by_poly(r, p, "name", summarize = TRUE, parallel = TRUE),
                 r_by_p_sum)
    expect_equal(omax_global_size, getOption("future.globals.maxSize"))
    expect_equal(class(future::plan()), class(oplan))
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

test_that("setup_future works", {
  skip_if_not_installed("future")
  # Ensure options that are changed inside the functions are restored
  omax_global_size <- getOption("future.globals.maxSize")
  oplan <- future::plan()

  # Tester function with which to call setup_future
  z <- function(future_strategy = NULL, workers = NULL, ...)
    setup_future(future_strategy, workers, ...)

  # With NULL defaults
  expect_message(z(), "Running in parallel using a 'multiprocess' strategy with ",
                 future::availableCores(), " workers")
  expect_equal(class(future::plan()), class(oplan))
  expect_equal(omax_global_size, getOption("future.globals.maxSize"))

  # Setting explicitly
  expect_message(z("cluster", 2), "Running in parallel using a 'cluster' strategy with 2 workers")
  expect_equal(class(future::plan()), class(oplan))
  expect_equal(omax_global_size, getOption("future.globals.maxSize"))

  # With having a pre-set plan
  future::plan("multisession", workers = 2)
  oplan <- future::plan()
  expect_message(z(), "Running in parallel using a 'multisession' strategy with 2 workers")
  expect_equal(future::plan(), oplan)
  expect_equal(omax_global_size, getOption("future.globals.maxSize"))
})
