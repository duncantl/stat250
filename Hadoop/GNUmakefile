ifndef HADOOP_VERSION
HADOOP_VERSION=2.2.0
endif

HADOOP_INSTALL=$(HOME)/Downloads/hadoop-$(HADOOP_VERSION)
#HADOOP_INSTALL=$(HOME)/Downloads/hadoop-2.2.0
HADOOP_INSTALL=/usr/local/hadoop

JAVAC=javac
HADOOP_CLASSPATH=$(shell $(HADOOP_INSTALL)/bin/hadoop classpath)
JAVAC_FLAGS=-classpath .:$(HADOOP_CLASSPATH) -Xlint:deprecation
JAVAC_FLAGS= -classpath .:$(shell hadoop classpath)
%.class: %.java
	$(JAVAC) $(JAVAC_FLAGS) $<

JAVA_FILES=ArrivalDelayMapper.class ArrivalDelayReduce.class DelaysFrequencyTable.class \
           ArrivalDelayCombiner.class DelaysFrequencyCombinerTable.class ArrivalDelayReduceCombine.class

eg.jar: $(JAVA_FILES)
	jar cf $@ $^

run: eg.jar
	(export HADOOP_CLASSPATH=eg.jar ; $(HADOOP_INSTALL)/bin/hadoop DelaysFrequencyTable Data Out)

# distributed run
drun: eg.jar
	(export HADOOP_CLASSPATH=eg.jar ; $(HADOOP_INSTALL)/bin/hadoop DelaysFrequencyTable '/user/nehad/airlines/198*.csv'  /user/duncan/Out)


combrun: eg.jar
	(export HADOOP_CLASSPATH=eg.jar ; $(HADOOP_INSTALL)/bin/hadoop DelaysFrequencyCombinerTable '/user/nehad/airlines/198*.csv'  /user/duncan/CombinerOut)

clean:  
	rm *.class



