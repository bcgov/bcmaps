context("test-cache-utils")


test_that("the cache is deleted",{
  expect_is(airzones(ask = FALSE, force = TRUE), "sf")
  expect_true(delete_cache("airzones"))
  expect_is(airzones(ask = FALSE, force = TRUE), "sf")
  expect_true(delete_cache("airzones.rds"))
})
