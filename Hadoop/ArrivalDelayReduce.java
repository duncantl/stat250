/*
  Take all of the observations for a particular arrival delay value.
  We then output the delay value and the number of observations.
 */

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;

import org.apache.hadoop.mapreduce.Reducer;

public class ArrivalDelayReduce extends Reducer<IntWritable, IntWritable, IntWritable, LongWritable> 
{

    public void reduce(IntWritable key, Iterable<IntWritable> it, Context context) 
   	        throws IOException, InterruptedException 
    {
	long sum = 0;

	// If we knew the particular class of this object, we might be able to call its .size() method.
	for(IntWritable val : it) {
	    sum++;
	}
	context.write(key, new LongWritable(sum));
    }
}

