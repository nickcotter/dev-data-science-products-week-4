library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(memoise)

getTidyBooks <- memoise(function(bookIds) {
  
  incProgress(0.5, detail = "downloading")
  
  gutenberg_books <-
    gutenberg_download(bookIds, meta_fields = "title")
  
  incProgress(0.5, detail = "analysing")
  
  tidy_books <- gutenberg_books %>%
    group_by(title) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(
             text, regex("^chapter [\\divxlc]", ignore_case = TRUE)
           ))) %>%
    ungroup() %>%
    unnest_tokens(word, text) 
})