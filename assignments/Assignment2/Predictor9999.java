
public class Predictor9999 extends Predictor {
	private Table pht;
	private Register ghr;
	private int n ,counter,m;
	
	public Predictor9999() {
		n=12;
		m=1<<n;
 		counter = 2;
		pht = new Table(m,counter);
		ghr = new Register(n);
		
	}


	public void Train(long address, boolean outcome, boolean predict) {
		int index = (((int)address) & ((m)-1))^(ghr.getInteger(0, n-1));
	 	int entry = pht.getInteger(index,0,counter-1);
	 	if (outcome) {
			 entry = Math.min(3,++entry);
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
		int index = (((int)address) & ((m)-1))^(ghr.getInteger(0, n-1));
	 	int entry = pht.getInteger(index,0,counter-1);
	 	if (entry>=2){return true;}
		else{return false;} 
	}

}