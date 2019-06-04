import java.util.Date;

public interface BankFunctions {
	
public long createAccountNumber ();
public BankCustomer findCustomer(long accountNumber);
public BankCustomer findCustomer(String name, Date dateOfBirth, String address);
public boolean debitAccount(long acconutNumber, double debitAmount);
public boolean creditAccount(long accountNumber, double creditAmount);
public void printBalance(long accountNumber); // parameters but no body

}
