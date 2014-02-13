-- tab separated file is default.
records = LOAD 'delays_tab.txt' 
    AS (Year:int, Month:int, DayofMonth:int, DayOfWeek:int, DepTime:int, CRSDepTime:int, ArrTime:int, CRSArrTime:int, UniqueCarrier:chararray, FlightNum:int, TailNum:chararray, ActualElapsedTime:int, CRSElapsedTime:int, AirTime:int, ArrDelay:int, DepDelay:int, Origin:chararray, Dest:chararray, Distance:int, TaxiIn:int, TaxiOut:int, Cancelled:int, CancellationCode:int, Diverted:int, CarrierDelay:int, WeatherDelay:int, NASDelay:int, SecurityDelay:int, LateAircraftDelay:int);

DESCRIBE records;

sfo = FILTER records BY Origin = 'SFO'; -- error. Should be ==
sfo = FILTER records BY Origin == 'SFO';
dest = GROUP sfo BY Dest;
max_delay = FOREACH dest GENERATE group, MAX(sfo.ArrDelay);
DUMP max_delay;

store max_delay into 'grouped_delays';
