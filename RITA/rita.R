# The first 2/3 of the code is described in the book
# XML and Web Technologies for Data Science with R
# Nolan and Temple Lang

uBTS = "http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236"

library(RHTMLForms)
fm = getHTMLFormDescription(uBTS)

print(fm, showHidden = TRUE)

library(XML)


doc = htmlParse(uBTS)
varNames = xpathSApply(doc, "//input[@name='VarName']", 
                        xmlGetAttr, "value")


vars = paste(varNames, collapse = ",")
sqlQuery = sprintf("SELECT %s FROM T_ONTIME 
                     WHERE Month = %%d AND YEAR = %%d",
                   vars)

fm = fm$form1

fm$elements[["varlist"]] = 
  structure(list(name = "varlist", value = vars),
            class = c("HTMLHiddenElement", "HTMLFormElement"))
fm$elements[["sqlstr"]] = 
  structure(list(name = "sqlstr", value = sqlQuery),
            class = c("HTMLHiddenElement", "HTMLFormElement"))


# Now create the customized function corresponding to the form
rita = 
 createFunction(fm, cleanArgs = 
               function(args, formDescription) {
                 args[["sqlstr"]] = sprintf(args[["sqlstr"]],
                                       as.integer(args$FREQUENCY),
                                       as.integer(args$XYEAR))
                 args
              })


if(FALSE) {
# An example of how to call the rita() function to get data into a file.
library(RCurl)
out = CFILE("rita.zip", "wb")                      
curlOpts = list(followlocation = TRUE, verbose = TRUE,
                writefunction = NULL, writedata = out@ref)
rita(XYEAR = 2012, FREQUENCY = 2, .opts = curlOpts)
close(out)
}

library(RCurl)
getDelayData =
#
# retrieve the zip file containing the data for a given month and year.
# This is our primary entry point that downloads a month of data and 
# writes it to a file on disk (rather than keeping it in memory).
#
function(year, month, ..., .curl = getCurlHandle())
{
  tmp = tempfile()
  out = CFILE(tmp, "wb")                      
  curlOpts = list(followlocation = TRUE, ...,
                writefunction = NULL, writedata = out@ref)
  rita(XYEAR = year, FREQUENCY = month, .opts = curlOpts, .curl = .curl)
  close(out)
  cur = getwd()
  out = sprintf("%s%s%d_%s.csv", cur, .Platform$file.sep,
                       as.integer(year), format(ISOdate(2004, month, 1), "%B"))
  on.exit({ setwd(cur) ; unlink(tmp) } )
  setwd(dirname(tmp))
  extractAndRename(tmp, out)
}

extractAndRename =
#
# having downloaded the .zip file for a given month-year, we extract the CSV file and 
# rename it to the name year_month.csv
#
function(filename, to)
{
  tmp = filename
  library(Rcompression)
  e = names(zipArchive(tmp))
  system(sprintf("unzip %s", tmp))

system(paste("mv", e, to))
#  file.rename(e, to)
  to
}

