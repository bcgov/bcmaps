
api_limited <- function() {
  httr::GET("https://api.github.com/repos/bcgov/bcmaps.rdata/releases")
  rel <- httr::GET("https://api.github.com/repos/bcgov/bcmaps.rdata/releases")
  as.numeric(rel$headers$`x-ratelimit-remaining`) == 0
}
