library(shiny)
library(gutenbergr)
library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(wordcloud)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  authorValues <- reactiveValues()
  bookValues <- reactiveValues()
  
  observeEvent(input$searchTerms, {
    if (input$searchTerms != '') {
      authorValues$authors <- gutenberg_authors %>%
        filter_all(any_vars(str_detect(., regex(input$searchTerms, ignore_case = T))))
    }
  })
  
  observeEvent(input$selectedAuthor, {
    if(input$selectedAuthor != '') {
      bookValues$books <- gutenberg_works(author == input$selectedAuthor)
    }
  })
  
  output$books <- renderTable({
    bookValues$books[,'title']
  })
  
  output$authorSelector <- renderUI({
    selectInput("selectedAuthor", "Choose An Author", 
                choices = authorValues$authors$author, 
                multiple = FALSE)
  })
  
  #output$distPlot <- renderPlot({
  
  # generate bins based on input$bins from ui.R
  # x    <- faithful[, 2]
  #  bins <- seq(min(x), max(x), length.out = input$bins + 1)
  
  # draw the histogram with the specified number of bins
  #  hist(x, breaks = bins, col = 'darkgray', border = 'white')
  
  #})
  
})
