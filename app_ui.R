library(shiny)
library(plotly)

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
        selected = "World Average"
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Wood Removal from the years 1990 - 2011",
                 fluidRow(
                   div(style='height:400px;',
                    plotlyOutput("wood_removal")
                   )
                 ),
                 tags$p("Shows the trend of wood removal for the country that the user selects")
        )
      ),
      tags$h2("Findings"),
      tags$p("Looking at the world average, we generally see a decline in the amount of wood removed
             from the years 1990 - 2011. Yet, this is only the world average. If we look at individual 
             countries, we see that most third world countries have a general increase in the amount of 
             wood removed while the first world countries sees a decrease. We speculate that this is 
             the case because the first world countries mainly gets their wood from trade. The general 
             decline in the wood removal can be explained by the technological advances we have made, 
             such as better machinery, that allows us to more efficiently
             use the wood to produce the same amount of goods, if not more.")
    )
  )
)

# Page 4 - Conclusion
conclusion <- tabPanel(
  "Conclusions", # Label within the NavBar
  titlePanel("Conclusions"), # Title within the tab
  
  mainPanel(
    h2("Our Findings:"),
    h4("Wood Removal"),
    p("We found that the U.S. had the most drastic change in the amount of wood removed. 
      The amount of wood removed from the U.S. dropped from about 500 million cubic meters
      to around 300 million cubic meters. Since this difference in wood removed was so large,
      it had the greatest impact on the world average over that time interval (1990-2011). 
      This change can be explained by the U.S.'s decision to begin importing goods (such as 
      wood) from other countries; this is why we see an increase in wood removed for many
      other countries."),
    h4("Forest Coverage Area"),
    p("The U.S. experienced an increase in forest coverage area over the past 2 decades
      by about 1%. This ammounted to about 38,000 square miles of forest coverage. 
      Vietnam underwent the greatest relative increase in forest coverage area by approximately
      19%. In contrast, Honduras experienced the greatest relative decrease in forest coverage 
      area by approximately 32%.")
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