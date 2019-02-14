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
  skip_if_not_installed("bcmapsdata")
  sf_out <- sf_bbox_to_vec(bc_bbox())
  expect_equal(bc_bbox(), sf::st_bbox(bc_bound()))
  expect_equal(sp_bbox_to_vec(bc_bbox("sp")), sf_out)
  expect_equal(Extent_to_vec(bc_bbox("raster")), sf_out)
})

test_that("bc_bbox works with all classes and numeric crs", {
  skip_on_cran()
  skip_if_not_installed("bcmapsdata")
  sf_out <- sf_bbox_to_vec(bc_bbox(crs = 4326))
  expect_equal(sp_bbox_to_vec(bc_bbox("sp", crs = 4326)), sf_out)
  expect_equal(Extent_to_vec(bc_bbox("raster", crs = 4326)), sf_out)
})

test_that("bc_bbox works with all classes and character crs", {
  skip_on_cran()
  skip_if_not_installed("bcmapsdata")
  sf_out <- sf_bbox_to_vec(bc_bbox(crs = "+init=epsg:3857"))
  expect_equal(sp_bbox_to_vec(bc_bbox("sp", crs = "+init=epsg:3857")), sf_out)
  expect_equal(Extent_to_vec(bc_bbox("raster", crs = "+init=epsg:3857")), sf_out)
})
