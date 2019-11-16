library(shiny)

# ui component
my_ui <- navbarPage(
  "My Application", # application title
  page_one,         # include the first page content
  page_two,         # include the second page content
  page_three        # include the third page content
)

# page 1
page_one <- tabPanel(
  "First Page", # label for the tab in the navbar
  titlePanel("Page 1"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "username", label = "What is your name?")
    ),
    mainPanel(
      h3("Primary Content"),
      p("Plots, data tables, etc. would go here")
    )
  )
)

# page 2
page_two <- tabPanel(
  "Second Page", # label for the tab in the navbar
  titlePanel("Page 2"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "username", label = "What is your name?")
    ),
    mainPanel(
      h3("Primary Content"),
      p("Plots, data tables, etc. would go here")
    )
  )
)

# page 3
page_three <- tabPanel(
  "Third Page", # label for the tab in the navbar
  titlePanel("Page 3"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "username", label = "What is your name?")
    ),
    mainPanel(
      h3("Primary Content"),
      p("Plots, data tables, etc. would go here")
    )
  )
)

# server component
my_server <- function(input, output) {
  
}

# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function
shinyApp(ui = my_ui, server = my_server)