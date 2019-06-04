package bank;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class bankApplication {

	public static void main(String [] args) {
			
			Bank bank = new Bank();
			
			BankCustomer bankCustomer = new BankCustomer();
			// just created an object bankCustomer will live
			//on the stack and new BankCustomer lives on the heap
			bankCustomer.setAccountNumber(1222334455);
			bankCustomer.setSortCode(991277);
			bankCustomer.setCustomerName("Joe");
			bankCustomer.setCustomerEmail("joe@tcd.ie");
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			try {
				bankCustomer.setCustomerDateOfBirth(formatter.parse("10/01/1990"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			bankCustomer.setCustomerAddress(" trinity college dublin ");
			//customerArray[0]= bankCustomer;
			//customerList.add(bankCustomer); // puts it into the next available poistion 
			bank.customerMap.put(new Long(1222334455), bankCustomer);
			bank.findCustomer(new Long(1222334455));
		}
	

}
