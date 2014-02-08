run:
	hadoop jar $(HADOOP_HOME)/contrib/streaming/hadoop-*streaming*.jar -file mapper  -mapper mapper -file reducer -reducer reducer -input /user/duncan/smallAirlines -output /user/duncan/small-output

mapper:  mapper.c
	$(CC) -o $@  $^

reducer:  reducer.c
	$(CC) -o $@  $^

