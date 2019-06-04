import java.util.Scanner;

import javax.swing.JOptionPane;

public class OddEven {

	public static void main(String[] args) {
		String input = JOptionPane.showInputDialog("Enter number");
		Scanner inputScanner = new Scanner( input );
		int number = inputScanner.nextInt();
		
		if (number % 2 == 0 ) {
			JOptionPane.showMessageDialog(null, number + " is even.");
		}
		else {
			JOptionPane.showMessageDialog(null, number + " is odd." );
		}
	}
}