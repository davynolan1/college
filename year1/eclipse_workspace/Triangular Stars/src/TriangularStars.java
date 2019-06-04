/* SELF ASSESSMENT
 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5: 5        Comment: Yes I used meaningful variable names formatted in lowerCamelCase
         and I even changed the provided variable (n) to have a meaningful name.
 2. Did I indent the code appropriately?
        Mark out of 5: 5     Comment: Yes the I indented the code as per the specifications for this assignment.
 3. Did I write the determineStarNumber or determineTriangleNumber function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20: 20       Comment: Yes i did and i used parameters, return type and function body and declared it correctly.
 4. Did I write the isStarNumber function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20: 20      Comment: Yes i did and i used parameters, return type and function body and declared it correctly.
 5. Did I calculate and/or check triangle numbers correctly?
       Mark out of 15: 15       Comment: Yes I calculated the triangle numbers by using 2 variables called triangleNumber1
       	and triangleNumber2 and checked them with the function determineTriangleNumber().
 6. Did I loop through all possibilities in the program using system defined constants to determine when to stop?
       Mark out of 10: 10  Comment: Yes I used the system defined constant Integer.MAX_VALUE
 7. Does my program compute and print all the correct triangular star numbers?
       Mark out of 20: 20   Comment: Yes it does, with a comma and space in between each number.
 8. How well did I complete this self-assessment?
        Mark out of 5: 5    Comment: I marked myself honestly and provided comments for each mark.
 Total Mark out of 100 (Add all the previous marks): 100
*/ 

import javax.swing.JOptionPane;

public class TriangularStars {

	public static void main(String[] args) {
		
		System.out.print("The triangular star numbers are");
	
		int triangleNumber1 = -1;
		int triangleNumber2 = 0;
		
		for (int indexCount = 1; triangleNumber2 <= Integer.MAX_VALUE && triangleNumber2 > triangleNumber1; indexCount++)
		{
			triangleNumber1 = triangleNumber2;
			triangleNumber2 = determineTriangleNumber(indexCount);
			
			if (isStarNumber(triangleNumber2)) {
				System.out.print(", "+triangleNumber2);
			}
		}
	}

	public static int determineTriangleNumber(int number)
	{
		int result = 0;
		for (int indexCount = 1; indexCount <= number; indexCount++)
		{
			result += indexCount;
		}
		return result;
	}

	public static boolean isStarNumber(int number)
	{
		int starNumber = 0;
		for (int indexCount = 1; starNumber <= number; indexCount++)
		{
			starNumber = (((6*indexCount)*(indexCount-1))+1);
			if (starNumber == number)
				return (true);
		}
		return (false);
	}
}