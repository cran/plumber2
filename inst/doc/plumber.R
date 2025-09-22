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


## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
pa <- api(file.path(me, "files/apis/01-01-quickstart.R"))

req <- fiery::fake_request("http://localhost:8080/echo/test")
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
if (packageVersion("base") < "4.5.0") {
  cat("| The `plot/` endpoint requires the penguins dataset first introduced in R 4.5.0")
} else {
  req <- fiery::fake_request("http://localhost:8080/plot")
  res <- pa$test_request(req)

  cat('<img src="data:image/png;base64,', base64enc::base64encode(res$body), '">')
}



## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
if (packageVersion("base") < "4.5.0") {
  cat("| The `plot/` endpoint requires the penguins dataset first introduced in R 4.5.0")
} else {
  req <- fiery::fake_request("http://localhost:8080/plot?spec=Adelie")
  res <- pa$test_request(req)

  cat('<img src="data:image/png;base64,', base64enc::base64encode(res$body), '">')
}


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/01-02-html.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| results: asis
pa <- api(file.path(me, "files/apis/01-02-html.R"))

req <- fiery::fake_request("http://localhost:8080/hello")
res <- pa$test_request(req)

code_chunk(res$body, "html")

