ifndef PLATFORM
HADOOP_INSTALL=$(HOME)/hadoop-2.2.0
endif

CPPFLAGS=-m32 -I$(HADOOP_INSTALL)/include -O2
LDFLAGS=-L$(HADOOP_INSTALL)/lib/native -lhadooppipes -lhadooputils -lhadoop -lhdfs

delays: delays.cpp
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

