
load("~/Data/SFGateHousePrices/housing.rda")
library(maps)

m = map('county', region = 'california', xlim = range(housing$long, na.rm = TRUE), ylim = range(housing$lat, na.rm = TRUE))

nms = gsub("california,", "", m$names)

# match the names to the
countyNames = gsub(" County", "", levels(housing$county))
i = match(tolower(countyNames), nms)


library(XML)
#
# We can create the initial svg document that we then annotate from within R.
# svg("housingCounties.svg"); map(......); dev.off()
# I have made it earlier.  If you remake it on your machine, the version of libcairo
# matters unfortunately.
doc = xmlParse("housingCounties.svg")

# Get the polygon nodes.
p = getPlotPoints(doc)
p[i]

# The polygons are in the same order as they were plotted in the map() call.

mapply(function(node, county) {
         xmlAttrs(node, append = TRUE) = c(onclick = sprintf("parent.showPlot('%s');", county))
       }, p[i], countyNames)

saveXML(doc, "annotatedHousingCounties.svg")
