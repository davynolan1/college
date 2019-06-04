/* SELF ASSESSMENT 
   1. Did I use appropriate CONSTANTS instead of numbers within the code? 
       Mark out of 5: 5 - Yes I classified the number 12 as the constant MAX_DAYS.
   2. Did I use easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE? 
       Mark out of 5: 5 - Yes, MAX_DAYS.
   3. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)? 
       Mark out of 10: 10 - Yes, I used the variable dayCount.
   4. Did I indent the code appropriately? 
       Mark out of 10: 10 - Yes the I indented the code as per the specifications for this assignment. The program also does exactly what it's supposed to do.
   5. Did I use an appropriate loop (or loops) to produce the different verses? 
       Mark out of 20:  20 - Yes, I used a for-loop
   6. Did I use a switch to build up the verses? 
       Mark out of 25:  25 - Yes i used two switch statements.
   7. Did I avoid duplication of code and of the lines which make up the verses (each line should be referred to in the code only once (or twice))? 
       Mark out of 10:  10 - Yes, each line is only referred to only once.
   8. Does the program produce the correct output? 
       Mark out of 10:  10 - Yes, the program produces all the verses for "Twelve Days of Christmas" with each line having its own line and spaces between verses.
   9. How well did I complete this self-assessment? 
       Mark out of 5: 5 - I marked myself honestly and provided comments for each mark.
   Total Mark out of 100 (Add all the previous marks): 100 
*/
public class DaysOfXmas {
	
	public static final int MAX_DAYS = 12;
	
	public static void main(String[] args) {
		
		for(int dayCount = 1; dayCount <= MAX_DAYS; dayCount++) {
			System.out.print("On the ");
			switch(dayCount) {
			case 1: 
				System.out.print("first");
				break;
			case 2: 
				System.out.print("second");
				break;
			case 3: 
				System.out.print("third");
				break;
			case 4: 
				System.out.print("fourth");
				break;
			case 5: 
				System.out.print("fifth");
				break;
			case 6: 
				System.out.print("sixth");
				break;
			case 7: 
				System.out.print("seventh");
				break;
			case 8: 
				System.out.print("eighth");
				break;
			case 9: 
				System.out.print("ninth");
				break;
			case 10: 
				System.out.print("tenth");
				break;
			case 11: 
				System.out.print("eleventh");
				break;
			case 12: 
				System.out.print("twelfth");
				break;
			default:
				break;
			}
			System.out.println(" day of Christmas, ");
			System.out.println("my true love sent to me:");
			switch(dayCount) {
			case 12: System.out.println("twelve drummers drumming, ");
			case 11: System.out.println("eleven pipers piping, ");
			case 10: System.out.println("ten lords a leaping, ");
			case 9: System.out.println("nine ladies dancing, ");
			case 8: System.out.println("eight maids a milking, ");
			case 7: System.out.println("seven swans a swimming, ");
			case 6: System.out.println("six geese a laying, ");
			case 5: System.out.println("five gold rings,");
			case 4: System.out.println("four calling birds, ");
			case 3: System.out.println("three french hens, ");
			case 2: System.out.println("two turtle doves and ");
			case 1: System.out.println("a partridge in a pear tree.");
			}
			System.out.println();
		}
	}
}