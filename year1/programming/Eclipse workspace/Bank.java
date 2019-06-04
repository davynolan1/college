import java.util.List;
import java.io.FileNotFoundException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Bank implements BankFunctions {
	long account=10001;
	
//	static BankCustomer[] customerArray= new BankCustomer[100];
//	static List<BankCustomer> customerList = new ArrayList<BankCustomer>();
	static Map<Long, BankCustomer> customerMap = new HashMap<Long, BankCustomer>();
	
	//public String findCustomer() {
		//return 
	//}

	@Override
	public long createAccountNumber() {
		
		return account++;
	}

	@Override
	public BankCustomer findCustomer(long accountNumber) {
		BankCustomer customer =null;
		boolean customerFound = false;
		int counter=0;
	//	while(!customerFound && counter< customerArray.length) {
	//	while(!customerFound && counter< customerList.size()) {
		//	customer=customerArray[counter];
		//	customer=customerList.get(counter);  // changing arrays to arraylist
		//	if(customer.getAccountNumber()==accountNumber) {
		//	customerFound=true;
		//	}
		//	counter++;
	 //}
		return customerMap.get(accountNumber);
	}

	@Override
	public BankCustomer findCustomer(String name, Date dateOfBirth, String address) {
		
		return null;
	}
	
	public long createAccountNumber() {
		return account++;
	}
	
	@Override
	public boolean debitAccount(long acconutNumber, double debitAmount) {
		BankCustomer customer = findCustomer(accountNumber);
		boolean accountDebited = false;
		double balance = customer.getBalance();
		if(balance>=debitAmount) {
			customer.setBalance(balance-debitAmount);
			accountDebited=true;
		}else {
			accountDebited=true;
		}
		return accountDebited;
	}

	@Override
	public boolean creditAccount(long accountNumber, double creditAmount) {
		BankCustomer customer = findCustomer(accountNumber);
		customer.setBalance(customer.getBalance()+creditAmount);
		return true;
	}

	@Override
	public void printBalance(long accountNumber) {
		BankCustomer customer = findCustomer(accountNumber);
		System.out.println(customer.getBalance());
		
	}
	
	public void readCustomerFromFile() {
		try {
			FileReader fileReader = new FileReader("customer.txt");
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			boolean endOfFileFound = false;
			while(!endOfFileFound) {
				String customerDate = bufferedReader.readLine();
				if (customerData == null) {
					endOfFileFound = true;
				}
				else {
					String[] customerProperties = customerData.split(","); 
					BankCustomer customer = new BankCustomer();
					customer.setAccountNumber(new Long(customerProperties[0]));
					customer.setSortCode(new Integer(customerProperties[1]));
					customer.setCustomerName(customerProperties[2]);
					customer.setCustomerAddress(customerProperties[3]);
					customer.setCustomerEmail(customerProperties[4]);
					customer.setBalance(new Double(customerProperties[5]));
					customerMap.put(customer.getAccountNumber(), customer);
				}
			}
		}
		catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}
}
