
library(shiny)
library(tidyverse)
library(ggplot2)
library(ggthemes)

adult <- read_csv("adult.csv")

names(adult) <- tolower(names(adult))


shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  
  output$p1 <- renderPlot({
    if (input$graph_type == "Histogram") {
      # Histogram
      ggplot(df_country(), aes_string(x =input$continuous_variable)) +
        geom_histogram() +  # histogram geom
        title(ylab = "people",main="Histogram")+  
        facet_wrap(~prediction)
    }
    else {
      # Boxplot
      ggplot(df_country(), aes_string(y = input$continuous_variable )) +
        geom_boxplot() +  
        coord_flip() + 
        title(ylab = "people",main = "Boxplot")+ theme(
          panel.background = element_rect(fill = "lightblue",
                                          colour = "lightblue",
                                          size = 0.5, linetype = "solid"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                          colour = "white"), 
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                          colour = "white")
        )+ 
        facet_wrap(~prediction) 
    }
    
  })
  
  output$p2 <- renderPlot({
    # Bar chart
    p <- ggplot(df_country(), aes_string(x = input$categorical_variable )) +
      title(ylab = "people",main="Barchart") + 
      theme(axis.text.x =element_text(angle = 45))+theme(legend.position="bottom")    
    
    if (input$is_stacked) {
      p +geom_bar(aes_string(fill= "prediction")) 
    }
    else{
      p + 
        geom_bar(aes_string(fill=input$categorical_variable)) +  
        facet_wrap(~prediction)  
    }
  })
  
})
