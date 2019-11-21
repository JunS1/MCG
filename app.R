library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(mapproj)

wood_removal_table <- read.csv("./data/wood_removal_cubic_meters.csv", stringsAsFactors = FALSE)
forest_coverage_table <- read.csv("./data/forest_coverage_percent.csv", stringsAsFactors = FALSE)

# page 1 -- Problem Background
background <- tabPanel(
  "Background", # label for the tab in the navbar
  titlePanel("Background"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      h3("Define Deforestation"),
      p("insert definition")
      
    ),
    mainPanel(
      h3("Problem Situation"),
      p("Explanation of problem situation (stakeholders, setting, policy)"),
      p("insert picture here"),
      h3("Why Does it Matter"),
      p("Explanation"),
      tags$a(href="https://github.com/JunS1/MCG/wiki/Technical-Report", "Here is our technical report")
    )
  )
)

# page 2 -- forest coverage visualization
forest_coverage_visualization <- tabPanel(
  "Forest Coverage Visualization", # label for the tab in the navbar
  titlePanel("Forest Coverage Visualization"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      tags$h4("Map Options"),
      sliderInput(
        inputId = "year",
        label = "Select year",
        min = 1990,
        max = 2015,
        value = 1990
      ),
      tags$h4("Trends"),
      tags$p("Discussion of trends in forest coverage over time and possible
             causes of these trends."),
      tags$h4("Current Measures"),
      tags$p("Discussion of the effectiveness of current measures to decrease
             rates of deforestation.")
    ),
    mainPanel(
      h3("World Map of Forest Coverage"),
      p("Based on the year selected, display a choropleth map."),
      plotOutput("forest_coverage"),
      tabsetPanel (
            tags$p("Percentage of forest coverage depending on the selected year.")
      ),
      tags$h2("Findings"),
      tags$p("Enter findings here, possibly points out trends to look for/pay special
             attention to")
    )
  )
)

# page 3 -- wood removal visualization
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

# Page 4 - Conclusion
conclusion <- tabPanel(
  "Conclusions", # Label within the NavBar
  titlePanel("Conclusions"), # Title within the tab
  
  mainPanel(
    h3("Our Findings:"),
    # p("This is where our findings for the conclusions will go")
  )
)

# page 5 -- How to Help
how_to_help <- tabPanel(
  "How to Help", # label for the tab in the navbar
  titlePanel("How to Help"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      h3("Why Should You Help?"),
      p("Reducing it is cost effective, it is inexpensive, 
        prepare for future, addresses other problems")
    ),
    mainPanel(
      h3("Make an Impact"),
      p("1. Plant a Tree where you can."),
      p("2. Go paperless at home and in the office."),
      p("3. Buy recycled products and then recycle them again."),
      p("4. Buy certified wood products."), 
      p("5. Read the labels and look for the FSC (Forest Stewardship Council) mark."),
      p("6. Support the products of companies that are committed to reducing deforestation. It's all about business. If you don't buy, they will be encouraged to improve their practices."),
      p("7. Raise awareness in your circle and in your community."),
      p("8. Buy only what you will use."), 
      p("9.Don't use Palm Oil or products with Palm Oil.")
    )
  )
)

# Page 6 - About the Project/About Us
about_page <- tabPanel(
  "About", # Label within the NavBar
  titlePanel("About the Project/About Us"), # Title with the tab
  # 'About Us' Sidebar for teammates
  sidebarLayout(
    sidebarPanel(
      h3("About the Team:"),
      p("Post pictures and brief description of each team member")
    ),
    # About the Project 
    mainPanel(
      h3("About the Project"),
      p("Information about the project goes here.")
    )
  )
)
  
# ui component
my_ui <- navbarPage(
  "Deforestation", # application title
  background,         # include the first page content
  forest_coverage_visualization,          # include the second page content
  wood_removal_visualization,
  conclusion,
  how_to_help,
  about_page
)

# server component
my_server <- function(input, output) {
  # scatter plot of wood removal data
  output$wood_removal <- renderPlot({
    filter_country <- wood_removal_table %>%
      filter(country == input$region)
    filter_country$country <- NULL # get rid of the country value
    ggplot(data = gather(filter_country, key = year, value = removal),
           mapping = aes(x = year, y = removal)) +
      geom_point()
  })
  # choropleth map of forest coverage data
  output$forest_coverage <- renderPlot({
    forest_coverage <- forest_coverage_table %>%
      select(country, paste("X", input$year, sep = "")) %>%
      rename(region = country)
    
    world_shape <- map_data("world") %>%
      left_join(forest_coverage, by = "region") %>%
      rename(year = paste("X", input$year, sep = ""))

    ggplot(world_shape) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = world_shape$year),
        color = "white",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(low = "#E8E341", high = "#034511") +
      labs(fill = "Forest Coverage Percent") +
      theme_bw() +
        theme(
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          plot.background = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()
        )
  })
}

# To run app
shinyApp(ui = my_ui, server = my_server)
