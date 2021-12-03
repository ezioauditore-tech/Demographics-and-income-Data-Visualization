
library(shiny)
library(tidyverse)

# Application Layout
shinyUI(
  fluidPage(
    br(),
    titlePanel("Task1"),
    p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demogrphic information."),
    
    fluidRow(
      column(12, 
             wellPanel(
               
             selectInput(inputId = "country",label ="country",choices = list("United-States", "Canada", "Mexico", "Germany", "Philippines")))  
      )
    ),
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
               radioButtons(
                 label="age,hoursperweek", inputId = "continuous_variable",choices = list("age","hours_per_week")),   
               radioButtons(inputId = "graph_type",label ="graph type",choices = list("Histogram","Boxplot"))  
             )
      ),
      column(9,
             plotOutput(outputId = "p1",width ="100%",height="400px"))  
    ),
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart to combine the income levels into one graph. "),
               radioButtons(inputId ="categorical_variable",label ="Info",choices = list("education","workclass","sex")),    
               checkboxInput(inputId ="is_stacked",label ="StackBar",value=FALSE)     
             )
      ),
      column(9,
             plotOutput(outputId ="p2",width="100%",height = "400px"))  
    )
  
    
    )
)
