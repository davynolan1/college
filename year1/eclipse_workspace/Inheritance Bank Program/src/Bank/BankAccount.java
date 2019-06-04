package Bank;

public class BankAccount {
	private long accountNumber;
	private double balance;
	
	
	public long getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(long accountNumber) {
		this.accountNumber = accountNumber;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public double returnBalance() {
		return balance;
	}
	public void creditBalance(int balance) {
		this.balance += balance;
	}
	public void debitBalance(int balance) {
		this.balance -= balance;
	}
}
