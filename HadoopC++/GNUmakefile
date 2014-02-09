ifndef PLATFORM
HADOOP_INSTALL=/usr/local/hadoop
#$(HOME)/hadoop-2.2.0
endif


ifndef PLATFORM
PLATFORM=Linux-amd64-64
endif

CPPFLAGS=-I$(HADOOP_INSTALL)/include -I$(HADOOP_INSTALL)/c++/$(PLATFORM)/include/hadoop -O2
LDFLAGS=-L$(HADOOP_INSTALL)/lib/native/$(PLATFORM) -L$(HADOOP_INSTALL)/c++/$(PLATFORM)/lib -lhadooppipes -lhadooputils -lpthread -lcrypto
# -lhadoop -lhdfs

delays: delays.cpp
	$(CXX) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

install: delays
	-hadoop fs -copyFromLocal delays /user/duncan/bin/
	hadoop fs -chmod a+x /user/duncan/bin/delays

run: delays
	hadoop pipes -D hadoop.pipes.java.recordreader=true  -D hadoop.pipes.java.recordwriter=true \
          -input '/user/nehad/airlines/198*.csv' -output /user/duncan/PipesOut -program /user/duncan/bin/delays


