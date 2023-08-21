#' Add the boilerplate Apache header to the top of a source code file
#'
#' @param file Path to the file
#' @param year The year the license should apply (Default current year)
#' @param copyright_holder Copyright holder (Default "Province of British Columbia")
#'
#' @return NULL
#' @noRd
add_license_header <- function(file, year = format(Sys.Date(), "%Y"), copyright_holder = "Province of British Columbia") {

  file_text <- readLines(file)

  license_text <- make_license_header_text(year, copyright_holder)

  writeLines(c(license_text, file_text), file)
  message("Adding Apache boilerplate header to the top of ", file)

  invisible(TRUE)
}

make_license_header_text <- function(year = NULL, copyright_holder = NULL) {
  license_txt <- '# Copyright {YYYY} {COPYRIGHT_HOLDER}
  #
  # Licensed under the Apache License, Version 2.0 (the "License");
  # you may not use this file except in compliance with the License.
  # You may obtain a copy of the License at
  #
  # http://www.apache.org/licenses/LICENSE-2.0
  #
  # Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
  # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  # See the License for the specific language governing permissions and limitations under the License.
  '

  if (!is.null(year)) {
    license_txt <- gsub("{YYYY}", year, license_txt, fixed = TRUE)
  }

  if (!is.null(copyright_holder)) {
    license_txt <- gsub("{COPYRIGHT_HOLDER}", copyright_holder, license_txt, fixed = TRUE)
  }

  license_txt
}
