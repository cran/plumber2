## -----------------------------------------------------------------------------
#| eval: false

# if (file.exist("_server.yml")) {
#   # Figure out the engine for the server
#   # You could probably easily do this without the yaml package
#   engine <- yaml::read_yaml("_server.yml")$engine
# 
#   # Install the engine if not already available
#   if (!requireNamespace(engine, quietly = TRUE)) {
#     install.packages(engine)
#   }
# 
#   # Find the launch_server() function in the engine
#   launch_server <- get(
#     "launch_server",
#     envir = asNamespace(engine),
#     mode = "function"
#   )
# 
#   # Use the function to launch the server
#   launch_server(
#     settings = "_server.yml",
#     host = HOST_ADDR, # Variable holding the ip address
#     port = PORT_NO    # Variable holding the port number
#   )
# } else {
#   # Logic for other types of server specifications
# }


## -----------------------------------------------------------------------------
plumber2:::launch_server

