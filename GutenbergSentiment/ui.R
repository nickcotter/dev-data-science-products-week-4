library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gutenberg Sentiment Analyser"),
  
  # Sidebar with a slider input for number of bins 
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
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", tabPanel("Books", tableOutput("books")),
                  tabPanel("Word Cloud", plotOutput("wordcloud")),
                  tabPanel("Sentiment", plotlyOutput("sentiment")))
    )
)))
