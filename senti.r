#import libraries for text/sentiment analysis 
library(tidyverse)
library(tibble)
library(dplyr, warn.conflicts = FALSE)
library(tidytext)

#importing hausa_tweeter_data
tweet <- read.csv(
  'tweet_data.csv',
  stringsAsFactors = FALSE)

#importing lexicon_hausa_corpus
lexicon <- read.table(
  "phrase_dic.csv",
  header = TRUE,
  sep = ',',
  stringsAsFactors = FALSE
)

#sentimental Analysis using
tweet %>%
  mutate(linenumber = row_number()) %>%
  unnest_tokens(word, tweet_text) %>%
  inner_join(lexicon) %>%
  group_by(linenumber) %>%
  summarise(sentiment = sum(polarity)) %>%
  left_join(tweet %>%
              #exporting sentiment report as (sentiment analysis output)
              mutate(linenumber = row_number())) %>% write.csv("sentiment_analysis_ouptut.csv", row.names = FALSE)
