test_that("multiplication works", {
  df <- data.frame(
    animalid = c("a", "b", "c"),
    zone = c(10, 11, 11),
    easting = c(500000, 800000, 700000),
    northing = c(5000000, 3000000, 1000000)
  )
  out <- utm_convert(df, "easting", "northing", "zone", xycols = TRUE)
  expect_s3_class(out, "sf")
})
