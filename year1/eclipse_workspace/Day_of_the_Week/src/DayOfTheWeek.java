/* SELF ASSESSMENT
 1. Did I use appropriate, easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE?
        Mark out of 5: 5 - Yes I used easy to understand constant names in uppercase to 
        declare the numbers of days in months and the number of months in a year.
 2. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5: 5 - Yes I used meaningful variable names formatted in lowerCamelCase
         and I even changed the provided variables (Y, y, x, w) to have meaningful names.
 3. Did I indent the code appropriately?
        Mark out of 5: 5 - Yes the I indented the code as per the specifications for this assignment.
         The program also does exactly what it's supposed to do.
 4. Did I define the required function correctly (names, parameters & return type) and invoke them correctly?
       Mark out of 20: 20 - Yes i used the provided function names and declared them all correctly 
       aswell as including the names, parameters and return type.
 5. Did I implement the dayOfTheWeek function correctly and in a manner that can be understood?
       Mark out of 20: 20 - Yes, I changed all the given variable names (Y, y, x, w) to meaningful
        names to let te reader easily understand what I'm doing.
 6. Did I implement the other functions correctly, giving credit for any code that you take from elsewhere?
       Mark out of 20: Yes, all the other functions do exactly as there supposed to do and I give 
       credit to the ValidDate.java program from blackboard to make the program do error handling correctly.
 7. Did I obtain (and process) the input from the user in the correct format (dd/mm/yyyy), and deal with any invalid input properly?       
 	   Mark out of 10: 10 - Yes I used a delimiter in order for the user to accept an input in that form.
 8. Does the program produce the output in the correct format (e.g. Monday, 25th December 2017)?
       Mark out of 10: 10 - Yes it produces the output in the format "Monday, 25th of December, 2017"
 9. How well did I complete this self-assessment?
        Mark out of 5: 5 - I marked myself honestly and provided comments for each mark.
 Total Mark out of 100 (Add all the previous marks): 100
*/ 
import java.util.Scanner;

import javax.swing.JOptionPane;

public class DayOfTheWeek {
	
	public static final int DAYS_IN_APRIL_JUNE_SEPT_NOV = 30;
	public static final int DAYS_IN_FEBRUARY_NORMALLY = 28;
	public static final int DAYS_IN_FEBRUARY_IN_LEAP_YEAR = 29;
	public static final int DAYS_IN_MOST_MONTHS = 31;
	public static final int NUMBER_OF_MONTHS = 12;
	public static void main(String[] args) {
		
		try
		{
			String input = JOptionPane.showInputDialog("Enter date (day/month/year):");
			Scanner scanner = new Scanner( input );
			scanner.useDelimiter("/");
			int day = scanner.nextInt();
			int month = scanner.nextInt();
			int year = scanner.nextInt();

			if (validDate( day, month, year))
			{
				JOptionPane.showMessageDialog(null, (dayOfTheWeek(day, month, year)) +
						", " + day + (numberEnding(day)) + " of " + (monthName(month)) + ", " + year);
			}
			else
			{
				JOptionPane.showMessageDialog(null, "" + day + "/" + month + "/" + year + " is not a valid date.",
						"Error", JOptionPane.ERROR_MESSAGE);
			}
		}
		catch (NullPointerException exception)
		{
		}
		catch (java.util.NoSuchElementException exception)
		{
			JOptionPane.showMessageDialog(null, "No number entered.",
					"Error", JOptionPane.ERROR_MESSAGE);
		}
	}

	public static String numberEnding(int day) {
		String numberEnding = "";
		switch (day)
		{
		case 1: numberEnding = "st";
				break;
		case 2: numberEnding = "nd";
				break;
		case 3: numberEnding = "rd";
				break;
		case 21: numberEnding = "st";
				 break;
		case 22: numberEnding = "nd";
				 break;
		case 23: numberEnding = "rd";
			     break;
		case 31: numberEnding = "st";
				 break;
		default: numberEnding = "th";
				 break;
		}
		return (numberEnding);
		
	}
	public static String monthName (int month) {
		String monthName = "";
		switch (month)
		{
		case 1: monthName = "January";
				break;
		case 2: monthName = "February";
				break;
		case 3: monthName = "March";
				break;
		case 4: monthName = "April";
				break;
		case 5: monthName = "May";
				break;
		case 6: monthName = "June";
				break;
		case 7: monthName = "July";
				break;
		case 8: monthName = "August";
				break;
		case 9: monthName = "September";
				break;
		case 10: monthName = "October";
				 break;
		case 11: monthName = "November";
				 break;
		case 12: monthName = "December";
				 break;
		}
		return (monthName);
	}
	
	public static String dayOfTheWeek(int day, int month, int year) {
		int yearNumber = year;
		if (month == 1 || month == 2) {
			yearNumber = year - 1;
		}
		double lastTwoDigits = yearNumber % 100;
		int firstTwoDigits = yearNumber / 100;
		int dayName = (int) ((day + Math.floor(2.6*(((month+9)%12)+1)-0.2) +lastTwoDigits
				+Math.floor(lastTwoDigits/4)+Math.floor(firstTwoDigits/4)-(2*firstTwoDigits))%7);
		if (dayName < 0) {
			dayName = dayName+7;
		}
	
		String dayOfTheWeek = "";
		switch(dayName){
		
			case 0: dayOfTheWeek = "Sunday";
					break;
			case 1: dayOfTheWeek = "Monday";
					break;
			case 2: dayOfTheWeek = "Tuesday";
					break;
			case 3: dayOfTheWeek = "Wednesday";
					break;
			case 4: dayOfTheWeek = "Thursday";
					break;
			case 5: dayOfTheWeek = "Friday";
					break;
			case 6: dayOfTheWeek = "Saturday";
					break;
			default:
					break;
		}
		return (dayOfTheWeek);
	}
	
	private static boolean validDate(int day, int month, int year) {
		return ((year >= 0) && (month >= 1) && (month <= NUMBER_OF_MONTHS) &&
				(day >= 1) && (day <= daysInMonth( month, year )));
		
	}

	private static int daysInMonth(int month, int year) {
		int numberOfDaysInMonth = DAYS_IN_MOST_MONTHS;
		switch (month)
		{
		case 2:
			numberOfDaysInMonth = isLeapYear( year ) ? DAYS_IN_FEBRUARY_IN_LEAP_YEAR :
				                                       DAYS_IN_FEBRUARY_NORMALLY;
			break;
		case 4:
		case 6:
		case 9:
		case 11:
			numberOfDaysInMonth = DAYS_IN_APRIL_JUNE_SEPT_NOV;
			break;
		default:
			numberOfDaysInMonth = DAYS_IN_MOST_MONTHS;
			break;
		}
		return numberOfDaysInMonth;
	}

	private static boolean isLeapYear(int year) {
		return (((year%4 == 0) && (year%100 != 0)) || (year%400 == 0));
	}
}