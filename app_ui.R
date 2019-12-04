library(shiny)
library(plotly)
library(shinythemes)

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
      p("The National Geographic defines deforestation as the “human-driven and natural loss of trees"),
      p("This act ends up affect many other aspects of life from organisms to ecosystems to weather patterns. 
        Data shows that forest areas make up around thirty percent of Earth’s land mass  but are disappearing 
        at an exponential rate."),
      img(src = "define.jpg", height = "100%", width = "100%", align = "center"),
      p("")
    ),
    mainPanel(
      img(src = "forest.jpeg", height = "100%", width = "100%", align = "center"),
      h3("Problem Situation"),
      p(" "),
      p("The problem our group is focusing on concerns deforestation throughout the world 
      and the rate at which it has occurred over the past several decades. As deforestation destroys the 
      lives of organisms and their surrounding ecosystems, it also makes the world more dangerous for humans. 
      With forests and rainforests being logged/removed at alarming rates, it’s important for humans to 
      understand the ecological and societal repercussions of their actions."),
      tags$b("Stakeholders"),
      p("Organisms that are native to the forests (plants and animals), indigenous people that live nearby, 
        loggers, miners, farmers/cattle ranchers, and the government"),
      tags$b("Setting"),
      p("Forests across 189 different countries."),
      tags$b("Policy and Ethics"),
      p("Deforestation is leading to other environmental issues such as climate change by increasing the amount of
        carbon dioxide in the atmosphere. Also, as more animals are forced out of their habitats, it is creating a 
        larger risk for species extinction. There have been policies issued by the UN to address this issue, 
        such as the Paris Agreement created to address climate change by focusing on greenhouse gas emissions."),
      h3("Why Does it Matter"),
      p("There are millions of people and organisms that are significantly impacted by these large rates of 
        deforestation. National Geographic says around eighty percent of Earth’s land animals and plants live 
        in forests and around 250 million people living in the area depend on the forest resources for survival. 
        Deforestation not only affects millions of organisms and people, but it also directly correlates to many other 
        issues in the world such as climate change.  Removing trees adds excess carbon dioxide to the environment and 
        inhibits the ability for ecosystems to absorb existing carbon dioxide. Our planet thrives because of ecological 
        factors such as biodiversity, and since such a large scale of wildlife lives within forest biomes, we need to make 
        sure that their lives are being considered. We cannot continue to allow money and other economic factors cloud the fact 
        that the world’s forests are a necessary part of our planet’s wellbeing, and they need protection"),
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
      selectInput(
        inputId = "year",
        label = "Select year",
        choices = seq(from = 1990, to = 2015, by = 1),
        selected = 1990
      )
    ),
    mainPanel(
      h3("World Map of Forest Coverage"),
      p("Based on the year selected, display a choropleth map."),
      plotOutput("forest_coverage"),
      tabsetPanel (
        tags$p("Percentage of forest coverage depending on the selected year.")
      ),
      tags$h2("Trends and Analysis"),
      tags$p("From this map, the general decrease in forest coverage percentage
             in the majority of countries is made clear. However, while most
             countries have decreasing percentages, a few appear to be making
             marginal progress in decreasing their rates of deforestation.
             Another interesting thing to examine from this map are the trends in
             developed vs less developed countries. For example, forest coverage in
             Cambodia makes a marked decrease between 1990 and 2015, while coverage
             in the USA increases. This could be due to implemented programs and
             efforts to increase awareness and solve this issue.")
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
      h3("Make an Impact"),
      img(src = "stop-deforestation.jpg", width = "90%", height = "90%", align = "center"),
      p(""),
      p("1. Plant a Tree where you can."),
      p("2. Go paperless at home and in the office."),
      p("3. Buy recycled products and then recycle them again."),
      p("4. Buy certified wood products."), 
      p("5. Read the labels and look for the FSC (Forest Stewardship Council) mark."),
      p("6. Support the products of companies that are committed to reducing deforestation. It's all about business. If you don't buy, they will be encouraged to improve their practices."),
      p("7. Raise awareness in your circle and in your community."),
      p("8. Buy only what you will use."), 
      p("9.Don't use Palm Oil or products with Palm Oil.")
    ),
    mainPanel(
      img(src = "help.jpg", width = "90%", height = "90%", align = "center"),
      h3("Why Should You Help?"),
      p("Forest protection initiatives are crucial for everyone on the planet. 
      Global warming is a global issue and deforestation directly correlates with 
      changes in global warming as deforestation affects the absorption of carbon dioxide. 
      Tropical forest are necessary for stabilizing our climate as the forests provide oxygen for us to 
      breathe but also maintain healthy levels of carbon dioxide to keep the planet a comfortable temperature. 
      Economic analyses also shows that deforestation is cost effective compared to reducing emissions from other 
      industrial sources."),
      p("Consumers play a very crucial role in reducing deforestation. By taking active steps to use 
        more recycled material and reduce waste we can encourage the demand of these goods that will protect 
        the forests and together create a larger impact. Many solutions to deforestation exist today worldwide, 
        we simply have to spread more awareness and increase the use of these products. For example, Brazil has 
        reduced its deforestation-related emissions by sixty percent, and Indonesia has promised to reduce emissions 
        contributing to deforestation by around 25 percent in the upcoming years. Research has also shown that preventing 
        deforestation is actually inexpensive for the United States. Analysis shows that deforestation rates can be 
        reduced by around 50 percent with $20 billion per year. The U.S. only needs to contribute donate $5 billion 
        of this amount, a minor percent of its annual budget. "),
      p("Preserving tropical forests helps protect the millions of plant and animal species—many of which have 
        been invaluable to human medicine—that are indigenous to tropical forests and in danger of extinction. 
        Keeping forests intact also helps prevent floods and drought by regulating regional rainfall. And because 
        many indigenous and forest peoples rely on tropical forests for their livelihoods, investments in reducing 
        deforestation provide them with the resources they need for sustainable development without deforestation.")
    )
  )
)

# Page 6 - About the Project/About Us
about_page <- tabPanel(
  "About", # Label within the NavBar
  titlePanel("About the Project/About Us"), # Title with the tab
  # 'About Us' Sidebar for teammates
    # About the Project 
    mainPanel(
      h3("About the Team:"),
      img(src = "jun_song.JPG", height = "300px", width = "350px"),
      h4("Jun Song:"),
      p("Class: Sophomore"),
      p("Major: Computer Science"),
      p("Hobbies: Guitar, tennis, soccer"),
      img(src = "zack_photo.JPG", height = "300px", width = "350px"),
      h4("Zack Shanshory:"),
      p("Class: Junior"),
      p("Major: ESRM"),
      p("Hobbies: Basketball, videogames, camping"),
      img(src = "molly.JPG", height = "300px", width = "350px"),
      h4("Molly Kappes"),
      p("Class: Sophomore"),
      p("Major: Informatics"),
      p("Hobbies: Dancing, cooking, hiking"),
      img(src = "drishti.JPG", height = "300", width = "350"),
      h4("Drishti Vidyarthi"),
      p("Class: Sophomore"),
      p("Major: Informatics"),
      p("Hobbies: photography, design, yoga")
    )
)

# ui component
my_ui <- navbarPage(
  theme = shinytheme("flatly"),
  "Deforestation", # application title
  background,         # include the first page content
  forest_coverage_visualization,          # include the second page content
  wood_removal_visualization,
  conclusion,
  how_to_help,
  about_page
)
