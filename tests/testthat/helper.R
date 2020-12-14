skip_on_actions <- function() {
  if (!identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {
    return(invisible(TRUE))
  }
  skip("On GitHub Actions")
}

make_local_cded_cache <- function(dir = tempdir(), env = parent.frame()) {
  cache_dir <- file.path(dir, "cded")
  make_mapsheet_dirs(cache_dir)

  # Use withr::defer to cleanup tempdir after exiting tests
  # https://www.tidyverse.org/blog/2020/04/self-cleaning-test-fixtures/
  withr::defer({
    unlink(cache_dir, recursive = TRUE, force = TRUE)
  }, envir = env)

  cache_dir
}
