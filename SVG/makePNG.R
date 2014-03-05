load("~/Data/SFGateHousePrices/housing.rda")

counties = split(housing, housing$county)

png("priceBoxplots.png", 500, 500)
boxplot(lapply(counties, `[[`, "price"))
dev.off()


mapply(function(data, name) {

   png(name, 500, 500)
   on.exit(dev.off())
   p = tapply(data$price, cut(data$date, "weeks"), quantile, c(.1, .5, .9), na.rm = TRUE)
   p = do.call(rbind, p)

   d = as.Date(rownames(p))
   plot(d, p[,2] , type = "l",
         xlab = "Date", ylab = "dollars",
         main = paste("Median weekly price for", gsub("\\.png", "", name)),
         ylim = range(p))

   lines(d, p[,1], col = "green", lty = 2)
   lines(d, p[,3], col = "red", lty = 2)
   
}, counties, sprintf("%s.png", gsub(" County", "", names(counties))))


sapply(counties, function(d) c(mean(d$long, na.rm = TRUE), mean(d$lat, na.rm = TRUE)))
