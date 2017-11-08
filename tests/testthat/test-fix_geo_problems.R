context("fix_geo_problems")

fixing_msg <- "Problems"
valid_msg <- "Geometry is valid"
other_prob_msg <- "there were other problems"

if (suppressPackageStartupMessages(require("rgeos"))) {

  p1 <- rgeos::readWKT("POLYGON ((0 60, 0 0, 60 0, 60 60, 0 60), (20 40, 20 20, 40 20, 40 40, 20 40))")
  p2 <- rgeos::readWKT("POLYGON ((0 60, 0 0, 60 0, 60 60, 0 60), (20 40, 20 20, 60 20, 20 40))")
  p3 <- rgeos::readWKT(paste("POLYGON ((0 120, 0 0, 140 0, 140 120, 0 120),",
                             "(100 100, 100 20, 120 20, 120 100, 100 100),",
                             "(20 100, 20 40, 100 40, 20 100))"))

  p4 <- rgeos::readWKT("POLYGON ((0 40, 0 0, 40 40, 40 0, 0 40))")
  p5 <- rgeos::readWKT("POLYGON ((-10 50, 50 50, 50 -10, -10 -10, -10 50), (0 40, 0 0, 40 40, 40 0, 0 40))")
  p6 <- rgeos::readWKT("POLYGON ((0 60, 0 0, 60 0, 60 20, 100 20, 60 20, 60 60, 0 60))")
  p7 <- rgeos::readWKT(paste("POLYGON ((40 300, 40 20, 280 20, 280 300, 40 300),",
                             "(120 240, 80 180, 160 220, 120 240),",
                             "(220 240, 160 220, 220 160, 220 240),",
                             "(160 100, 80 180, 100 80, 160 100),",
                             "(160 100, 220 160, 240 100, 160 100))"))
  p8 <- rgeos::readWKT(paste("POLYGON ((40 320, 340 320, 340 20, 40 20, 40 320),",
                             "(100 120, 40 20, 180 100, 100 120),",
                             "(200 200, 180 100, 240 160, 200 200),",
                             "(260 260, 240 160, 300 200, 260 260),",
                             "(300 300, 300 200, 340 320, 300 300))"))
  p9 <- rgeos::readWKT(paste("MULTIPOLYGON (((20 380, 420 380, 420 20, 20 20, 20 380),",
                             "(220 340, 180 240, 60 200, 200 180, 340 60, 240 220, 220 340)),",
                             "((60 200, 340 60, 220 340, 60 200)))"))

  test_that("works with valid geometries", {
    expect_message(out <- fix_geo_problems(p1), valid_msg, ignore.case = TRUE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p2), valid_msg, ignore.case = TRUE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p3), valid_msg, ignore.case = TRUE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
  })

  test_that("works with self-intersections", {
    expect_message(out <- fix_geo_problems(p4), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p4), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p5), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p5), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p6), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p6), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
  })

  test_that("works with other problems", {
    expect_message(out <- fix_geo_problems(p7), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p7), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p8), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p8), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
    expect_message(out <- fix_geo_problems(p9), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_message(out <- fix_geo_problems(p9), valid_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "SpatialPolygons")
    expect_true(rgeos::gIsValid(out))
  })

}


## SF

if (suppressPackageStartupMessages(require("sf"))) {

  test_that("works with valid geometries: sf", {
    expect_message(out <- fix_geo_problems(st_as_sf(p1)), valid_msg, ignore.case = TRUE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    expect_message(out <- fix_geo_problems(st_as_sf(p2)), valid_msg, ignore.case = TRUE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    expect_message(out <- fix_geo_problems(st_as_sf(p3)), valid_msg, ignore.case = TRUE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
  })

  test_that("works with self-intersections: sf", {
    expect_message(out <- fix_geo_problems(st_as_sf(p4)), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    expect_message(out <- fix_geo_problems(st_as_sf(p5)), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    expect_message(out <- fix_geo_problems(st_as_sf(p6)), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
  })

  test_that("works with other problems: sf", {
    expect_message(out <- fix_geo_problems(st_as_sf(p7)), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    expect_message(out <- fix_geo_problems(st_as_sf(p8)), fixing_msg, ignore.case = TRUE, all = FALSE)
    expect_is(out, "sf")
    expect_true(all(st_is_valid(out)))
    # expect_message(out <- fix_geo_problems(st_as_sf(p9)), fixing_msg, ignore.case = TRUE, all = FALSE)
    # expect_is(out, "sf")
    # expect_true(all(st_is_valid(out)))
  })
}
