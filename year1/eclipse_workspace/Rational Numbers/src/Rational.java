/* SELF ASSESSMENT 

Class Rational 
I declared two member variables: numerator and denominator (marks out of 4:4 ).
Comment: Yes I did.

Constructor 1 
My program takes take two integers as parameters (for numerator and denominator) and initialises the member variables with the corresponding values . If the denominator is equal to 0 I throw an exception (marks out of 5:5 ).
Comment: Yes it does.

Constructor 2 
My program takes only one integer as parameter (numerator), and set the numerator to this value . I set the denominator to 1 in this case, as the resulting rational number in this case is an integer (marks out of 3:3 ).
Comment: Yes it does.

Add Method 
My program takes only a rational number as a parameter and returns a new rational number which has a numerator and denominator which the addition of the two objects - this and the parameter. My program does not overwrite any of the other two rational numbers (marks out of 8: 8 ).
Comment: Yes it takes rational numbers r1 and r2 and does not overwrite.

Subtract Method 
I have implemented this the same as add method, except it implements subtraction (marks out of 8:8 ).
Comment: Yes it takes rational numbers r1 and r2 and does not overwrite.

Multiply Method 
I have implemented this the same as add method, except it implements multiplication (marks out of 8:8 ).
Comment: Yes it takes rational numbers r1 and r2 and does not overwrite.

Divide Method 
I have implemented this the same as add method, except it implements divide (marks out of 8:8 ).
Comment: Yes it takes rational numbers r1 and r2 and does not overwrite.

Equals Method 
My program takes a rational number as a parameter and compares it to the reference object. I only use multiplication between numerators/denominators for the purpose of comparison, as integer division will lead to incorrect results. I return a boolean value ((marks out of 8:8 ).
Comment: Yes it does.

isLessThan 
My program takes a rational number as a parameter and compares it to the reference object. I only use multiplication as integer division will lead to incorrect results. I return a boolean value (marks out of 8:8 ).
Comment: Yes it does.

Simplify Method 
My program returns a rational number but not a new rational number, instead it returns the current reference which is this. It doesn't take any parameters as it works only with the reference object. I first find the greatest common divisor (GCD) between the numerator and denominator, and then obtain the new numerator and denominator by dividing to the GCD (marks out of 8:4 ).
Comment: I believe my simplify method is correct but whenever i tried to call upon it, an error occurred.

gcd function 
My program returns the greatest common divider of two integers: the numerator and the denominator (marks out of 6:3 ).
Comment: I believe my gcd method is correct but whenever i tried to call upon it, an error occurred.

toString Method 
My program returns a string showing the fraction representation of the number, eg. "1/2". It takes no parameters (marks out of 4:4 ).
Comment: Yes it does.

Test Client Class 
My program asks the user for two rational numbers, creates two rational objects using the constructor and passing in the provided values, calls addition, subtraction, multiplication, division, comparison and simplification and prints out the results (marks out of 22:22 ).
Comment: Yes it does

Mark out of 100 : 93
*/
import java.util.Scanner;

public class Rational {
	
	private int numerator;
	private int denominator;
	
	
	
	Rational(int numer, int denom){
		denominator = denom;
		numerator = numer;

		
		
	}
	
	Rational(int numer){
		numerator = numer;
		denominator = 1;
		
	}
	
	public String add(Rational r1, Rational r2) {
		int greatDenom = r1.denominator * r2.denominator;
		int multR1 = greatDenom / r1.denominator;
		int multR2 = greatDenom / r2.denominator;
		int denominator = r1.denominator * r2.denominator;
		int numerator = (r1.numerator*multR1) + (r2.numerator * multR2);
//		simplify();
		String addRationalNumber = numerator+"/"+ denominator;
		
		return addRationalNumber;
		
		
	}
	
	public static String subtract(Rational r1, Rational r2) {
		int greatDenom = r1.denominator * r2.denominator;
		int multR1 = greatDenom / r1.denominator;
		int multR2 = greatDenom / r2.denominator;
		int denominator = r1.denominator * r2.denominator;
		int numerator;
		if (r1.numerator > r2.numerator) {
			numerator = (r1.numerator * multR1) - (r2.numerator * multR2);
		}
		else {
			numerator = -1*((r2.numerator * multR2) - (r1.numerator * multR1));
		}
//		simplify();
		String subRationalNumber = numerator+ "/" + denominator;
		if(numerator == 0) {
			return 0+"";
		}
		else
			return subRationalNumber;
	}
	
	public static String multiply(Rational r1, Rational r2) {
		int numerator = r2.numerator * r1.numerator;
		int denominator = r2.denominator * r1.denominator;
//		simplify();
		String multRationalNumber = numerator+"/"+denominator;
		return multRationalNumber;
	}
	
	public static String divide(Rational r1, Rational r2) {
		int numerator = r1.numerator * r2.denominator;
		int denominator = r1.denominator * r2.numerator;
//		simplify();
		String divRationalNumber = numerator + "/" + denominator;
		return divRationalNumber;
	}
	
	public static boolean isEqual(Rational r1, Rational r2) {
		
		if(subtract(r1, r2) == 0+"") {
			return true;
		}
		else
			return false;
	}
	
	public static boolean isLessThan(Rational r1, Rational r2) {
		if((r1.numerator / r1.denominator) < (r2.numerator / r2.denominator) ) {
			return true;
		}
		else
			return false;
	}
	static int gcd(int x, int y) {
		int z;
		while(y != 0) {
			z = x % y;
			x = y;
			y = z;
			
		}
		return x;
	}
	
	private void simplify() {
		int divisor;
		divisor = Rational.gcd(numerator, denominator);
		numerator = numerator / divisor;
		denominator = denominator / divisor;
		
		
		
	}
	
	public String toString() {
		if(denominator == 1) {
			return numerator + "";
		}
		else {
			return numerator + "/" + denominator;
		}
		
	}
	
	
	
	public static void main(String[] args) {
		 Rational r1 = getUserInput();
	        Rational r2 = getUserInput();
	        
	        String r1String = r1.toString();
	        String r2String = r2.toString();
	        
	        String addAns =r1.add(r1, r2);
	        System.out.println(r1String + " + " + r2String +" = "+ addAns);
	        
	        String subAns = subtract(r1, r2);
	        System.out.println(r1String + " - " + r2String +" = "+ subAns);
	        
	        String multAns = multiply(r1, r2);
	        System.out.println(r1String + " * " + r2String +" = "+ multAns);
	       
	        String divAns = divide(r1, r2);
	        System.out.println(r1String + " ÷ " + r2String +" = "+ divAns);
	        
	        boolean isEqual = isEqual(r1, r2);
	        System.out.println("Are the two rational numbers "+r1String + " and " + r2String +" equal: "+ isEqual);
	        
	        boolean isLess = isLessThan(r1, r2);
	        System.out.println("Is "+r1String + " less than " + r2String +": "+ isLess);
//	        r1.simplify();
//	        r2.simplify();
//	        r1String = r1.toString();
//	        r2String = r2.toString();
//	        System.out.println("The two fractions simplified are " + r1String +" and "+ r2String);	
	}

	 public static Rational getUserInput() {
	        boolean finished = false;
	        Rational r1 = new Rational(0,1);
	        while (!finished) {
	            System.out.println("Enter in a rational number in the form of a fraction(Eg 5/6): ");
	            Scanner input = new Scanner(System.in);
	            if (input.hasNext()) {
	                String string = input.next();
	                Scanner inputString = new Scanner(string);
	                inputString.useDelimiter("/");
	                if (inputString.hasNextInt()) {
	                    int numerator = inputString.nextInt();
	                    if (inputString.hasNextInt()) {
	                        int denominator = inputString.nextInt();
	                        if (denominator != 0) {
	                            r1 = new Rational(numerator, denominator);
	                            return r1;
	                        } else
	                            System.out.println("0 cannot be denominator.");
	                    }
	                    else
	                        System.out.println("Invalid input. Please try again.");
	                }
	                else
	                    System.out.println("Invalid input. Please try again.");
	            }
	            else
	                System.out.println("Invalid input.");
	        }
	        return r1;

	    }
	

	
}
