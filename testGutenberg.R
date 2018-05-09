library(gutenbergr)
library(dplyr)
library(stringr)

author_id <- 7

# book_ids <- gutenberg_works(str_detect(author, "Ezra"))

book_ids <- gutenberg_works(gutenberg_author_id == author_id)

# limit to 5
#book_ids <- head(book_ids, 6)

gutenberg_books <- gutenberg_download(book_ids, meta_fields = "title")

tidy_books <- gutenberg_books %>%
  group_by(title) %>%
  mutate(linenumber = row_number(), chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)

book_sentiment <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(title, index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

ggplot(book_sentiment, aes(index, sentiment, fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free_x")
