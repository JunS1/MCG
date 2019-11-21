library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(mapproj)

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
