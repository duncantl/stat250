ifndef HADOOP_VERSION
HADOOP_VERSION=2.2.0
endif

HADOOP_INSTALL=$(HOME)/Downloads/hadoop-$(HADOOP_VERSION)
#HADOOP_INSTALL=$(HOME)/Downloads/hadoop-2.2.0

JAVAC=javac
HADOOP_CLASSPATH=$(shell $(HADOOP_INSTALL)/bin/hadoop classpath)
JAVAC_FLAGS=-classpath .:$(HADOOP_CLASSPATH) -Xlint:deprecation

%.class: %.java
	$(JAVAC) $(JAVAC_FLAGS) $<


eg.jar: ArrivalDelayMapper.class ArrivalDelayReduce.class DelaysFrequencyTable.class 
	jar cf $@ $^

run: eg.jar
	(export HADOOP_CLASSPATH=eg.jar ; $(HADOOP_INSTALL)/bin/hadoop DelaysFrequencyTable Data Out)


clean:  
	rm *.class



