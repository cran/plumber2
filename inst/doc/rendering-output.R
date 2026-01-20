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
jsonlite::toJSON(list(a=5))


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/04-03-letters.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/04-03-letters.R"))

req <- fiery::fake_request("http://localhost:8080/boxed?letter=U")
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
req <- fiery::fake_request("http://localhost:8080/boxed?letter=Y")
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
req <- fiery::fake_request("http://localhost:8080/unboxed?letter=Y")
res <- pa$test_request(req)

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/04-04-image.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/04-01-response.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/04-02-contenttype.R")
# NA


## -----------------------------------------------------------------------------
#| eval: false
# format_toml <- function(...) {
#   function(x) {
#     blogdown::write_toml(x)
#   }
# }


## -----------------------------------------------------------------------------
#| eval: false
# register_serializer("toml", format_toml, "application/toml")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/04-05-error.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/04-05-error.R"))

req <- fiery::fake_request("http://localhost:8080/friendly")
muffle <- capture.output(res <- pa$test_request(req))

code_chunk(res$body, "json")


## -----------------------------------------------------------------------------
#| eval: false
#| code: !expr readLines("files/apis/06-01-capitalize.R")
# NA


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| results: asis
pa <- api(file.path(me, "files/apis/06-01-capitalize.R"))

req <- fiery::fake_request("http://localhost:8080/letter")
res <- pa$test_request(req)

code_chunk(res$body, "json")

