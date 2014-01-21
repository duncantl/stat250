
HADOOP_INSTALL=$(HOME)/Downloads/hadoop-1.0.2
# -2.2.0
JAVAC=javac
HADOOP_CLASSPATH=$(shell $(HADOOP_INSTALL)/bin/hadoop classpath)
JAVAC_FLAGS=-classpath .:$(HADOOP_CLASSPATH) -Xlint:deprecation

%.class: %.java
	$(JAVAC) $(JAVAC_FLAGS) $<


eg.jar: ArrivalDelayMapper.class DelaysFrequencyTable.class ArrivalDelayReduce.class
	jar cf $@ $^

run: eg.jar
	(export HADOOP_CLASSPATH=eg.jar ; $(HADOOP_INSTALL)/bin/hadoop -classpath $(HADOOP_CLASSPATH) DelaysFrequencyTable Data Out)



