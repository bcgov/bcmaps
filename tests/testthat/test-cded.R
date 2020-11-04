test_that("list_mapsheet_files works", {
  skip_on_cran()
  skip_if_offline()

  res <- list_mapsheet_files("https://pub.data.gov.bc.ca/datasets/175624/82g")
  expect_type(res, "character")
  expect_length(res, 60L)
  expect_equal(sum(grepl("^082g.+md5$", res)), 30)
  expect_equal(sum(grepl("^082g.+zip$", res)), 30)
})
