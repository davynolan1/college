package Bank;

import java.util.ArrayList;

public class Branch {
	String address;
	String manager;
	
	public static final int SORT_CODE = 9991222;
	public ArrayList<Customer> customerList;
	
	public Branch() {
		customerList = new ArrayList<Customer>();
	}
	
	public Customer getCustomer(long accountNumber) {
		Customer customer = null;
		boolean customerFound = false;
		int counter = 0;
		while(!customerFound && counter < customerList.size()) {
			customer = customerList.get(counter);
			ArrayList<BankAccount> customerAccounts = customer.getCustomerAccounts();
			boolean accountFound = false;
			int accountCounter = 0;
			while(!accountFound && accountCounter < customerAccounts.size()) {
				if(customerAccounts.get(accountCounter).getAccountNumber() == accountNumber) {
					accountFound = true;
					customerFound = true;
				}
			}
		}
		
		if(!customerFound) {
			customer = null;
		}
		return customer;
	}
}
