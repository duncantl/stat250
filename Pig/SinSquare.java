public class SinSquare extends org.apache.pig.EvalFunc<Double> {

    public Double exec(org.apache.pig.data.Tuple input) 
                 throws org.apache.pig.backend.executionengine.ExecException 
    {

	Double ans;
	double val = (double) input.get(0);
	ans = Math.sin(val * val);
	return(ans);
    }
}