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
    x = c(500000, 800000),
    y = c(5000000, 3000000)
  )
  out <- utm_convert(df, "x", "y", zone = 11)
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 6)
  out <- utm_convert(df, "x", "y", zone = 11, xycols = FALSE)
  expect_equal(ncol(out), 4)
})

test_that("utm_convert works with a single zone as a character string (e.g., 10N)", {
  df <- data.frame(
    animalid = c("a", "b"),
    easting = c(500000, 800000),
    northing = c(5000000, 3000000)
  )
  out <- utm_convert(df, "easting", "northing", zone = "11N")
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 6)
  out <- utm_convert(df, "easting", "northing", zone = "11N", xycols = FALSE)
  expect_equal(ncol(out), 4)
})

test_that("utm_convert works with a zone column with zone as a character", {
  df <- data.frame(
    animalid = c("a", "b", "c"),
    zone = c("10N", "11N", "11N"),
    easting = c(500000, 800000, 700000),
    northing = c(5000000, 3000000, 1000000)
  )
  out <- utm_convert(df, "easting", "northing", "zone")
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 7)
  out <- utm_convert(df, "easting", "northing", "zone", xycols = FALSE)
  expect_equal(ncol(out), 5)
})

test_that("utm_convert works with different datums", {
  df <- data.frame(
    animalid = c("a", "b", "c"),
    zone = c(10, 11, 11),
    easting = c(500000, 800000, 700000),
    northing = c(5000000, 3000000, 1000000)
  )
  out <- utm_convert(df, "easting", "northing", "zone")
  expect_s3_class(out, "sf")
  expect_equal(ncol(out), 7)
  out <- utm_convert(df, "easting", "northing", "zone", datum = "WGS84", xycols = FALSE)
  expect_equal(ncol(out), 5)
})

test_that("utm_convert errors expectedly", {
  df <- data.frame(
    animalid = c("a", "b", "c", "d"),
    zone = c(10, 11, 11, 163),
    easting = c(500000, 800000, 700000, 600000),
    northing = c(5000000, 3000000, 1000000, 1000000)
  )
  expect_error(utm_convert(df, "easting", "northing", "zone"), "Invalid zone")
  df <- data.frame(
    animalid = c("a", "b", "c", "d"),
    easting = c(500000, 800000, 700000, 600000),
    northing = c(5000000, 3000000, 1000000, 1000000)
  )
  expect_error(utm_convert(df, "easting", "northing", "10S"), "Southern hemisphere")
  df <- data.frame(
    animalid = c("a", "b", "c", "d"),
    easting = c(500000, 800000, 700000, 600000),
    northing = c(5000000, 3000000, 1000000, 1000000)
  )
  expect_error(utm_convert(df, "easting", "northing", "10D"), "Invalid zone")
  df <- data.frame(
    animalid = c("a", "b", "c"),
    zone = c("10N", "11N", "11R"),
    easting = c(500000, 800000, 700000),
    northing = c(5000000, 3000000, 1000000)
  )
  expect_error(utm_convert(df, "easting", "northing", "zone"), "Invalid zone")
})

