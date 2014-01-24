getDelayTable =
  #
  # a1 = getDelayTable("~/Data/Airline/Airlines/1987.csv", 15L)
  #
  #
function(filename, fieldNum = getFieldNum(filename))
{
  tt = .Call("R_getFileDelayTable", path.expand(filename), TRUE, as.integer(fieldNum))
  tt[tt > 0]
}

getFieldNum =
function(filename)
{
  d = read.csv(filename, nrows = 1, stringsAsFactors = FALSE)
  i = which(names(d) == "ARR_DELAY" | names(d) == "ArrDelay")

  tmp = d[1, 1:(i-1)]

  w = sapply(tmp, is.character)
  i + length(grep(",", as.character(tmp[1,w]))) - 1L
}


getDelayTable_thread =
  #
  # Take the files and field numbers and group them
  # and then divide them into numThreads groups.
  #
  #
function(files, fieldNum = sapply(files, getFieldNum), numThreads = 4L)
{
  tt = .Call("R_threaded_multiReadDelays", as.integer(numThreads), TRUE, as.integer(fieldNum))
  tt[tt > 0]
}

