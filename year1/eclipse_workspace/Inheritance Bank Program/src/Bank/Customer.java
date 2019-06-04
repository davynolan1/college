package Bank;
import java.util.ArrayList;
import java.util.Date;

public class Customer {

private String customerName;
private String customerAddress;
private String customerEmail;
private Date customerDateOfBirth;
private ArrayList<BankAccount> customerAccounts;


public Customer(String customerName, String customerAddress, String customerEmail, Date customerDateOfBirth, ArrayList<BankAccount> customerAccounts ) {
	this.customerName = customerName;
	this.customerAddress = customerAddress;
	this.customerEmail = customerEmail;
	this.customerDateOfBirth = customerDateOfBirth;
	this.customerAccounts = new ArrayList<BankAccount>();
}



public ArrayList<BankAccount> getCustomerAccounts() {
	return customerAccounts;
}



public void setCustomerAccounts(ArrayList<BankAccount> customerAccounts) {
	this.customerAccounts = customerAccounts;
}



public String getCustomerName() {
	return customerName;
}
public void setCustomerName(String customerName) {
	this.customerName = customerName;
}
public String getCustomerAddress() {
	return customerAddress;
}
public void setCustomerAddress(String customerAddress) {
	this.customerAddress = customerAddress;
}
public String getCustomerEmail() {
	return customerEmail;
}
public void setCustomerEmail(String customerEmail) {
	this.customerEmail = customerEmail;
}
public Date getCustomerDateOfBirth() {
	return customerDateOfBirth;
}
public void setCustomerDateOfBirth(Date customerDateOfBirth) {
	this.customerDateOfBirth = customerDateOfBirth;
}

public String toString() {
	return "BankCustomer [customerName=" + customerName + ", customerAddress=" + customerAddress + ", customerEmail=" + customerEmail + ", customerDateOfBirth="
			+ customerDateOfBirth + "]";
}



}