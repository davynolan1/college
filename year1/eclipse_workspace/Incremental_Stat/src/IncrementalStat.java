/* SELF ASSESSMENT 
   1. Did I use easy-to-understand meaningful variable names? 
       Mark out of 10: 10
   2. Did I format the variable names properly (in lowerCamelCase)? 
       Mark out of 5: 5
   3. Did I indent the code appropriately? 
       Mark out of 10: 10
   4. Did I input the numbers one at a time from the command line?
       Mark out of 10: 10 
   5. Did I check the input to ensure that invalid input was handled appropriately?
       Mark out of 10: 10
   6. Did I use an appropriate while or do-while loop to allow the user to enter numbers until they entered exit/quit?
       Mark out of 20: 20
   7. Did I implement the loop body correctly so that the average and variance were updated and output appropriately?
       Mark out of 30: 15 - I could not get the correct answers to be printed for variance. However, average is correct.
   8. How well did I complete this self-assessment? 
       Mark out of 5: 5
   Total Mark out of 100 (Add all the previous marks): 85
*/

import java.util.Scanner;

public class IncrementalStat {

	public static void main(String[] args) {
		int total = 0;
		
		int numberCount = 0;
		boolean finished = false;
		do
		{
			Scanner input = new Scanner( System.in );
			System.out.print("Enter a whole number (or type 'exit' or 'quit'): ");
			
			if (input.hasNextInt())
			{
				int number = input.nextInt();
				total += number;
				numberCount++;
				double average = ((double) total) / ((double) numberCount);
				double variance = ((double) number - average)*((double) number - average);
				double variance2 = variance / (numberCount - 1);
				if (numberCount > 0)
				{
					System.out.println("Average is " + average +". Variance is "+ variance2);
				}
				else System.out.println("No numbers entered.");
			}
			else if (input.hasNext("exit"))
			{
				finished = true;
				System.out.println("Goodbye.");
			}
			else if (input.hasNext("quit"))
			{
				finished = true;
				System.out.println("Goodbye.");
			}
			else System.out.println("Not a valid whole number.  Try again.");
		} while (!finished);
	}
}