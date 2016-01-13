library(shiny)
#
# packages to install prior
#install the necessary packages
#install.packages("twitteR")
#install.packages("wordcloud")
#install.packages("tm")

library("twitteR")
library("wordcloud")
library(tm)

#necessary file for Windows
#download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

#to get your consumerKey and consumerSecret see the twitteR documentation for instructions
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''
options(httr_oauth_cache = TRUE)
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

#the cainfo parameter is necessary only on Windows
searchresults <- searchTwitter("#sotu", n=1500)
#searchresults<- searchTwitter("#Rstats", n=1500, cainfo="cacert.pem")


#save text
tweet_text <- sapply(searchresults, function(x) x$getText())
tweet_text <- iconv(tweet_text, "latin1","ASCII",sub="")

#create corpus
tweet_corpus <- Corpus(VectorSource(tweet_text))

#clean up
tweet_corpus <- tm_map(tweet_corpus, content_transformer(tolower)) 
tweet_corpus <- tm_map(tweet_corpus, removePunctuation)
tweet_corpus <- tm_map(tweet_corpus, function(x)removeWords(x,stopwords()))
#wordcloud(tweet_corpus)
print("done")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$wordcloud <- renderPlot({
    wordcloud(tweet_corpus, 
              colors = brewer.pal(8,"Dark2"), 
              min.freq = input$frequency, 
              max.words = input$maxwords)
  })
  
})