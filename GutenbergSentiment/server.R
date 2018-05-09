library(shiny)
library(gutenbergr)
library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(wordcloud)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  bookValues <- reactiveValues()
  
  observeEvent(input$searchTerms, {
          message(paste('search for',input$searchTerms))
          if(input$searchTerms != '') {
                  bookValues$books <- gutenberg_works(str_detect(author, input$searchTerms))
          }
    message(paste('found', nrow(bookValues$books), 'books'))
  })
  
  output$bookSelector <- renderUI({
    
    message('rendering ui')
    
  #  selectInput("bookIds", "Books", c("flaps"), multiple=TRUE)
    
    selectInput("bookIds", "Books", paste(bookValues$books$title, 'by ', bookValues$books$author), multiple=TRUE)
  })
    
  #output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
   # x    <- faithful[, 2] 
  #  bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
  #  hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  #})
  
})

