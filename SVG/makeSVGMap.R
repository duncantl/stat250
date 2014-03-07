
load("~/Data/SFGateHousePrices/housing.rda")
library(maps)

m = map('county', region = 'california', xlim = range(housing$long, na.rm = TRUE), ylim = range(housing$lat, na.rm = TRUE))

nms = gsub("california,", "", m$names)

# match the names to the
countyNames = gsub(" County", "", levels(housing$county))
i = match(tolower(countyNames), nms)


library(XML)
doc = xmlParse("housingCounties.svg")

p = getPlotPoints(doc)
p[i]

mapply(function(node, county) {
         xmlAttrs(node, append = TRUE) = c(onclick = sprintf("parent.showPlot('%s');", county))
       }, p[i], countyNames)

saveXML(doc, "annotatedHousingCounties.svg")
