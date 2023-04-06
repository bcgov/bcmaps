context("self_union")

if (suppressPackageStartupMessages(require("sp"))) {

  p1 <- Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
  p2 <- Polygon(cbind(c(5,4,3,2,5),c(2,3,3,2,2)))
  ps1 <- Polygons(list(p1), "s1")
  ps2 <- Polygons(list(p2), "s2")
  spp <- SpatialPolygons(list(ps1,ps2), 1:2)
  df <- data.frame(a = c("A", "B"), b = c("foo", "bar"),
                   stringsAsFactors = FALSE)
  spdf <- SpatialPolygonsDataFrame(spp, df, match.ID = FALSE)

  spp_out_data <- structure(list(union_count = c(1, 1, 2), union_ids = structure(list(
    `1` = 1, `2` = 2, `3` = c(1, 2)), .Names = c("1", "2", "3"
    ))), .Names = c("union_count", "union_ids"),
    row.names = c("1", "2", "3"), class = "data.frame")

  spdf_out_data <- structure(list(union_count = c(1, 1, 2), union_ids = structure(list(
    `1` = 1, `2` = 2, `3` = c(1, 2)), .Names = c("1", "2", "3"
    )), union_df = structure(list(
      `1` = structure(list(a = "A", b = "foo"),
                      .Names = c("a", "b"), row.names = 1L, class = "data.frame"), `2` = structure(list(
                        a = "B", b = "bar"), .Names = c("a", "b"), row.names = 2L, class = "data.frame"),
      `3` = structure(list(a = c("A", "B"), b = c("foo", "bar")),
                      .Names = c("a", "b"), row.names = 1:2, class = "data.frame")),
      .Names = c("1", "2", "3"))), .Names = c("union_count", "union_ids", "union_df"),
    row.names = c("1", "2", "3"), class = "data.frame")

  test_that("works with SpatialPolygons", {
    expect_is(expect_deprecated(self_union(spp)), "SpatialPolygonsDataFrame")
    expect_length(self_union(spp)@polygons, 3)
    expect_setequal(self_union(spp)@data$union_ids, spp_out_data$union_ids)
    expect_setequal(self_union(spp)@data$union_count, spp_out_data$union_count)
  })

  test_that("works with SpatialPolygonsDataFrame", {
    expect_is(expect_deprecated(self_union(spdf)), "SpatialPolygonsDataFrame")
    expect_length(self_union(spdf)@polygons, 3)
    expect_setequal(self_union(spdf)@data$union_count, spdf_out_data$union_count)
    expect_setequal(self_union(spdf)@data$union_ids, spdf_out_data$union_ids)
    expect_setequal(self_union(spdf)@data$union_df, spdf_out_data$union_df)
  })

  test_that("fails correctly", {
    expect_error(self_union("foo"), "x must be a SpatialPolygons or SpatialPolygonsDataFrame")
  })

}
