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
  # for now, require the  caller to give us a list with as many elements as there are threads
  # and each element is a character vector of the file names to process in that thread.
  #
function(files, fieldNum = sapply(files, getFieldNum), numThreads = 4L)
{
#  fnames = split(files, fieldNum)
  tt = .Call("R_threaded_multiReadDelays", files, as.integer(numThreads), TRUE, as.integer(fieldNum))
  tt[tt > 0]
}

