
public class Euclidean extends org.apache.pig.EvalFunc<Double> {

    public Double exec(org.apache.pig.data.Tuple input) 
                 throws org.apache.pig.backend.executionengine.ExecException 
    {

	int numEls = input.size()/2;
	double ans = 0;
	for(int i = 0; i < numEls; i++) {
	    double tmp1, tmp2;
	    tmp1 = (double) input.get(i);
	    tmp2 = (double) input.get(i + numEls);
	    ans += (tmp1 - tmp2)*(tmp1 - tmp2);
	}
	return(ans);
    }
}