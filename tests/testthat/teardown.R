if (requireNamespace("future", quietly = TRUE)) {
  options("future.globals.maxSize" = omax_global_size)
  future::plan(oplan)
}
