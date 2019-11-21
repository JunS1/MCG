library(shiny)
source("app_ui.R")
source("app_server.R")

# To run app
shinyApp(ui = my_ui, server = my_server)
