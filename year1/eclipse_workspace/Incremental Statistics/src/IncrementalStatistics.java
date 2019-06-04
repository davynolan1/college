
import java.util.Scanner;

import javax.swing.JOptionPane;

public class IncrementalStatistics {

	public static void main(String[] args) {
		
		String userInput = JOptionPane.showInputDialog("Enter a whole number. "
				+ "(Enter 'quit' or 'exit' to stop.)");
		
		Scanner inputScanner = new Scanner( userInput );
		
		boolean finished = false;
		int number = 0;
		int total = 0;
		int numberInputCount = 0;
		number = inputScanner.nextInt();
		
			
			
			numberInputCount++;

			int average = number / numberInputCount;
			total += number;
			JOptionPane.showInputDialog("The average so far is "+ total +
					"." + " Enter another whole number. (Enter 'quit' or 'exit' "
							+ "to stop)");
			
			
			while (true) {
					int number2 = inputScanner.nextInt();
					numberInputCount++;
					int average2 = total +((number - total) / numberInputCount);
					JOptionPane.showInputDialog("The POOP average so far is "+ average2 +
							"." + " Enter another whole number. (Enter 'quit' or 'exit' "
									+ "to stop)");
				 }
			
		
				
			
			
		
			
			//JOptionPane.showInputDialog(null, "The average so far is "+average);
			
		}
				
			
		
		
		
		
		// TODO Auto-generated method stub

	}


