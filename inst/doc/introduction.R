## -----------------------------------------------------------------------------
#| include: false
me <- normalizePath(
  if (Sys.getenv("QUARTO_DOCUMENT_PATH") != "") {
    Sys.getenv("QUARTO_DOCUMENT_PATH")
  } else if (file.exists("_helpers.R")) {
    getwd()
  } else if (file.exists("vignettes/_helpers.R")) {
    "vignettes"
  } else if (file.exists("articles/_helpers.R")) {
    "articles"
  } else {
    "vignettes/articles"
  })
source(file.path(me, "_helpers.R"))
readLines <- function(x) base::readLines(file.path(me, x))


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/01-01-quickstart.R")
# NA

