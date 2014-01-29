import java.io.*;

public class Delays implements Runnable {

    protected String filename;

    int[] delays = new int[4501];
    int min = -2250, max = 2250;

    public Delays(String name) {
	filename = name;
    }


    public void run() {
        java.io.InputStream fstream;
	try {
	    fstream = new java.io.FileInputStream(filename);
	    java.io.BufferedReader buf = new java.io.BufferedReader(new java.io.InputStreamReader(fstream));

	    buf.readLine(); // header

	    readRecords(buf);
	    buf.close();
	} catch(Exception e) {
	    System.out.println("Problem processing " + filename);
	    System.out.println(e.toString());
	    e.printStackTrace();
	}
    }


    public void readRecords(BufferedReader buf) throws IOException {
	String line;
	int count = 0;
	while( (line = buf.readLine()) != null) {
	    String val = getDelay(line);
	    count ++;
	    storeDelay(val);
	}
	System.out.println("Number of lines processed for " + filename + " " + count);
    }

    public String getDelay(String line) {
	String[] els =  line.split(",");
	//	System.out.println(els[14]);
	return(els[14]);
    }

    protected void storeDelay(String value) {
	if(value != null && !value.isEmpty() && !value.equals("NA")) {  // not value != "NA" as in R!
	    int val = (int) Double.parseDouble(value);
	    if(val < min  || val > max) 
		System.out.println("delay value problem " + val + ". Ignoring this value");
	    else
		delays[val - min] ++;

	}
    }

    public void showTable() {
	for(int i = 0; i < delays.length ; i++) {
	    if(delays[i] > 0)
		System.out.println( min + i + ": " + delays[i]);
	}
    }

    public static void main(String args[]) {

	if(args.length > 1) {
	    Thread[] threads = new Thread[args.length];
	    int i;
/*
	    for(i = 0; i < args.length; i++) {
		Delays d = new Delays(args[0]);
		d.run();
	    }
*/

	    for(i = 0; i < args.length; i++) {
		threads[i] = new Thread(new Delays(args[i]));
		threads[i].start();
//		d.showTable();
	    }

	    for(i = 0; i < args.length; i++) {
		try {
		    threads[i].join();
		} catch(InterruptedException e) {
		    System.out.println(e);
		}
	    }


	} else {
	    Delays d = new Delays(args[0]);
	    d.run();
//	    d.showTable();
	}
    }

}