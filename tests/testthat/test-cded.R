library(sf)
mapsheets_sf <- mapsheets_250K()

test_that("list_mapsheet_files works", {
  skip_on_cran()
  skip_if_offline()

  res <- list_mapsheet_files("https://pub.data.gov.bc.ca/datasets/175624/82g")
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
  expect_equal(sort(basename(dirs)), sort(bc_mapsheet_names()))
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

test_that("cded works with mapsheets", {
  skip_on_cran()
  skip_if_offline()

  vrt <- cded(mapsheets = c("102o", "95d"))

  expect_true(file.exists(vrt))

  tifs <- vrt_files(vrt, omit_vrt = TRUE)

  expect_equal(sort(basename(tifs)),
               c("095d01_e.tif", "095d01_w.tif", "095d02_e.tif", "095d02_w.tif",
                 "095d03_e.tif", "095d03_w.tif", "095d04_e.tif", "095d04_w.tif",
                 "102o14_e.tif", "102o14_w.tif", "102o15_e.tif", "102o15_w.tif"
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
})
