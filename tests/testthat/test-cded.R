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
  cache_dir <- make_local_cded_cache()

  tifs <- get_mapsheet_tiles(mapsheet = "82o", dir = cache_dir)

  expect_true(all(file.exists(tifs)))
})
