
public class Predictor6400 extends Predictor {
	
	private Table pht;
	private Register ghr;
	private int n ,counter;
	public Predictor6400() {
		n=11;
 		counter = 3;
		pht = new Table(1<<n,counter);
		ghr = new Register(n);
			
	}
	
	public void Train(long address, boolean outcome, boolean predict) {
		int index = (((int)address) & ((1<<n)-1))^(ghr.getInteger(0, n-1));
	 	int entry = pht.getInteger(index,0,counter-1);
	 	if (outcome) {
			 entry = Math.min((1<<counter)-1,++entry);
		}
	 	else{ 
	 		entry = Math.max(0,--entry);
		    }
	 	pht.setInteger(index,0,counter-1,entry);
	 	int ghr_value = ghr.getInteger(0, n-1);
		ghr_value<<= 1;
		if (outcome){
			ghr_value|=1;
		}
		else{ghr_value|=0;}
	 	ghr.setInteger(0, n-1, ghr_value);

	}


	public boolean predict(long address){
		int index = (((int)address) & ((1<<n)-1))^(ghr.getInteger(0, n-1));
	 	int entry = pht.getInteger(index,0,counter-1);
	 	if (entry>=2){return true;}
		else{return false;} 
	}
	
	
	


}