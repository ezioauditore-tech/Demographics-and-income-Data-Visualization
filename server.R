# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(ggthemes)
# Read in data
adult <- read_csv("adult.csv")
# Convert column names to lowercase for convenience 
names(adult) <- tolower(names(adult))

# Define server logic
shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  # TASK 5: Create logic to plot histogram or boxplot
  output$p1 <- renderPlot({
    if (input$graph_type == "Histogram") {
      # Histogram
      ggplot(df_country(), aes_string(x =input$continuous_variable)) +
        geom_histogram() +  # histogram geom
        title(ylab = "people",main="Histogram")+  # labels
        facet_wrap(~prediction)# facet by prediction
    }
    else {
      # Boxplot
      ggplot(df_country(), aes_string(y = input$continuous_variable )) +
        geom_boxplot() +  # boxplot geom
        coord_flip() +  # flip coordinates
        title(ylab = "people",main = "Boxplot")+ theme(
          panel.background = element_rect(fill = "lightblue",
                                          colour = "lightblue",
                                          size = 0.5, linetype = "solid"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                          colour = "white"), 
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                          colour = "white")
        )+ # labels
        facet_wrap(~prediction) # facet by prediction
    }
    
  })
  
  # TASK 6: Create logic to plot faceted bar chart or stacked bar chart
  output$p2 <- renderPlot({
    # Bar chart
    p <- ggplot(df_country(), aes_string(x = input$categorical_variable )) +
      title(ylab = "people",main="Barchart") +  # labels
      theme(axis.text.x =element_text(angle = 45))+theme(legend.position="bottom")    # modify theme to change text angle and legend position
    
    if (input$is_stacked) {
      p +geom_bar(aes_string(fill= "prediction"))  # add bar geom and use prediction as fill
    }
    else{
      p + 
        geom_bar(aes_string(fill=input$categorical_variable)) + # add bar geom and use input$categorical_variables as fill 
        facet_wrap(~prediction)   # facet by prediction
    }
  })
  
})
