set_utf8 <- function(sp_obj) {
  char_cols <- names(sp_obj@data)[vapply(sp_obj@data, is.character, FUN.VALUE = logical(1))]

  for (col in char_cols) {
    Encoding(sp_obj@data[[col]]) <- "UTF-8"
  }

  sp_obj
}
