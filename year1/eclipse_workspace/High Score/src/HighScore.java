/* SELF ASSESSMENT
 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5: 5 - Yes I did.
 2. Did I indent the code appropriately?
        Mark out of 5: 5 - Yes the I indented the code as per the specifications for this assignment.
 3. Did I write the initialiseHighScores function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15: 15 - Yes i used the provided function name and declared it correctly.
 4. Did I write the printHighScores function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15: 15 - Yes i used the provided function name and declared it correctly.
 5. Did I write the higherThan function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15: 15 - Yes i used the provided function name and declared it correctly.
 6. Did I write the insertScore function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20: 0 - I didn't know how to carry out this function.
 7. Did I write the main function body correctly (first asking for the number of scores to be maintained and then repeatedly asking for scores)?
       Mark out of 20: 20 - Yes the main function body first asks for how many scores the user would
       like to maintain and then asks for the scores to be entered until reaching the amount to be 
       maintained.
 8. How well did I complete this self-assessment?
        Mark out of 5: 5 - I marked myself honestly and provided comments for each mark.
 Total Mark out of 100 (Add all the previous marks): 80
*/ 
import java.util.Arrays;
import java.util.Scanner;

public class HighScore {

	public static void main(String[] args) {
		Scanner inputScanner = new Scanner(System.in);
		System.out.print("How many scores would you like to maintain?");
		int userInput = inputScanner.nextInt();
		int[] zeroSetScores = {};
		int[] setScores = initialiseHighScore(userInput, zeroSetScores);
		System.out.println("Enter the high scores you want to display.");
		int[] highScores = printHighScores(setScores, userInput);
		System.out.println("The high scores are:");
		int[] higherThan = higherThan(highScores);
		for (int count = 0; count <= (userInput-1); count++)
		{
			System.out.println((count + 1) + ". " + higherThan[count]);
		}
	}
	public static int[] initialiseHighScore(int userInput, int[] zeroSetScores) {
		zeroSetScores = new int [userInput];
		for (int index = 0; index <= (userInput - 1); index++)
		{
			zeroSetScores[index] = 0;
		}
		return zeroSetScores;
	}
	public static int[] printHighScores(int[] setScores, int userInput) {
		Scanner scoreInput = new Scanner(System.in);
		int[] setScore = {};
		for (int count = 0; count <= (userInput - 1); count++)
		{
			int scores = scoreInput.nextInt();
			if(scores < 0)
			{
				System.out.println("Impossible, only enter positive scores!");
				scores = scoreInput.nextInt();
				setScores[count] = scores;
			}
			else 
			{
				setScores[count] = scores;
			}
		}
		for (int count = 0; count >= (userInput - 1); count++)
		{
			for (int count2 = 0; count2 <= (userInput - 1); count2++)
			{	
				if (setScore[count] < setScore[count2])
				{
					int numberSaved = 0;
					for (int count3 = (userInput - 1); count3 >= 0; count3--)
					{
						setScore[count] = numberSaved;
						setScore[count3] = setScore[count3 + 1];
					}
					setScore[userInput - 1] = numberSaved;
				}
			}
		}
		return setScores;
	}
	public static int[] higherThan(int[] highScores){
			
		Arrays.sort(highScores);
		for(int count = 0; count < highScores.length / 2; count++)
		{
		    int temp = highScores[count];
		    highScores[count] = highScores[highScores.length - count - 1];
		    highScores[highScores.length - count - 1] = temp;
		}
		return highScores;
	}
}