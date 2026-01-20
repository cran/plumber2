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

library(plumber2)


## -----------------------------------------------------------------------------
say_hi <- function(language, api) {
  hi <- c(
    "english" = "hi",
    "danish" = "hej",
    "french" = "salut",
    "spanish" = "hola",
    "japanese" = "konnichiwa"
  )[tolower(language)]
  api$on("start", function(...) cat(hi, "\n"))
} 


## -----------------------------------------------------------------------------
add_plumber2_tag("tictoc", function(block, call, tags, values, env) {
  if (!inherits(block, "plumber2_empty_block")) {
    cli::cli_abort(
      "{.field @tictoc} cannot be used with other types of annotation blocks"
    )
  }
  if (!rlang::is_string(call)) {
    cli::cli_abort(
      "The expression following a {.field tictoc} block must be a string"
    )
  }

  interval <- as.integer(values[[which(tags == "tictoc")[1]]])
  if (is.na(interval)) interval <- 5
  message <- call

  type <- "message"
  if (any(tags == "logType") && values[[which(tags == "logType")[1]]] != "") {
    type <- values[[which(tags == "logType")[1]]]
  }

  structure(
    list(
      interval = interval,
      message = message,
      type = type
    ),
    class = "plumber2_tictoc_block"
  )
})
add_plumber2_tag("logType")


## -----------------------------------------------------------------------------
#| eval: false
# add_plumber2_tag("cors", function(block, call, tags, values, env) {
#   class(block) <- c("plumber2_cors_block", class(block))
#   block$cors <- trimws(strsplit(values[[which(tags == "cors")[1]]], ",")[[1]])
#   if (block$cors == "") {
#     block$cors <- "*"
#   }
#   block
# })


## -----------------------------------------------------------------------------
apply_plumber2_block.plumber2_tictoc_block <- function(
  block, 
  api, 
  route_name, 
  root, 
  ...
) {
  api$time(
    api$log(event = block$type, message = block$message),
    after = block$interval,
    loop = TRUE
  )
  api
}


## -----------------------------------------------------------------------------
#| eval: false
# apply_plumber2_block.plumber2_cors_block <- function(
#   block,
#   api,
#   route_name,
#   root,
#   ...
# ) {
#   NextMethod()
#   for (i in seq_along(block$endpoints)) {
#     for (path in block$endpoints[[i]]$path) {
#       api <- api_security_cors(
#         api,
#         paste0(root, path),
#         block$cors,
#         methods = block$endpoints[[i]]$method
#       )
#     }
#   }
#   api
# }


## -----------------------------------------------------------------------------
api_tictoc <- function(api, interval, message, type = "message") {
  api$time(
    api$log(event = type, message = message),
    after = interval,
    loop = TRUE
  )
  api
}


## -----------------------------------------------------------------------------
names(get_serializers())


## -----------------------------------------------------------------------------
get_serializers("geojson")


## -----------------------------------------------------------------------------
format_toml <- function() {
  rlang::check_installed("tomledit")
  function(x) {
    tomledit::to_toml(x)
  }
}


## -----------------------------------------------------------------------------
print(format_rds)


## -----------------------------------------------------------------------------
register_serializer("toml", format_toml, "application/toml")


## -----------------------------------------------------------------------------
get_serializers("toml")


## -----------------------------------------------------------------------------
names(get_serializers())


## -----------------------------------------------------------------------------
names(get_serializers(c("png", "...")))


## -----------------------------------------------------------------------------
format_postscript <- device_formatter(postscript)


## -----------------------------------------------------------------------------
register_serializer(
  "postscript", 
  format_postscript, 
  "application/postscript",
  default = FALSE
)


## -----------------------------------------------------------------------------
parse_toml <- function() {
  rlang::check_installed("tomledit")
  function(x, directives) {
    tomledit::read_toml(rawToChar(x))
  }
}


## -----------------------------------------------------------------------------
register_parser(
  "toml", 
  parse_toml, 
  c("application/toml", "text/x-toml", "text/toml")
)


## -----------------------------------------------------------------------------
future_async <- function(...) {
  rlang::check_installed("promises")
  function(expr, envir) {
    promises::future_promise(
      expr = expr,
      envir = envir,
      substitute = FALSE,
      ...
    )
  }
}


## -----------------------------------------------------------------------------
register_async("future", future_async, c("promises", "future"))

