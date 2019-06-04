/*  SELF ASSESSMENT
   1. Did I use appropriate CONSTANTS instead of numbers within the code?
       Mark out of 10: 10  
   2. Did I use easy-to-understand, meaningful CONSTANT names?
       Mark out of 5:  5
    3. Did I format the CONSTANT names properly (in UPPERCASE)?
       Mark out of 5:  5
   4. Did I use easy-to-understand meaningful variable names?
       Mark out of 10:  10
   5. Did I format the variable names properly (in lowerCamelCase)?
       Mark out of 10:  10
   6. Did I indent the code appropriately?
       Mark out of 10:  10
   7. Did I read the input correctly from the user using (an) appropriate question(s)?
       Mark out of 10:  10
   8. Did I compute the answer correctly for all cases?
       Mark out of 20:  20
   9. Did I output the correct answer in the correct format (as shown in the examples)?
       Mark out of 10:  10
   10. How well did I complete this self-assessment?
       Mark out of 10:  10
   Total Mark out of 100 (Add all the previous marks):  100
*/


import java.util.Scanner;

import javax.swing.JOptionPane;

public class PoundsShillingsPennies {

	public static void main(String[] args) {
		String input = JOptionPane.showInputDialog("Enter amounts of old pounds, "
				+ "shillings and pennies separated by spaces ");
		Scanner inputScanner = new Scanner( input );
		double oldPound = inputScanner.nextDouble();
		double oldShill = inputScanner.nextDouble();
		double oldPenny = inputScanner.nextDouble();
		inputScanner.close();
		
		double newPenny = oldPound*16080 + oldShill*804 + oldPenny*67;
		float newPound = (float) (newPenny/100);
				
				JOptionPane.showMessageDialog(null,oldPound+" old pound, "
				+oldShill+" old shilling, "+oldPenny+" old pence = £"+newPound);
				
		
		
		
		
		
		
		
		
		// TODO Auto-generated method stub

	}

}
