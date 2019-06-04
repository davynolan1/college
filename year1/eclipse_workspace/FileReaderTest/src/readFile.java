
public class readFile {
	public static void main(String[] args) {
		Customer[] customers = getCustomers();
		PrintWriter custOutput = createFile()
	}
	private static class Customer{
		public String firstName;
		public String lastName;
		public int custAge;
		
		public Customer(String firstName, String lastName, int custAge) {
			this.firstName = firstName;
			this.lastName = lastName;
			this.custAge = custAge;
		}
	}
	private static Customer[] getCustomers() {
		Customer[] customers = new Customer[5];
		
		customers[0]= new Customer("John", "Smith", 21);
		customers[1]= new Customer("Davy", "Smith", 25);
		customers[2]= new Customer("Gary", "Smith", 29);
		customers[3]= new Customer("Ross", "Smith", 7);
		customers[4]= new Customer("Daniel", "Smith", 89);
		
		return customers;
	}
	
}
