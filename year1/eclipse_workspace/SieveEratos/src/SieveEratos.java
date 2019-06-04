/* SELF ASSESSMENT 
   1. createSequence:
Did I use the correct method definition?
Mark out of 5: 5
Comment: Yes i used the method definition provided in the assignment requirements.
Did I create an array of size n (passed as the parameter) and initialise it?
Mark out of 5: 5
Comment: Yes i did 
Did I return the correct item?
Mark out of 5: 5
Comment: Yes i did
   2. crossOutMultiples
Did I use the correct method definition?
Mark out of 5: 5
Comment: Yes i used the method definition provided in the assignment requirements.
Did I ensure the parameters are not null and one of them is a valid index into the array
Mark out of 2: 2
Comment: Yes i used an if statement if(sequence != null)
Did I loop through the array using the correct multiple?
Mark out of 5: 5
Comment: Yes I did
Did I cross out correct items in the array that were not already crossed out?
Mark out of 3: 3
Comment: Yes.
   3. sieve   
Did I have the correct function definition?
Mark out of 5: 5 
Comment: Yes i used the method definition provided in the assignment requirements.
Did I make calls to other methods?
Mark out of 5: 5
Comment: Yes I did.
Did I return an array with all non-prime numbers are crossed out?
Mark out of 2: 2
Comment: Yes
   4. sequenceTostring  
Did I have the correct function definition?
Mark out of 5: 5
Comment: Yes i used the method definition provided in the assignment requirements.
Did I ensure the parameter to be used is not null?
Mark out of 3:3
Comment: Yes i used an if statement if(seq != null)
Did I Loop through the array updating the String variable with the non-crossed out numbers and the crossed numbers in brackets? 
Mark out of 10: 10
Comment:  Yes I did.  
   5. nonCrossedOutSubseqToString  
Did I have the correct function definition
Mark out of 5: 5
Comment: Yes i used the method definition provided in the assignment requirements.
Did I ensure the parameter to be used is not null?  
Mark out of 3: 3
Comment:Yes i used an if statement if(seq != null)
Did I loop through the array updating the String variable with just the non-crossed out numbers? 
Mark out of 5: 0
Comment: It prints the all the correct prime numbers except 3, it prints this as 34 for whatever reason
   6. main  
Did I ask  the user for input n and handles input errors?  
Mark out of 5: 5
Comments: Yes i did
Did I make calls to other methods (at least one)?
Mark out of 5: 5
Comment:  Yes i called 2 methods
Did I print the output as shown in the question?  
Mark out of 5: 3
Comment: It prints most of it correctly except for the last line where it prints 3 as 34
   7. Overall
Is my code indented correctly?
Mark out of 4: 2
Comments: Yes most of the code except for the nonCrossedOutSubseqToString function is indented correctly
Do my variable names make sense?
Mark out of 4: 4
Comments: Yes they do.
Do my variable names, method names and class name follow the Java coding standard
Mark out of 4: 4
Comments: Yes they do.
      Total Mark out of 100 (Add all the previous marks): 91
*/
import java.util.Scanner;

public class SieveEratos {

	public static void main(String[] args) {
		System.out.print("Enter a positive integer (whose value is at least 2)-->");
        Scanner inputScanner = new Scanner(System.in);
        int rangeInput = inputScanner.nextInt();
        if(rangeInput < 2) {
        	System.out.println("Invalid input");
        }
        else {
        	
        	int[] filteredSeq = sieve(rangeInput);
        	String displaySeq = nonCrossedOutSubseqToString(filteredSeq);
        	System.out.println(displaySeq);
        }
	}
	
	public static int[] createSequence(int rangeInput) {
		 int[] sequence = new int[rangeInput + 1];
	     for (int index = 2; index <= rangeInput; index++) {
	          sequence[index] = index;
	     }
	     return sequence;
	}
	
	public static int[] crossOutHigherMultiples(int[] sequence, int value) {
		if(sequence != null) {
			for (int index = value; value * index <= sequence.length - 1; index++) {
				if (sequence[value * index] > 0)
					sequence[value * index] = sequence[value * index] * -1;
			}
        }
		return sequence;
	}
	
	public static int[] sieve(int rangeInput) {
		 	int[] seq = createSequence(rangeInput);
	        String printSequence = sequenceToString(seq);
	        System.out.println(printSequence);
	        for (int value = 2; value * value <= rangeInput; value++) {
	            if (seq[value] > 0) {
	                seq = crossOutHigherMultiples(seq, value);
	                printSequence = sequenceToString(seq);
	                System.out.println(printSequence);
	            }
	        }
	        return seq;
	}
	
	public static String sequenceToString(int[] seq) {
		String crossSequence = "";
		if(seq!=null) {
			for(int count = 2; count <= seq.length - 1; count++) {
				int number = seq[count];
				if(number == 2) {
					crossSequence = crossSequence + count;
				}
				else if(number >= 2) {
					crossSequence = crossSequence + ", " + count;
				}
				else {
					crossSequence = crossSequence + ", [" + count + "]";
				}
			}
		}
	return crossSequence;
	}
	
	public static String nonCrossedOutSubseqToString(int[] seq) {
		String sequence2 = "";
		boolean num = true;
		if(seq!=null) {
            for (int index = 0; index <= seq.length - 1; index++) {
                int number = seq[index];
                if (seq[index] != 0)
                   
                	if(number == 2) {
                		sequence2 = sequence2 + index;
                	}
                	else if (number > 2) {
                    	sequence2 = sequence2 + ", " + index;
                    }
                    else if(num) {
                    	sequence2 = sequence2 + index;
                		num = false;
                    	
                    }
            }
		}
        return sequence2;
	}
	
}

