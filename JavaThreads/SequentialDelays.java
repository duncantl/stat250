
public class SequentialDelays {
    public static void main(String args[]) {
	int i;
	Delays d;
	for(i = 0; i < args.length; i++) {
	    d = new Delays(args[i]);
	    d.run();
	}
    }
}