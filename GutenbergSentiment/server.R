library(shiny)
library(gutenbergr)
library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(wordcloud)
library(shinyWidgets)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  books <- reactive({
    gutenberg_works(str_detect(author, input$searchTerms)) 
  })
  
#  observeEvent(input$searchButton, {
#    books <- gutenberg_works(str_detect(author, input$searchTerms))   
#  })
  
  output$bookSelector <- renderUI({
    selectInput("bookIds", "Books", books()$title, multiple=TRUE)
  })
    
  #output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
   # x    <- faithful[, 2] 
  #  bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
  #  hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  #})
  
})

