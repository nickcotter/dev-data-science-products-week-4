library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gutenberg Sentiment Analyser"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("searchTerms", "Author", placeholder = "author's name"),
      uiOutput("bookSelector")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    #   plotOutput("distPlot")
    )
  )
))
