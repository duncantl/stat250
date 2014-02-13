records = LOAD '1987_tab.txt'  --  'file:///home/duncan/airlines/Pre2008_tab.txt' 
    AS (Year:int, Month:int, DayofMonth:int, DayOfWeek:int, DepTime:int, CRSDepTime:int, ArrTime:int, CRSArrTime:int, UniqueCarrier:chararray, FlightNum:int, TailNum:chararray, ActualElapsedTime:int, CRSElapsedTime:int, AirTime:int, ArrDelay:int, DepDelay:int, Origin:chararray, Dest:chararray, Distance:int, TaxiIn:int, TaxiOut:int, Cancelled:int, CancellationCode:int, Diverted:int, CarrierDelay:int, WeatherDelay:int, NASDelay:int, SecurityDelay:int, LateAircraftDelay:int);

byvals = GROUP records BY (UniqueCarrier, Month);
counts = FOREACH byvals GENERATE group, AVG(records.ArrDelay);
DUMP counts;



byvals = GROUP records BY (UniqueCarrier, Month, ArrDelay);
counts = FOREACH byvals GENERATE group, COUNT(records.ArrDelay);
DUMP counts;
