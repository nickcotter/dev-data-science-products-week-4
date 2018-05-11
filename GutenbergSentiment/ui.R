shinyUI(fluidPage(
  
  titlePanel("Gutenberg Sentiment Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      searchInput(
        inputId = "searchTerms", 
        placeholder = "An author name", 
        btnSearch = icon("search"), 
        btnReset = icon("remove"), 
        width = "100%"
      ),
      uiOutput("authorSelector"),
      helpText("Enter a search term to find authors and select one to display their books, generate the word cloud and sentiment graph."),
      helpText("Note: analysis may take some time to load if the author has written many books!")
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", tabPanel("Books", tableOutput("books")),
                  tabPanel("Word Cloud", plotOutput("wordcloud")),
                  tabPanel("Sentiment", plotlyOutput("sentiment")))
    )
)))
