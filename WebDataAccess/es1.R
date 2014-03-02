
library(RCurl)
library(RJSONIO)

ans = httpDELETE("http://localhost:9200/stackoverflow/")
fromJSON(ans)

ans = httpPUT("http://localhost:9200/stackoverflow/", "{}")
fromJSON(ans)

map = list(properties = list(pubDate = c(type = 'date')))
ans = httpPUT("http://localhost:9200/stackoverflow/page/_mapping", toJSON(map))

httpGET("http://localhost:9200/stackoverflow/page/_mapping")



so = read.csv("~/Data/Kaggle/StackOverflow/train-sample", nrow = 100, stringsAsFactors = FALSE)

m1 = so[1,]
m1 = as.list(m1)

