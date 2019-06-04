import java.text.ParseException;
import java.text.SimpleDateFormat;

public class BankApplication {
    public static void main(String[] args) {

        Bank bank = new Bank(); //create an object of our blueprint class - Bank.java

        BankCustomer bankCustomer = new BankCustomer();
        bankCustomer.setCustomerName("Joe Bloggs");
        bankCustomer.setAccountNumber(12345678);
        bankCustomer.setSortCode(662288);
        bankCustomer.setCustomerEmail("joe@tcd.ie");
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            bankCustomer.setCustomerDateOfBirth(formatter.parse("12/01/1998"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        bankCustomer.setCustomerAddress("trinners");

        bank.customerMap.put(Long.parseLong("12345678"), bankCustomer);

    }
}
