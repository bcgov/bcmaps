context("test-cache-utils")

test_that("show_cached_files works", {
  skip_on_cran()
  skip_if_offline()

  datadir <- file.path(tempdir(), "bcmaps")
  withr::local_options(list("bcmaps.data_dir" = datadir))
  cded_dir <- file.path(data_dir(), "cded")
  dir.create(cded_dir, recursive = TRUE, showWarnings = FALSE)

  expect_is(airzones(ask = FALSE, force = TRUE), "sf")
  get_mapsheet_tiles("82o", cded_dir)
  cache_info <- show_cached_files()
  expect_s3_class(cache_info, "data.frame")
  expect_equal(names(cache_info), c("file", "is_dir", "size_MB", "modified"))
  expect_true(sum(cache_info$size_MB) > 10)
  expect_equal(cache_info$is_dir, c(FALSE, TRUE))
})

test_that("the cache is deleted",{
  skip_on_cran()
  skip_if_offline()
  expect_is(airzones(ask = FALSE, force = TRUE), "sf")
  expect_true(delete_cache("airzones"))
  expect_is(airzones(ask = FALSE, force = TRUE), "sf")
  expect_true(delete_cache("airzones.rds"))
  delete_cache()
  expect_equal(list.files(data_dir(), pattern = "\\.rds"), character(0))
})
