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
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
api() |>
  api_doc_add(
    openapi(
    info = openapi_info(
      title = "Sample Pet Store App",
      description = "This is a sample server for a pet store.",
      terms_of_service = "http://example.com/terms/",
      contact = openapi_contact(name = "API Support", url = "http://www.example.com/support", email = "support@example.com"),
      license = openapi_license(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html"),
      version = "1.0.1"
    ),
    tags = list(
      openapi_tag(name = "pet", description = "Pets operations"),
      openapi_tag(name = "toy", description = "Toys operations"),
      openapi_tag(name = "toy space", description = "Toys operations")
    )
  ))


## -----------------------------------------------------------------------------
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
text_handler <- function(name, age) {
  sprintf("%s is %i years old", name, max(age))
}
qp_handler <- function(query) {
  text_handler(query$name, query$age)
}
file_handler <- function(body) {
  body$f
}
msg_handler <- function(message, client_id, server) {
  if (is.character(message)) {
    server$log("message", paste0(client_id, " says ", message))
  }
  NULL
}

api() |>
  api_get(
    path = "/query/parameters",
    handler = qp_handler,
    serializers = get_serializers("text"),
    parsers = get_parsers(),
    doc = openapi_operation(
      parameters = list(
        openapi_parameter(
          name = "name",
          location = "query",
          required = TRUE,
          schema = openapi_schema(character())
        ),
        openapi_parameter(
          name = "age",
          location = "query",
          required = TRUE,
          schema = openapi_schema(integer())
        )
      )
    )
  ) |>
  api_get(
    path = "/dyn/<name:string>/<age:integer>/route",
    handler = text_handler,
    serializers = get_serializers("text"),
    doc = openapi_operation(
      responses = list(
         "200" = openapi_response(
          description = "A sentence",
          content = openapi_content(
            "text/plain" = openapi_schema(character())
          )
        )
      )
    )
  ) |>
  api_post(
    path = "/upload_file",
    handler = file_handler,
    serializers = get_serializers("rds"),
    parsers = get_parsers("multi"),
    doc = openapi_operation(
      description = "Upload an rds file and return the object",
      request_body = openapi_request_body(
        content = openapi_content(
          "multipart/form-data" = openapi_schema(list(file = raw()))
        )
      )
    )
  ) |>
  api_message(msg_handler)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
# api() %>%
#   api_assets("/", "./assets/files")
# 
# api() %>%
#   api_assets("/assets", "./assets/files")
# 
# api() %>%
#   api_statics("/", "./assets/static_files", except = "/secret_files")


## -----------------------------------------------------------------------------
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
api() |>
  api_datastore(storr::driver_environment()) |> 
  api_auth_guard(
    fireproof::guard_key(
      key_name = "plumber2_key",
      validate = "MY_VERY_SECRET_SECRET"
    ),
    "auth1"
  )


## -----------------------------------------------------------------------------
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
api() |>
  api_datastore(
    driver = storr::driver_environment(),
    store_name = "persistent_data"
  )


## -----------------------------------------------------------------------------
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
api() |>
  api_doc_setting("swagger")


## -----------------------------------------------------------------------------
#| output: false
#| eval: !expr R.Version()$minor > package_version("4.0")
api() |>
  api_redirect("any", "old/<path>", "new/<path>", permanent = TRUE) |>
  api_redirect("get", "main/*", "temp/main/*") |>
  api_forward("proxy/server", "http://127.0.0.1:56789")


## -----------------------------------------------------------------------------
#| output: false
#| eval: false
# api() |>
#   api_shiny("app/", shinyAppDir("path/to/shiny/app"))


## -----------------------------------------------------------------------------
#| output: false
#| eval: false
# api() |>
#   api_add_route(routr::report_route("quarterly/", "my_amazing_report.qmd"))

