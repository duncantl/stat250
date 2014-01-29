%.class: %.java
	javac $^

test:  Delays.class
	java -classpath . Delays  ~/Data/Airlines/1987.csv 

run:  Delays.class
	time java -classpath . Delays  ~/Data/Airlines/198*.csv ~/Data/Airlines/199*.csv  ~/Data/Airlines/200[0-7]*.csv

seq:  SequentialDelays.class Delays.class
	time java -classpath . SequentialDelays  ~/Data/Airlines/198*.csv ~/Data/Airlines/199*.csv  ~/Data/Airlines/200[0-7]*.csv