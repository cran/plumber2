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
#| code: !expr readLines("files/apis/03-01-endpoint.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/03-01-dynamic.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/03-03-search.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/03-03-search.R"))

req <- fiery::fake_request("http://localhost:8080/?q=bread&pretty=1")
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/03-04-body.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/03-04-body.R"))

req <- fiery::fake_request(
  "http://localhost:8080/user",
  method = "post",
  content = "id=123&name=Jennifer",
  headers = list(Content_Type = "application/x-www-form-urlencoded")
)
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/03-05-headers.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/03-05-headers.R"))

req <- fiery::fake_request(
  "http://localhost:8080",
  headers = list(Custom_Header = "abc123")
)
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/03-02-types.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/03-02-types.R"))

req <- fiery::fake_request("http://localhost:8080/type/14")
res <- pa$test_request(req)

code_chunk(res$body, "json")

