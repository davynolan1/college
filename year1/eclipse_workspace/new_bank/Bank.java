import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

public class Bank implements BankInterface {
    long account = 10001;
    //static BankCustomer[] customerMap = new BankCustomer[100];
    Map<Long, BankCustomer> customerMap = new TreeMap<Long, BankCustomer>();

    public static void main(String[] args) {

    }
    public Bank() {
    	
    }
    

    public void readCustomerFromFile() {
        try {
            FileReader fileReader = new FileReader("/Users/cianhiggins/IdeaProjects/bank1/src/customers.txt");
            BufferedReader bufferedReader = new BufferedReader(fileReader);

            boolean endOfFile = false;
            while (!endOfFile) {
                String customerData = bufferedReader.readLine();
                if (customerData == null) {
                    endOfFile = true;
                } else {
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                    String[] customerProperties = customerData.split(",");
                    Date dateOfBirth = null;
//                    customer.setAccountNumber(Long.parseLong(customerProperties[0]));
//                    customer.setSortCode(Integer.parseInt(customerProperties[1]));
//                    customer.setCustomerName(customerProperties[2]);
//                    customer.setCustomerAddress(customerProperties[3]);
//                    customer.setCustomerEmail(customerProperties[4]);
                   
                    
                   
                    
                    try {
                        customer.setCustomerDateOfBirth(formatter.parse(customerProperties[5]));
                    } catch (ParseException e){
                        e.printStackTrace();
                    }
                    BankCustomer customer = new BankCustomer(
                    		Long.parseLong(customerProperties[0]),
                    		Integer.parseInt(customerProperties[1]),
                    		customerProperties[2],
                    		customerProperties[3],
                    		customerProperties[4]
                    		dateOfBirth,
                    		Double.parseDouble(customerProperties[6]));
                     customerMap.put(customer.getAccountNumber(), customer);
                }
            }
            bufferedReader.close();
            fileReader.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public long createAccountNumber() {
        return account++;
    }

    public BankCustomer findCustomer(long accountNumber) {
        BankCustomer customer = null;
        boolean customerFound = false;
        int counter = 0;
//        while (!customerFound && counter < customerMap.size()) {
//            customer = customerMap.get(counter);
//            if (customer.getAccountNumber() == accountNumber) {
//                customerFound = true;
//            }
//            counter++;
//        }
        return customerMap.get(accountNumber);
    }

    @Override
    public BankCustomer findCustomer(String name, Date dateOfBirth, String address) {
        BankCustomer customer = null;
        boolean customerFound = false;
        int counter = 0;
        while (!customerFound && counter < customerMap.size()) {
            customer = customerMap.get(counter);
            if (customer.getCustomerName().equals(name) &&
                    customer.getCustomerDateOfBirth().equals(dateOfBirth) &&
                    customer.getCustomerAddress().equals(address)) {
                customerFound = true;
            }
            counter++;
        }
        return customer;
    }


    @Override
    public boolean debitAccount(long accountNumber, double debitAmount) {
        BankCustomer customer = findCustomer(accountNumber);
        boolean accountDebited = false;
        double balance = customer.getBalance();

        Transactions myTransaction = new Transactions();
        myTransaction.setTransactionType("Debit");
        myTransaction.setTransactionAmount(debitAmount);
//        myTransaction.setTransactionDate();
        myTransaction.setClosingBalance(balance - debitAmount);

        ArrayList<Transactions> transactionsList = customer.getCustomerTransactions();
        transactionsList.add(myTransaction);

        if (balance >= debitAmount) {
            customer.setBalance(balance - debitAmount);
            accountDebited = true;
        } else {
            accountDebited = false;
        }

        return accountDebited;
    }

    @Override
    public boolean creditAccount(long accountNumber, double creditAmount) {
        BankCustomer customer = findCustomer(accountNumber);
        customer.setBalance(customer.getBalance() + creditAmount);
        return true;
    }

    @Override
    public void printBalance(long accountNumber) {
        BankCustomer customer = findCustomer(accountNumber);
        System.out.println(customer.getBalance());

    }

}
