library(RCurl)
o = getURLContent("http://localhost:9200/spamassassin/message/1")

library(RJSONIO)
fromJSON(o)


o = getForm("http://localhost:9200/spamassassin/_search", q = 'Gentleman')


