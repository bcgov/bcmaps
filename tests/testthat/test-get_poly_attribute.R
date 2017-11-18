context("get_poly_attribute")
if (suppressPackageStartupMessages(require("sp"))) {

  p1 <- Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
  p2 <- Polygon(cbind(c(5,4,3,2,5),c(2,3,3,2,2)))
  ps1 <- Polygons(list(p1), "s1")
  ps2 <- Polygons(list(p2), "s2")
  spp <- SpatialPolygons(list(ps1,ps2), 1:2)
  df <- data.frame(a = c(1, 2), b = c("foo", "bar"),
                   c = factor(c("high", "low"), ordered = TRUE,
                              levels = c("low", "high")),
                   stringsAsFactors = FALSE)
  spdf <- SpatialPolygonsDataFrame(spp, df, match.ID = FALSE)
  unioned_spdf <- self_union(spdf)

  test_that("works with numbers", {
    expect_equivalent(get_poly_attribute(unioned_spdf$union_df, "a", sum), c(1,2,3))
  })

  test_that("works with factors", {
    expect_equal(get_poly_attribute(unioned_spdf$union_df, "c", max),
                 factor(c("high", "low", "high"), ordered = TRUE, levels = c("low", "high")))
  })
}
