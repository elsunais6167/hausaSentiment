library(tidyverse)
library(tibble)
library(dplyr, warn.conflicts = FALSE)
library(tidytext)

tweet <- read.csv(
  'tweet_data.csv',
  stringsAsFactors = FALSE)

lexicon <- read.table(
  "phrase_dic.csv",
  header = TRUE,
  sep = ',',
  stringsAsFactors = FALSE
)


tweet %>%
  mutate(linenumber = row_number()) %>%
  unnest_tokens(word, tweet_text) %>%
  inner_join(lexicon) %>%
  group_by(linenumber) %>%
  summarise(sentiment = sum(polarity)) %>%
  left_join(tweet %>%
              mutate(linenumber = row_number())) %>% write.csv("sentiment_analysis_ouptut.csv", row.names = FALSE)
