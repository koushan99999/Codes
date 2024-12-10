import java.util.Random;
import java.util.concurrent.*;
class Bank{
	private int ntellers;
	private int ncustomers;
	private int customerid = 0; 
	public Bank(int n, int c){
		ntellers = n;
		ncustomers = c;
        createthread();
    }
	class teller implements Runnable{
		public void run(){
			while(customerid < ncustomers){
				int id = assignCustomer();
				assign(id);
				try{
                    Thread.sleep(1000);
                }
				catch (InterruptedException e) {e.printStackTrace();}
			}
		}
	}
        public void createthread(){
            teller t[] = new teller[ntellers];
		    Thread th[] = new Thread[ntellers];
		    for(int i=0; i<ntellers; i++){
			    t[i]= new teller();
			    th[i]= new Thread(t[i]);
			    th[i].start();
		    }
        }
		public void assign(int id) {
			long threadId = Thread.currentThread().getId()%ntellers+1;
			System.out.println("Customer " + id + " served by teller " + threadId);
			}
        public int assignCustomer(){
				customerid += 1;
				return customerid;
            }
	public int getcustom(){
		return ncustomers;
	}
	public int gettellers(){
		return ntellers;
	}
}