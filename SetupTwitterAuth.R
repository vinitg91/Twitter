install.packages(c("devtools", "rjson", "bit64", "httr"))
install_github("geoffjentry/twitteR")
library(devtools)
library(twitteR)

#Get these tokens from your Twitter account to be used here in Twitter API
consumer_key = "YourConsumerKey"
consumer_secret = "YourConsumerSecret"
access_token = "YourAccessToken"
access_secret = "YourAccessSecret"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


