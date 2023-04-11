context("test-utils")

Extent_to_vec <- function(x) {
  ret <- vapply(slotNames(x), function(y) slot(x, y), FUN.VALUE = numeric(1))
  ret[c("xmin", "ymin", "xmax", "ymax")]
}

sp_bbox_to_vec <- function(x) {
  c(
    xmin = x["x", "min"],
    ymin = x["y", "min"],
    xmax = x["x", "max"],
    ymax = x["y", "max"]
  )
}

sf_bbox_to_vec <- function(x) {
  ret <- as.numeric(x)
  names(ret) <- names(x)
  ret[c("xmin", "ymin", "xmax", "ymax")]
}

test_that("bc_bbox works with all classes", {
  skip_on_cran()
  sf_out <- sf_bbox_to_vec(bc_bbox())
  expect_equivalent(bc_bbox(), sf::st_bbox(bc_bound()))
  lifecycle::expect_deprecated(
    expect_equal(sp_bbox_to_vec(bc_bbox("sp")), sf_out)
  )
  expect_equal(Extent_to_vec(bc_bbox("raster")), sf_out)
})

test_that("bc_bbox works with all classes and numeric crs", {
  skip_on_cran()
  sf_out <- sf_bbox_to_vec(bc_bbox(crs = 4326))
  lifecycle::expect_deprecated(
    expect_equal(sp_bbox_to_vec(bc_bbox("sp", crs = 4326)), sf_out)
  )
  expect_equal(Extent_to_vec(bc_bbox("raster", crs = 4326)), sf_out)
})

test_that("update_message_once warns once and only once", {
  skip_on_cran() # odd failure on win-builder from testthat::expect_silent writing file to disk. permissions issue?
  options("silence_update_message" = FALSE)
  expect_message(update_message_once("artoo"))
  expect_silent(update_message_once("artoo"))
  options("silence_update_message" = TRUE)
})

test_that("clean_geos_version works", {
  # https://github.com/bcgov/bcmaps/issues/71
  expect_equal(clean_geos_version("3.9.0-dev"), "3.9.0-9999")
  expect_equal(clean_geos_version("3.9.0.dev"), "3.9.0-9999")
  expect_equal(clean_geos_version("3.9.0dev"), "3.9.0-9999")
  expect_equal(clean_geos_version("3.9.0-dev-1"), "3.9.0-9999-1")
  expect_equal(clean_geos_version("3.9.0.dev.1"), "3.9.0-9999-1")
  expect_equal(clean_geos_version("3.9.0dev1"), "3.9.0-9999-1")
  expect_equal(clean_geos_version("3.9.0"), "3.9.0")

  expect_equal(unclass(numeric_version(clean_geos_version("3.9.0dev1"))), list(c(3, 9, 0, 9999, 1)))
  expect_equal(unclass(numeric_version(clean_geos_version("3.9.0-dev-1"))), list(c(3, 9, 0, 9999, 1)))
})
