library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
  
  titlePanel("Gutenberg Sentiment Analyser"),
  
  sidebarLayout(
    sidebarPanel(
      searchInput(
        inputId = "searchTerms", 
        label = "Search:", 
        placeholder = "An author name", 
        btnSearch = icon("search"), 
        btnReset = icon("remove"), 
        width = "100%"
      ),
      uiOutput("authorSelector")
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", tabPanel("Books", tableOutput("books")),
                  tabPanel("Word Cloud", plotOutput("wordcloud")),
                  tabPanel("Sentiment", plotlyOutput("sentiment")))
    )
)))
