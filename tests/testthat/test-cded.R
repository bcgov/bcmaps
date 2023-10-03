library(sf)
mapsheets_sf <- mapsheets_250K()
mapsheets_50_sf <- mapsheets_50K()

test_that("list_mapsheet_files works", {
  skip_on_cran()
  skip_if_offline()

  res <- list_mapsheet_files("https://pub.data.gov.bc.ca/datasets/175624/82g/")
  expect_type(res, "character")
  expect_length(res, 60L)
  expect_equal(sum(grepl("^082g.+md5$", res)), 30)
  expect_equal(sum(grepl("^082g.+zip$", res)), 30)
})

# test mapsheets with few/small files:
# 102o, 82o
# 95d (in NWT, not in bcdc version of 1:250k grid)

test_that("making cded cache directory works", {
  # Setup test cache dir
  mapsheet_dir <- tempdir()
  dirs <- make_mapsheet_dirs(mapsheet_dir)

  on.exit(unlink(mapsheet_dir, recursive = TRUE, force = TRUE), add = TRUE)
  expect_equal(sort(basename(dirs)), sort(bc_mapsheet_250K_names()))
  expect_true(all(dir.exists(dirs)))
})

test_that("get_mapsheet_tiles works", {
  skip_on_cran()
  skip_if_offline()

  cache_dir <- make_local_cded_cache()

  expect_message(
    tifs <- get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir),
    "Fetching tiles for mapsheet 82o"
  )

  expect_true(all(file.exists(tifs)))

  expect_message(
    get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir),
    "checking your existing tiles"
  )

  expect_silent(
    get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir, check_tiles = FALSE)
  )

  # edit local md5 file to force a re-download
  cat("cccchanges!", file = file.path(cache_dir, "82o/082o05_w.dem.zip.md5"), append = TRUE)

  expect_message(
    get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir),
    "hash mismatch"
  )

  # Remove a tif to force a re-download
  expect_true(
    all(file.remove(file.path(cache_dir, c("82o/082o05_w.tif", "82o/082o05_w.dem.zip.md5"))))
  )

  expect_message(
    tifs <- get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir),
    "Fetching tiles for mapsheet 82o"
  )

  expect_true(all(file.exists(tifs)))

})

test_that("cded works with tiles_50K", {
  skip_on_cran()
  skip_if_offline()

  vrt <- cded(tiles_50K = c("102o14", "095d01"))

  expect_true(file.exists(vrt))

  tifs <- vrt_files(vrt, omit_vrt = TRUE)

  expect_equal(sort(basename(tifs)),
               c("095d01_e.tif", "095d01_w.tif",
                 "102o14_e.tif", "102o14_w.tif"
               ))
})

test_that("cded works with aoi", {
  skip_on_cran()
  skip_if_offline()

  aoi <- st_buffer(mapsheets_sf[mapsheets_sf$MAP_TILE_DISPLAY_NAME == "102o", ], -100)

  vrt <- cded(aoi)

  expect_true(file.exists(vrt))

  tifs <- vrt_files(vrt, omit_vrt = TRUE)

  expect_equal(sort(basename(tifs)),
               c("102o14_e.tif", "102o14_w.tif", "102o15_e.tif", "102o15_w.tif"
               ))

  # With an aoi smaller than a single 50K tile
  aoi <- st_buffer(mapsheets_50_sf[mapsheets_50_sf$NTS_SNRC == "095B04", ], -100)

  vrt <- cded(aoi)

  expect_true(file.exists(vrt))

  tifs <- vrt_files(vrt, omit_vrt = TRUE)

  expect_equal(sort(basename(tifs)),
               c("095b04_e.tif", "095b04_w.tif"))
})

test_that("cded works with aoi with a different projection as mapsheets_250K", {
  skip_on_cran()
  skip_if_offline()

  aoi <- st_transform(st_buffer(mapsheets_sf[mapsheets_sf$MAP_TILE_DISPLAY_NAME == "102o", ], -100), 4326)


  vrt <- cded(aoi)

  expect_true(file.exists(vrt))

  tifs <- vrt_files(vrt, omit_vrt = TRUE)

  expect_equal(sort(basename(tifs)),
               c("102o14_e.tif", "102o14_w.tif", "102o15_e.tif", "102o15_w.tif"
               ))
})


if (require("stars")) {
  skip_on_cran()
  skip_if_offline()

  pol1 <- mapsheets_50K()[1,]
  s <- st_as_stars(pol1)
  bound_box <- st_bbox(s)

  test_that("cded_stars accepts all inputs", {
    expect_is(cded_stars(s), "stars")
    expect_is(cded_stars(pol1), "stars")
    expect_is(cded_stars(bound_box), "stars")
  })

}

if (require("terra")) {
  skip_on_cran()
  skip_if_offline()

  pol1 <- mapsheets_50K()[1,]
  r <- rast(pol1)
  bound_box <- st_bbox(pol1)

  test_that("cded_terra accepts all inputs", {
    expect_is(cded_terra(r), "SpatRaster")
    expect_is(cded_terra(pol1), "SpatRaster")
    expect_is(cded_terra(bound_box), "SpatRaster")
  })
}

