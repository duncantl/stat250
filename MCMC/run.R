chptdat = read.table("http://www.stat.psu.edu/~mharan/MCMCtut/COUP551_rates.dat",skip=1) 
Y=chptdat[,2] # store data in Y

ts.plot(Y,main="Time series plot of change point data")
source("template.R")
a = mhsampler(1e4)

library(lattice)
d = data.frame( intensity = c(a$theta, a$lambda),
                when = rep(c("before", "after"), each = nrow(a)))
densityplot( ~ intensity, d, groups = when, plot.points = FALSE)

