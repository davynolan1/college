import java.util.ArrayList;
import java.util.Date;

public class BankCustomer {

    long accountNumber;
    int sortCode;
    String customerName = "";
    String customerAddress = "";
    String customerEmail = "";
    Date customerDateOfBirth;
    double balance;
    ArrayList<Transactions> customerTransactions;

    @Override
    public String toString() {
        return "BankCustomer{" +
                "accountNumber=" + accountNumber +
                ", sortCode=" + sortCode +
                ", customerName='" + customerName + '\'' +
                ", customerAddress='" + customerAddress + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerDateOfBirth=" + customerDateOfBirth +
                ", balance=" + balance +
                ", customerTransactions=" + customerTransactions +
                '}';
    }
    public BankCustomer() {
    	
    }
    public BankCustomer(long accNumber, int bankCode, String name, String address, String email, Date birthDate, double customerBalance) {
    	accountNumber = accNumber;
    	sortCode = bankCode;
    	customerName = name;
    	customerEmail = email;
    	customerDateOfBirth = birthDate;
    	balance = customerBalance;
    }
    
    public ArrayList<Transactions> getCustomerTransactions() {
        return customerTransactions;
    }

    public void setCustomerTransactions(ArrayList<Transactions> customerTransactions) {
        this.customerTransactions = customerTransactions;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public long getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(long accountNumber) {
        this.accountNumber = accountNumber;
    }

    public int getSortCode() {
        return sortCode;
    }

    public void setSortCode(int sortCode) {
        this.sortCode = sortCode;
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
}