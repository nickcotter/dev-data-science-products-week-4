library(shiny)
library(gutenbergr)
library(dplyr)
library(stringr)
#library(tidytext)
library(tidyr)
library(wordcloud)
library(plotly)

shinyServer(function(input, output) {
  authorValues <- reactiveValues()
  bookValues <- reactiveValues()
  
  observeEvent(input$searchTerms, {
    if (input$searchTerms != '') {
      authorValues$authors <- gutenberg_authors %>%
        filter_all(any_vars(str_detect(
          ., regex(input$searchTerms, ignore_case = T)
        )))
    }
  })
  
  observeEvent(input$selectedAuthor, {
    if (input$selectedAuthor != '') {
      bookValues$books <- gutenberg_works(author == input$selectedAuthor)
    }
  })
  
  output$books <- renderTable({
    bookValues$books[, 'title']
  })
  
  output$authorSelector <- renderUI({
    selectInput(
      "selectedAuthor",
      "Analyse this author:",
      choices = authorValues$authors$author,
      multiple = FALSE
    )
  })
  
  wordcloudPlot <- eventReactive(input$selectedAuthor, {
    withProgress(message = 'Loading Text', {
      getTidyBooks(bookValues$books$gutenberg_id) %>%
        anti_join(stop_words) %>%
        count(word) %>%
        with(wordcloud(word, n, max.words = 100))
    })
  })
  
  sentimentPlot <- eventReactive(input$selectedAuthor, {
    withProgress(message = 'Loading Text', {
      getTidyBooks(bookValues$books$gutenberg_id) %>%
        inner_join(get_sentiments("bing")) %>%
        count(title, index = linenumber %/% 80, sentiment) %>%
        spread(sentiment, n, fill = 0) %>%
        mutate(sentiment = positive - negative) %>%
        plot_ly(x = ~ index,
                y = ~ sentiment,
                color = ~ title) %>%
        add_bars() %>%
        layout(barmode = "stack")
    })
  })
  
  output$wordcloud <- renderPlot({
    wordcloudPlot()
  })
  
  output$sentiment <- renderPlotly({
    sentimentPlot()
  })
})
