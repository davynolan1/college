/* SELF ASSESSMENT 
   1. Did I use appropriate CONSTANTS instead of numbers within the code? 
       Mark out of 5: 5
       Comment: 
   2. Did I use easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE? 
       Mark out of 5: 5
       Comment: 
   3. Did I use easy-to-understand meaningful variable names? 
       Mark out of 10: 10
       Comment:  
   4. Did I format the variable names properly (in lowerCamelCase)? 
       Mark out of 5: 5
       Comment:  
   5. Did I indent the code appropriately? 
       Mark out of 10: 10
       Comment:  
   6. Did I use an appropriate loop to allow the user to enter their guesses until they win or lose? 
       Mark out of 20: 15 - i don't think my loop is correct as it sometimes outputs the first card along with the next
       card.
       Comment:  
   7. Did I check the input to ensure that invalid input was handled appropriately? 
       Mark out of 10:  10
       Comment:  
   8. Did I generate the cards properly using random number generation (assuming all cards are equally likely each time)? 
       Mark out of 10: 10
       Comment:  
   9. Did I output the cards correctly as 2, 3, 4, ... 9, 10, Jack, Queen, King? 
       Mark out of 10: 10
       Comment:  
   10. Did I report whether the user won or lost the game before the program finished? 
       Mark out of 10: 10
       Comment:  
   11. How well did I complete this self-assessment? 
       Mark out of 5: 5
       Comment:  
   Total Mark out of 100 (Add all the previous marks): 95
*/

import java.util.Random;
import java.util.Scanner;

public class HiLo {
	public static final int MAX_DRAWS = 4;
	public static final int JACK = 11;
	public static final int QUEEN = 12;
	public static final int KING = 13;
	public static final int ACE = 14;
	public static void main(String[] args) {
		
		int drawsCount = 0;
		int ranCard = 0;
		int nextRanCard = 0;
		Random card = new Random();
		ranCard = card.nextInt(13) + 2;
		Scanner input = new Scanner(System.in);
		
		while(drawsCount < MAX_DRAWS) {
			if(ranCard == JACK) {
				System.out.println("The card is a Jack.");
			}
			else if(ranCard == QUEEN) {
				System.out.println("The card is a Queen.");
			}
			else if(ranCard == KING) {
				System.out.println("The card is a King.");
			}
			else if(ranCard == ACE){
				System.out.println("The card is an Ace.");
			}
			else if(drawsCount < 1){
				System.out.println("The card is a "+ranCard+".");
			}
			
			System.out.println("Do you think the next card will be 'higher', 'lower' or 'equal'?");
			
			nextRanCard = card.nextInt(13) + 2;
			
			String highLowEqual = input.next();
			if(nextRanCard > ranCard && highLowEqual.equals("higher")) {
				drawsCount++;
			}
			else if(nextRanCard == ranCard && highLowEqual.equals("equal")) {
				drawsCount++;
			}
			else if(nextRanCard < ranCard && highLowEqual.equals("lower")) {
				drawsCount++;
			}
			
			else if(nextRanCard <= ranCard && highLowEqual.equals("higher")) {
				System.out.println("Incorrect, you lose.");
				break;
			}
			else if(nextRanCard != ranCard && highLowEqual.equals("equal")) {
				System.out.println("Incorrect, you lose.");
				break;
			}
			else if(nextRanCard >= ranCard && highLowEqual.equals("lower")) {
				System.out.println("Incorrect, you lose.");
				break;
			}
			else {
				System.out.println("Invalid input, please enter 'higher', 'lower' or 'equal'");
			}
			
			if(nextRanCard == JACK) {
				System.out.println("The card is a Jack.");
			}
			else if(nextRanCard == QUEEN) {
				System.out.println("The card is a Queen.");
			}
			else if(nextRanCard == KING) {
				System.out.println("The card is a King.");
			}
			else if(nextRanCard == ACE){
				System.out.println("The card is an Ace.");
			}
			else{System.out.println("The card is a "+nextRanCard+".");
			}
		}
		if(drawsCount == 4) {
			System.out.println("Congratulations, you got them all correct.");
		}
		}

}
