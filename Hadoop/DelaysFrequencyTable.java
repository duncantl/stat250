/*
  This is the class for running the MapReduce job to compute the frequency table
  of counts for each observed arrival delay time in the airlines data.
  The data are CSV files in a directory given as the first command line argument.
  The output is written to a directory given by the second command line argument.

  This is HADOOP 1.0.*, not 2.2.*
 */

import org.apache.hadoop.fs.Path;

import org.apache.hadoop.mapreduce.*;

import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;

public class DelaysFrequencyTable {

    public static void main(String[] args) 
              throws Exception 
    {

	Job job = new Job(new Configuration());
	job.setJarByClass(DelaysFrequencyTable.class);
	job.setJobName("Delay Frequency Table");

	FileInputFormat.addInputPath(job, new Path(args[0]));
	FileOutputFormat.setOutputPath(job, new Path(args[1]));

	job.setMapperClass(ArrivalDelayMapper.class);
	job.setReducerClass(ArrivalDelayReduce.class);

	job.setOutputKeyClass(IntWritable.class);
	job.setOutputValueClass(LongWritable.class);

	job.setMapOutputKeyClass(IntWritable.class);
	job.setMapOutputValueClass(IntWritable.class);



	System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}