install.packages(c("devtools", "rjson", "bit64", "httr"))
install_github("geoffjentry/twitteR")
library(devtools)
library(twitteR)

consumer_key = "aKhkJgQPbzVWle6t8CK8FqLAl"
consumer_secret = "OlYwBlKSjyaqjB4t8UktTkATaeRczeujFIwRePQFywJ86Fw7RK"
access_token = "64362382-jZaXuBrYFjrcN3UqrNqn92pdZwHiSDA7tcMuVBF17"
access_secret = "e0d1tqGqPkeREg0Wveoy1UjNiycDGS12Fzfge902LqXsl"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


