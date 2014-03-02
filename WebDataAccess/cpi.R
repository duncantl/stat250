u = 'http://www.rateinflation.com/consumer-price-index/usa-historical-cpi'


library(RCurl)
library(RHTMLForms)

fm = getHTMLFormDescription(u)

length(fm)

cpi = createFunction(fm[[1]])

o = cpi(1934, 2014)

o = cpi(1934, 2014, followlocation = TRUE)

library(XML)
tt = readHTMLTable(htmlParse(o), header = TRUE)
tt[[1]]

tt = readHTMLTable(htmlParse(o), header = TRUE, which = 1L, stringsAsFactors = FALSE)

cpi = createFunction(fm[[1]], reader = function(doc) readHTMLTable(htmlParse(doc, asText = TRUE), header = TRUE, which = 1, stringsAsFactors = FALSE))
xx = cpi(1934, 2014, followlocation = TRUE)
