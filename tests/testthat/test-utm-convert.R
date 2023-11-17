test_that("utm_convert works with a zone column", {
  df <- data.frame(
    animalid = c("a", "b", "c"),
    zone = c(10, 11, 11),
    easting = c(500000, 800000, 700000),
    northing = c(5000000, 3000000, 1000000)
  )
  out <- utm_convert(df, "easting", "northing", "zone")
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 7)
  out <- utm_convert(df, "easting", "northing", "zone", xycols = FALSE)
  expect_equal(ncol(out), 5)
})

test_that("utm_convert works with a single zone", {
  df <- data.frame(
    animalid = c("a", "b"),
    easting = c(500000, 800000),
    northing = c(5000000, 3000000)
  )
  out <- utm_convert(df, "easting", "northing", zone = 11)
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 6)
  out <- utm_convert(df, "easting", "northing", zone = 11, xycols = FALSE)
  expect_equal(ncol(out), 4)
})
