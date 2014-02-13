records = LOAD 'file:///home/duncan/airlines/Pre2008_tab.txt' -- 'delays_tab.txt'  -- 
    AS (Year:int, Month:int, DayofMonth:int, DayOfWeek:int, DepTime:int, CRSDepTime:int, ArrTime:int, CRSArrTime:int, UniqueCarrier:chararray, FlightNum:int, TailNum:chararray, ActualElapsedTime:int, CRSElapsedTime:int, AirTime:int, ArrDelay:int, DepDelay:int, Origin:chararray, Dest:chararray, Distance:int, TaxiIn:int, TaxiOut:int, Cancelled:int, CancellationCode:int, Diverted:int, CarrierDelay:int, WeatherDelay:int, NASDelay:int, SecurityDelay:int, LateAircraftDelay:int);

byvals = GROUP records BY ArrDelay;
counts = FOREACH byvals GENERATE group, COUNT(records);  -- COUNT_STAR(); 
  /* The records in the call to COUNTS() is not the records variable on the left hand side of the assignment above (for the LOAD)
     Instead, records is an element of the byvals object (tuple or bag?).
      DESCRIBE byvals. This has the group and records components/elements
   */
DUMP counts;