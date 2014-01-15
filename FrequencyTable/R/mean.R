# The idea is to have
# a table which we identify as a DiscreteFrequencyTable.
# We can have Integer and Real valued versions to identify
# the fact that the values in the names of the table
# are integers or real value.
#
# We use the DiscreteFrequencyTable class to differentiate from
# a generic table whose names may not be numbers.
#
#
# Define methods for merge() or + to combine two or more of these tables.
# Also define method for median, and quantile() generally.
#
#
# Also, define a function to create these types of tables.
# They will be specific to the source of the data.
# But the function(s) will set the class of the table
# with

IntegerFrequencyTable = 
function(table)
{
  class(table) = c("IntegerFrequencyTable", "DiscreteFrequencyTable", "table")
  table
}

# Note that we inherit from the table class so that we pick up any methods for table.



mean.IntegerFrequencyTable =
  # If we say mean(1:10, table)  we don't get this method, rather the default one.
  # 
function(x, ..., na.rm = FALSE)
{
  ids = as.numeric(names(x))
  if(na.rm) {
     i = is.na(ids)
     x = x[!i]
     ids = ids[!i]
  } 
  
  total = sum(x)
  ns = x/total
  sum(ids * ns)
}


hist.IntegerFrequencyTable =
  #
  # 
  #
  #
function(x)
{
  ids = as.integer(names(x))
  plot(ids, x, type = "h")
}
