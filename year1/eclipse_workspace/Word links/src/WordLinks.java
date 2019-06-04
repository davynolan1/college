/* SELF ASSESSMENT 

1. readDictionary
- I have the correct method definition [Mark out of 5: 5] 
- Comment: Yes I used the definition provided in the assignment requirements.
- My method reads the words from the "words.txt" file. [Mark out of 5: 5]
- Comment: Yes it does.
- It returns the contents from "words.txt" in a String array or an ArrayList. [Mark out of 5: 5]
- Comment: Yes it returns the contents in a String array.

2. readWordList
- I have the correct method definition [Mark out of 5: 5]
- Comment: Yes I used the definition provided in the assignment requirements.
- My method reads the words provided (which are separated by commas, saves them to an array or ArrayList of String references and returns it. [Mark out of 5: 5]
- Comment: Yes it does and it saves them to an array of String reference and returns it.

3. isUniqueList
- I have the correct method definition [Mark out of 5: 5]
- Comment: Yes I used the definition provided in the assignment requirements.
- My method compares each word in the array with the rest of the words in the list. [Mark out of 5: 5]
- Comment: Yes it does.
- Exits the loop when a non-unique word is found. [Mark out of 5: 5]
- Comment: Yes it does.
- Returns true if all the words are unique and false otherwise. [Mark out of 5: 5]
- Comment: Yes it does.

4. isEnglishWord
- I have the correct method definition [Mark out of 5: 5]
- Comment: Yes I used the definition provided in the assignment requirements.
- My method uses the binarySearch method in Arrays library class. [Mark out of 3: 3]
- Comment: Yes it does.
- Returns true if the binarySearch method return a value >= 0, otherwise false is returned. [Mark out of 2: 2]
- Comment: Yes it does.

5. isDifferentByOne
- I have the correct method definition [Mark out of 5: 5]
- Comment: Yes I used the definition provided in the assignment requirements.
- My method loops through the length of a words comparing characters at the same position in both words searching for one difference. [Mark out of 10:]
- Comment: Yes it does and it uses a for loop to do so.

6. isWordChain
- I have the correct method definition [Mark out of 5: 5]
- Comment: Yes I used the definition provided in the assignment requirements.
- My method calls isUniqueList, isEnglishWord and isDifferentByOne methods and prints the appropriate message [Mark out of 10: 10]
- Comment: Yes it does call these three methods and prints appropriate message.

7. main
- Reads all the words from file words.txt into an array or an ArrayList using the any of the Java.IO classes covered in lectures [Mark out of 10: 10]
- Comment: Yes it calls the readDictionary function to do so.
- Asks the user for input and calls isWordChain [Mark out of 5: 5]
- Comment: Yes it does.

 Total Mark out of 100 (Add all the previous marks): 100
*/
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static java.util.Arrays.binarySearch;

import java.io.*;



public class WordLinks {

	public static void main(String[] args) throws Exception  {
		
		
		String[] dictionary;
		dictionary = readDictionary();
		boolean finished = false;
		do {
			System.out.println("*********************************************************************************");
			System.out.println("Enter a comma (, ) and space separated list of words (or an empty list to quit)->");
			Scanner inputScanner = new Scanner(System.in);
			String wordInput;
			if(inputScanner.hasNextLine()) {
				wordInput = inputScanner.nextLine();
			}
			else {
				wordInput = "";
			}
			if(!wordInput.isEmpty()) {
				String[] wordLink = readWordList(wordInput);
				if(isWordChain(wordLink, dictionary)) {
					System.out.println("Valid chain of words from Lewis Carroll's word-links game.");
					System.out.println();
				}
				else{
					System.out.println("Not a valid chain of words from Lewis Carroll's word-links game.");
				}
			
			}
			else if(wordInput.isEmpty()) {
				finished = true;
				System.out.println("Finished.");
			}
			else {
				System.out.println("Invalid input. Try again.");
			}
		}while(!finished);
		

	}

	public static String[] readDictionary() throws Exception {
		//****You have to change the file location depending on where it is on your PC.****
		FileReader fileReader = new FileReader("C:\\Users\\Davy\\Documents\\My Documents\\Eclipse Workspace\\Word links\\src\\words.txt");
         
	        BufferedReader bufferedReader = new BufferedReader(fileReader);
	        List<String> lines = new ArrayList<String>();
	        String line = null;
	         
	        while ((line = bufferedReader.readLine()) != null) 
	        {
	            lines.add(line);
	        }
	         
	        bufferedReader.close();
	         
	        return lines.toArray(new String[lines.size()]);
	}
	
	public static String[] readWordList(String wordInput) {
		String[] splitWords = wordInput.split(", ");
		for(int i = 0; i < splitWords.length; i++) {
			splitWords[i] = splitWords[i].replaceAll(",", "");
		}
		return splitWords;
	}
	
	public static boolean isUniqueList(String[] wordLink) {
		boolean isUnique = true;
		for(int i = 0; i < wordLink.length - 1 ; i++) {
			for(int j = i+1; j < wordLink.length; j++) {
				isUnique = !wordLink[i].equals(wordLink[j]);
				if(isUnique==false) {
					return false;
				}
			
			}
			return isUnique;
		}
		return false;
	}
	
	public static boolean isEnglishWord(String word, String[] dictionary) {
		int dictionarySearch = binarySearch(dictionary, word);
		if(dictionarySearch>0)
				return true;
		return false;
	}
	
	public static boolean isDifferentByOne(String firstWord, String secondWord) {
		
		char[] one = firstWord.toLowerCase().toCharArray();
		char[] two = secondWord.toLowerCase().toCharArray();
		if(one.length != two.length)
			return false;
		int difCount = 0;
		for(int i = 0; i < one.length; i++) {
			if (one[i] != two[i]) {
				difCount++;
			}
		}
		if(difCount == 1)
			return true;
		return false;
	}
	
	public static boolean isWordChain(String[] wordLink, String[] dictionary) {
		if(isUniqueList(wordLink)) {
			boolean legitWord = true;
			for(int i = 0; i < wordLink.length; i++) {
				legitWord = isEnglishWord(wordLink[i], dictionary);
				if(legitWord == false)
					return false;
			}
			boolean difByOne = true;
			for(int j = 0; j < wordLink.length - 1; j++) {
				difByOne = isDifferentByOne(wordLink[j], wordLink[j+1]);
				if(!difByOne)
					return false;
			}
			return true;
		}
		return false;
	}
}