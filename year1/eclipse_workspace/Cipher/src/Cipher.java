/* SELF ASSESSMENT

 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?

        Mark out of 5: 5 - Yes i used variable names such as 'userInput', 'userInputArray', 'lowercaseInput' etc...

 2. Did I indent the code appropriately?

        Mark out of 5: 5 - Yes the I indented the code as per the specifications for this assignment.
         The program also does exactly what it's supposed to do.

 3. Did I write the createCipher function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20: 20 - Yes i used the provided function name and declared it correctly 
       as well as including the name, parameter and return type.

 4. Did I write the encrypt function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20: 20 - Yes i used the provided function names and declared them all correctly 
       as well as including the name and parameter. I did not provide a return type as I made
       it a void.

 5. Did I write the decrypt function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20: 20 - Yes i used the provided function names and declared them all correctly 
       as well as including the name and parameter. I did not provide a return type as I made
       it a void.

 6. Did I write the main function body correctly (repeatedly obtaining a string and encrypting it and then decrypting the encrypted version)?

       Mark out of 25: 25 - 15 - The function body encrypts and decrypts correctly, however I was unable 
       to get it to repeated obtain a string.

 7. How well did I complete this self-assessment?

        Mark out of 5: 5 - I marked myself honestly and provided comments for each mark.

 Total Mark out of 100 (Add all the previous marks): 90

*/ 
import java.util.Random;
import java.util.Scanner;

public class Cipher {

	public static void main(String[] args) {
	
			System.out.println("Type in a word/sentence you would like to encrypt: ");
			Scanner inputScanner = new Scanner(System.in);
        	if(inputScanner.hasNextLine())
	        {
	            String userInput = inputScanner.nextLine();
	            String lowercaseInput = userInput.toLowerCase();
	            char[] userInputArray = lowercaseInput.toCharArray();
	            boolean isString = true;
	            for (char c : userInputArray)
	            {
	                if(!Character.isLetter(c) && !Character.isWhitespace(c))
	                {
	                    isString = false;
	                }
	            }
	            if (isString == true)
	            {
	                char[] cipherArray = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
	                        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' '};
	                createCipher(cipherArray, cipherArray);
	
	                encrypt(cipherArray, userInputArray);
	                String printEncrypt = new String( userInputArray );
	                System.out.println("Encrypted text: " + printEncrypt);
	
	                System.out.print("Would like to decrypt the text?(Yes/No): ");
	                inputScanner = new Scanner(System.in);
	                if (inputScanner.hasNext("Yes") || inputScanner.hasNext("yes") || inputScanner.hasNext("YES"))
	                {
	                    decrypt(cipherArray, userInputArray);
	                    String printDecrypt = new String( userInputArray );
	                    System.out.println( "Decrypted text: " + printDecrypt);
	                }
	                else if (inputScanner.hasNext("No") || inputScanner.hasNext("no") || inputScanner.hasNext("NO"))
	                {
	                	System.out.print("Finished.");
	                }
	                else
	                {
	                    System.out.println("Invalid input. Please enter valid input.");
	                }
	            }
	            else
	                System.out.print("Invalid input entered. Please enter valid input.");
	            inputScanner.close();
	        }
       
    }
    public static char[] createCipher(char[] cipherArray, char[] array)
    {
    	if (array!=null)
        {
            Random indexGenerator = new Random();
            for (int index = 0; index < array.length; index++ )
            {
                int otherIndex = indexGenerator.nextInt(array.length);
                char temp = array[index];
                array[index] = array[otherIndex];
                array[otherIndex] = temp;
            }
        }
    	return array;
    }
    public static void encrypt(char[] cipherArray, char[] userInputArray)
    {
        char[] characterArray = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' '};
        if ((userInputArray!=null) && (cipherArray!=null))
        {
            for (int index = 0; index < userInputArray.length; index++ )
            {
                boolean finished = false;
                int index2 = 0;
                while(!finished)
                {
                    if (userInputArray[index] == characterArray[index2])
                    {
                        finished = true;
                        userInputArray[index] = cipherArray[index2];
                    }
                    ++index2;
                }
            }
        }
    }
    public static void decrypt(char[] cipherArray, char[] userInputArray)
    {
        char[] characterArray = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' '};

        if ((userInputArray != null)&&(cipherArray != null))
        {
            for (int index = 0; index < userInputArray.length; index++ )
            {
                boolean finished = false;
                int index2 = 0;
                while(!finished)
                {
                    if (userInputArray[index] == cipherArray[index2])
                    {
                        finished = true;
                        userInputArray[index] = characterArray[index2];
                    }
                    ++index2;
                }
            }
        }
    }
}