#Sentiment Analysis

#--------------------------------------Syuzhet-------------------------------------------
serchstring="UnitedAirlines"
print(serchstring)
s=searchTwitter(searchString = serchstring,n = 2000,lang = "en")
d=twListToDF(s)
str(d)
t=d$text
typeof(t)

#Make sure everything is ASCII. Remove everything that is non-ASCII
Encoding(t)="latin1" 
iconv(t,"latin1","ASCII",sub="")

typeof(t)
g_syuzhet=get_sentiment(t)
g_bing=get_sentiment(t,method = "bing")
g_afinn=get_sentiment(t,method = "afinn")
g_nrc=get_sentiment(t,method = "nrc")
g_all =cbind(sign(g_syuzhet),sign(g_bing),sign(g_afinn),sign(g_nrc))
colnames(g_all) = c("Syuzhet","bing","afinn","nrc")
summary(g_all)

plot(g_syuzhet,type="l",xlim=seq(1,10))

percent_vals = get_percentage_values(g_syuzhet, bins = 10)
plot(
  percent_vals, 
  type="l", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

simple_plot(g_syuzhet)
s_nrc=get_nrc_sentiment(t)
barplot(
  sort(colSums(prop.table(s_nrc[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Emotions in Sample text", xlab="Percentage"
)

#--------------------------------------RSentiment-------------------------------------------

calculate_score(t[1:499])

#--------------------------------------WordCloud---------------------------------------
g=getTrends(23424848)

CreateWC = function(serchstring=String())
{

  serchstring="unicornfrappuccino"
  print(serchstring)
  s=searchTwitter(searchString = serchstring,n = 100,lang = "en")
  d=twListToDF(s)
  str(d)
  t=d$text
  typeof(t)
  
  #Make sure everything is ASCII. Remove everything that is non-ASCII
  Encoding(t)="latin1" 
  iconv(t,"latin1","ASCII",sub="")
  
  corp = Corpus(VectorSource(t))
  typeof(corp)
  
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  corp=tm_map(corp,toSpace,"/")
  corp=tm_map(corp,toSpace,"@")
  corp=tm_map(corp,toSpace,"\\|")
  corp=tm_map(corp,content_transformer(tolower))
  corp=tm_map(corp,removeNumbers)
  corp=tm_map(corp,removeWords,c(stopwords("english"),"http","https","tco",serchstring))
  corp=tm_map(corp,removePunctuation)
  corp=tm_map(corp,stripWhitespace)
  corp=tm_map(corp,removeWords,c("http","https","tco","unit",serchstring))
  corp=tm_map(corp,stemDocument)
  
  dtm = TermDocumentMatrix(corp)
  m = as.matrix(dtm)
  v = sort(rowSums(m),decreasing=TRUE)
  d = data.frame(word = names(v),freq=v)
  head(d, 10)
  
  
  wordcloud(words = d$word,freq = d$freq,min.freq = max(d$freq)*0.1,
            random.order = FALSE,random.color = FALSE,
            rot.per = 0.3,colors = brewer.pal(n = 8,name = "Set1"),scale =c(4,1) )

}
CreateWC("Dhoni")

#---------------------------------------------------------------------------------------
install_github("lchiffon/wordcloud2")
library(wordcloud2)
d1 = d[d$freq>200,]
wordcloud2(d1, figPath = file.choose(), size = 2)
