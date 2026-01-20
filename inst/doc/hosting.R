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
  }
)
source(file.path(me, "_helpers.R"))
readLines <- function(x) base::readLines(file.path(me, x))


## -----------------------------------------------------------------------------
#| eval: false
# # Create _server.yml in the working directory
# create_server_yml(
#   "api.R",
#   "routes/users.R",
#   "routes/data.R",
#   options = list(docs = TRUE, port = 8000, host = "0.0.0.0")
# )


## -----------------------------------------------------------------------------
#| eval: false
# # Test that it works
# api("_server.yml") |>
#   api_run()


## -----------------------------------------------------------------------------
#| eval: false
# install.packages("pak")
# pak::pak(c("buoyant", "analogsea"))


## -----------------------------------------------------------------------------
#| eval: false
# library(buoyant)
# library(analogsea)
# 
# # Authenticate with DigitalOcean (opens browser for OAuth)
# do_oauth()
# 
# # Provision a new droplet (virtual server)
# droplet <- do_provision(region = "sfo3")
# 
# # Deploy your application
# do_deploy_server(
#   droplet = droplet,
#   path = "myapi",
#   local_path = "path/to/my-api",
#   port = 8000
# )
# 
# # Get the URL to access your API
# do_ip(droplet, "/myapi")
# #> [1] "http://165.232.143.22/myapi"

