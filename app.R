library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

wood_removal_table <- read.csv("./data/wood_removal_cubic_meters.csv", stringsAsFactors = FALSE)

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
wood_removal_visualization <- tabPanel(
  "Wood Removal Visualization", # label for the tab in the navbar
  titlePanel("Wood Removal Visualization"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      tags$h4("Scatterplot Options"),
      selectInput(
        "region",
        label = "Select region",
        choices = c(as.list(wood_removal_table$country)),
        selected = "All"
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Based on the Region Selected Display a Scatter Plot",
                 fluidRow(
                   plotOutput("wood_removal")
                 ),
                 tags$p("Shows the trend of wood removal for the country that the user selects")
                 )
      ),
      tags$h2("Findings"),
      tags$p("Enter findings here")
    )
  )
)

# ui component
my_ui <- navbarPage(
  "My Application", # application title
  page_one,         # include the first page content
  page_two,          # include the second page content
  wood_removal_visualization
)

# server component
my_server <- function(input, output) {
  output$wood_removal <- renderPlot({
    filter_country <- wood_removal_table %>%
      filter(country == input$region)
    filter_country$country <- NULL
    ggplot(data = gather(filter_country, key = year, value = removal),
           mapping = aes(x = year, y = removal)) +
      geom_point()
  })
}

# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function
shinyApp(ui = my_ui, server = my_server)
