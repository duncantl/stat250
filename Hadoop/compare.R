o = read.table("Out/part-r-00000")
d1 = read.csv("Data/1987.csv")
d2 = read.csv("Data/1988.csv")
o2 = table(c(d1$ArrDelay, d2$ArrDelay))

all.equal(o2, structure(o[[2]], names = o[[1]]))


all.equal(as.character(o[[1]]), names(o2))
all.equal(as.integer(o[[2]]), as.integer(o2))


