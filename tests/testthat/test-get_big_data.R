context("data from gh release")

# Shortcut function of the same form as bec etc...
test <- function(class = c("sf", "sp"), ...) {
  class <- match.arg(class)
  get_big_data("test", class, ...)
}

test_that("get_big_data works with specific release", {
  skip_on_cran()
  expect_equal(get_big_data("test", "sf", "0.1.1", force = TRUE, ask = FALSE), "test")
  expect_equal(test(release = "0.1.1", force = TRUE, ask = FALSE), "test")
  test_gh_assid_file <- file.path(data_dir(), "test.gh_asset_id")
  expect_true(file.exists(test_gh_assid_file))
  expect_equal(readChar(test_gh_assid_file, nchars = 10), "5416227")
})

test_that("get_big_data works with latest release", {
  skip_on_cran()
  expect_equal(get_big_data("test", "sf", "latest", force = TRUE, ask = FALSE), "test")
  expect_equal(test(force = TRUE, ask = FALSE), "test")
})

test_that("get_big_data fails when file doesn't exist", {
  skip_on_cran()
  expect_error(get_big_data("test", "sf", "0.1.0"), "No assets matching filename test.rds in 0.1.0 release")
})

test_that("check_write_to_data_dir works", {
  skip_on_cran()
  expect_message(check_write_to_data_dir(data_dir(), ask = FALSE), "Creating directory to hold bcmaps data")
  expect_true(dir.exists(rappdirs::user_data_dir("bcmaps")))
})

test_that("gh functions work with and without authentication", {
  skip_on_cran()
  gh_pat <- ""
  if (nzchar(Sys.getenv("GITHUB_PAT"))) {
    expect_is(get_gh_release("latest"), "list")
    temp <- tempfile(fileext = ".rds")
    download_release_asset("https://api.github.com/repos/bcgov/bcmaps.rdata/releases/assets/5432872", temp)
    expect_equal(readRDS(temp), "test")
    gh_pat <- Sys.getenv("GITHUB_PAT")
    Sys.unsetenv("GITHUB_PAT")
  }
  expect_is(get_gh_release("latest"), "list")
  temp <- tempfile(fileext = ".rds")
  download_release_asset("https://api.github.com/repos/bcgov/bcmaps.rdata/releases/assets/5432872", temp)
  expect_equal(readRDS(temp), "test")
  Sys.setenv("GITHUB_PAT" = gh_pat)
})
