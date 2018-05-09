library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(memoise)

getTidyBooks <- function(bookIds) {
  
  message(paste('downloading book ids', bookIds))
  
  gutenberg_books <-
    gutenberg_download(bookIds, meta_fields = "title")
  
  tidy_books <- gutenberg_books %>%
    group_by(title) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(
             text, regex("^chapter [\\divxlc]", ignore_case = TRUE)
           ))) %>%
    ungroup() %>%
    unnest_tokens(word, text) 
}