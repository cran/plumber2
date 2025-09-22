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
#| code: !expr readLines("files/apis/07-01-plot-unsafe.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
pa <- api(file.path(me, "files/apis/07-01-plot-unsafe.R"))

req <- fiery::fake_request("http://localhost:8080")
res <- pa$test_request(req)

cat('<img src="data:image/png;base64,', base64enc::base64encode(res$body), '">')


## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
req <- fiery::fake_request("http://localhost:8080?pts=10000")
t <- system.time(res <- pa$test_request(req))

cat('<img src="data:image/png;base64,', base64enc::base64encode(res$body), '">')


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/07-02-plot-safe.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/07-03-file-unsafe.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/07-04-file-safe.R")
# NA

