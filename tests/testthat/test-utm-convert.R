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

test_that("Output minus sf stuff is same as input (#146)", {
  data <- data.frame(
    Row_ID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    NotSure = c(9608, 9609, 9610, 9611, 9612, 9613, 9614, 9615, 9616, 9617),
    Zone = c(10, 10, 10, 10, 10, 10, 9, 9, 9, 9),
    UTMe = c(
      361775,
      361775,
      307196,
      307196,
      328213,
      328213,
      636424,
      636648,
      636795,
      637401
    ),
    UTMn = c(
      6011950,
      6011950,
      5979777,
      5979777,
      5984261,
      5984261,
      6161177,
      6161270,
      6161127,
      6160851
    ),
    UTMe1 = c(
      361775,
      361775,
      307196,
      307196,
      328213,
      328213,
      636424,
      636648,
      636795,
      637401
    ),
    UTMn1 = c(
      6011950,
      6011950,
      5979777,
      5979777,
      5984261,
      5984261,
      6161177,
      6161270,
      6161127,
      6160851
    )
  )
  rownames(data) <- letters[seq_len(nrow(data))]

  out_df <- utm_convert(
    data,
    easting = "UTMe",
    northing = "UTMn",
    zone = "Zone"
  )

  expect_equal(
    data, 
    sf::st_drop_geometry(out_df)[, setdiff(names(out_df), c("X", "Y", "geometry")), drop = FALSE]
  )

  # Check with tibble
  data_tbl <- structure(data, class = c("tbl_df", "tbl", "data.frame"))
  rownames(data_tbl) <- NULL

  out_tbl <- utm_convert(
    data_tbl,
    easting = "UTMe",
    northing = "UTMn",
    zone = "Zone"
  )
  
  expect_s3_class(out_tbl, "tbl_df")
  
  expect_equal(
    data_tbl, 
    sf::st_drop_geometry(out_tbl)[, setdiff(names(out_tbl), c("X", "Y", "geometry")), drop = FALSE],
    check.attributes = FALSE
  )

})
