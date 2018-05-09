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
        label = "Author:", 
        placeholder = "A name", 
        btnSearch = icon("search"), 
        btnReset = icon("remove"), 
        width = "100%"
      ),
      uiOutput("bookSelector")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    #   plotOutput("distPlot")
    )
  )
))
