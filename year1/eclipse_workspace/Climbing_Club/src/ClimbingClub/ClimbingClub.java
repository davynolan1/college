/* SELF ASSESSMENT

Harness Class: Member variables (8 marks) : 8
All my data members are declared, private and the ones that don't change are marked as private. I also have a constant for the maximum number of uses of a harness.
Comment:Yes they are and i also have a constant called MAX_USES.

Harness Class: Harness constructor 1 & constructor 2 (6 marks): 6
I initialise all the variables using the parameters given and set the other members to reasonable default values.
Comment:Yes they are initialised correctlu.

Harness Class: checkHarness method (5 marks) : 5
My method takes an instructor's name as a parameter, and if the harness is not on loan sets the instructor member variable to the given parameter value (assuming the instructor's name is not null/empty). It also resets the number of times the harness was used.
Comment: Yes it does.

Harness Class: isHarnessOnLoan method (2 marks) : 2
My method has no parameters and returns the value of the loan status variable.
Comment:Yes it does.

Harness Class: canHarnessBeLoaned method (4 marks) : 4
My method has no parameters and returns true if the harness is not on loan and if the number of times it was used is less than the maximum allowed number of times.
Comment: Yes it does.

Harness Class: loanHarness method (6 marks) : 6
My method has a member name as a parameter and it checks if harness can be loaned by using the canHarnessBeLoaned method. If true, it sets the club member value to the parameter value, sets the on loan status to true and increments the number of times used variable.
Comment: Yes it does.
 
Harness Class: returnHarness method (5 marks) : 5
My method has no parameters, checks if the harness is on loan, and if so, changes its on-loan status to false, and resets the club member value.
Comment: Yes it does.

Harness Class: toString method (3 marks) : 3
My method returns a String representation of all the member variables.
Comment: Yes it does.

HarnessRecords Class: member variables (3 marks) : 3
I declare the member variable as a private collection of Harnesses 
Comment: Yes I did.
 
HarnessRecords Class: HarnessRecords constructor 1 & 2 (9 marks) : 7
In the first constructor, I set the member variable to null [1 mark]. In the second constructor, I use the Java I/O to read data from a text file I created containing sets of Harness characteristics. I use these set of characteristics to create Harness objects and add them to the collection. 
Comment: The constructor is set up correctly, however i had trouble trying to use the Java I/O to read data and split it up into the different harness characteristics.

HarnessRecords Class: isEmpty method (1 marks) : 1
I return true if the collection is null/empty and, false otherwise.
Comment: Yes I did.

HarnessRecords Class: addHarness method (5 marks) :5
My method takes a Harness object as a parameter and adds the harness to the collection.
Comment: Yes it does.

HarnessRecords Class: findHarness method (6 marks) : 6
My method takes a make and model number as parameters. It checks if a harness with such properties exists and if it does it returns harness object, otherwise returns null.
Comment: Yes it does.

HarnessRecords Class: checkHarness method (6 marks) : 6
must take instructor name, make and model number as parameters and return a Harness. If a harness with the make and model number exists by using the findHarness method and is not on loan, the Harness method checkHarness is called with the instructor name as a parameter and the updated Harness object is returned. If the harness is not available returns null.
Comment: Yes it does.

HarnessRecords Class: loanHarness method (7 marks) : 7
My method takes a club member name as a parameter and looks for an available harness by calling the method canHarnessBeLoaned be loaned. If an available harness is found it is loaned by using the Harness method loanHarness with the club member as a parameter, returning the harness. If there's no available harness null is returned.
Comment: Yes it does.

HarnessRecords Class: returnHarness method (7 marks) : 7
My method takes a make and model number as parameters. It checks if a harness with those properties exists by using the findHarness method. If the found harness is not null, it returns the harness object by using Harness method returnHarness, otherwise returns null.
Comment: Yes it does.

HarnessRecords Class: removeHarness method (8 marks) : 8
My method takes a make and model number as parameters and check the collection for a harness with those properties and removes it. It returns the harness object if it is found, otherwise returns null.
Comment: Yes it does.

GUI (Java main line) (5 marks) :0
My test class has a menu which implements at least the five points specified using the HarnessRecords class methods.
Comment: 

93/100 marks
*/
package ClimbingClub;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class ClimbingClub {
	
	public static void main(String[] args) throws IOException {
		
		String[] make = new String[5];
		String[] modelNumber = new String[5];
		int[] timesUsed = new int[5];
		String[] instructorName = new String[5];
		boolean[] onLoan = new boolean[5];
		String[] memberName = new String[5];
		
		BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\Davy\\Documents\\My Documents\\Eclipse Workspace\\Climbing Club\\src\\ClimbingClub\\records.txt"));
		
		//String[] records = {};
		
		String line = br.readLine();
		while(line != null) {
			int m = 0;
			String[] lines = line.split("\n");
			String[] traits = lines[m].split(", ");
			line = br.readLine();
			m++;
		}
		
		
		
		
		
//		for(int j=0; j<traits.length; j++) {
//			
//		}
		
		HarnessRecords newHarnessList = new HarnessRecords(5, make, modelNumber, timesUsed, instructorName, onLoan, memberName);

		System.out.println("(1) Add a record for a newly purchased harness.");
		System.out.println("(2) Remove a climbing harness from the club.");
		System.out.println("(3) Record the face that a club instructor has checked "
				+ "the safety of a harness.");
		System.out.println("(4) Loan a harness to a club member.");
		System.out.println("(5) Return a harness.");
		System.out.println("(6) Exit program.");
		Scanner s = new Scanner(System.in);
		boolean finished = false;
		//while(!finished) {
			s = new Scanner(System.in);
			System.out.println();
			System.out.println("Enter the number of action you wish to perform from the list: ");
			int numInput = s.nextInt();
			Scanner scan;
			if(numInput == 1) {
				scan = new Scanner(System.in);
				System.out.println("Enter make and model number of new harness separated by a comma and space(, ).");
				String input = scan.nextLine();
				String[] newHar = input.split(", ");
				String m = newHar[0];
				String mNo = newHar[1];
				Harness newHarness = new Harness(m, mNo, "");
				newHarnessList.addHarness(newHarness);
				System.out.println("***New harness has been sucessfully added to records***");
				
			}
			
			else if(numInput ==2) {
				scan = new Scanner(System.in);
				System.out.println("Enter make and model number of harness you wish to remove separated by a comma and space(, )");
				String input = scan.nextLine();
				String[] remHar = input.split(", ");
				String ma = remHar[0];
				String moNo = remHar[1];
				if(newHarnessList.findHarness(ma, moNo)==null) {
					System.out.println("Harness not found.");
				}
				else {
					newHarnessList.removeHarness(ma, moNo);
					System.out.println("***Harness with make: '"+ma+"', and model number: "+moNo+" has been removed***");
				}
			}
			
			else if(numInput == 3) {
				System.out.println();
			}
			
			else if(numInput == 4) {
				System.out.println();
			}
			
			else if(numInput == 5) {
				System.out.println();
			}
			
			else if(numInput == 6) {
				finished = true;
				System.out.println("Goodbye.");
			}
			else {
				System.out.println("Invalid input, please enter a number from the options 1-5.");
			}
		//}
			
	
	
}
}
