/* SELF ASSESSMENT 
   1. clearBoard:
Did I use the correct method definition?
Mark out of 5: 5
Comment: Yes I used the definition provided in the assignment requirements.
Did I use loops to set each position to the BLANK character?
Mark out of 5: 5
Comment: Yes I a for loop to set each position to BLANK.
   2. printBoard
Did I use the correct method definition?
Mark out of 5: 5
Comment:  Yes i used the definition provided in the assignment requirements.
Did I loop through the array and prints out the board in a way that it looked like a board?
Mark out of 5: 5
Comment: Yes I used a for loop to do so.
   3. canMakeMove
Did I have the correct function definition and returned the correct item?
Mark out of 5: 5
Comment: Yes i used the definition provided in the assignment requirements.
Did I check if a specified location was BLANK?
Mark out of 5: 5
Comment: Yes I did.
   4. makeMove
Did I have the correct function definition?
Mark out of 5: 5
Comment: Yes i used the definition provided in the assignment requirements.
Did I set the  currentPlayerPiece in the specified location?
Mark out of 5: 5
Comment: Yes I did.
   5. isBoardFull
Did I have the correct function definition and returned the correct item?
Mark out of 5: 5
Comment:  Yes i used the definition provided in the assignment requirements and i returned a boolean.
Did I loop through the board to check if there are any BLANK characters?
Mark out of 5: 5
Comment: Yes i used a for loop to do so.
   6. winner
Did I have the correct function definition and returned the winning character
Mark out of 5: 5
Comment: Yes i used the definition provided in the assignment requirements and i returned a char.
Did I identify all possible horizontal, vertical and diagonal winners  
Mark out of 15: 15
Comment: Yes i used a series of for loops and if statements to do so.
   7.main

Did I create a board of size 3 by 3 and use the clearBoard method to set all the positions to the BLANK character ('  ')?
Mark out of 3: 3 
Comments: Yes I did.
Did I loop asking the user for a location until wither the board was full or there was a winner?
Mark out of 5: 5
Comments: Yes I did.
Did I call all of the methods above?
Mark out of 5: 5
Comments: Yes I did.
Did I handle incorrect locations provided by the user (either occupied or invalid locations)?
Mark out of 3: 3
Comments: Yes I did.
Did I switch the current player piece from cross to nought and vice versa after every valid move?
Mark out of 3: 3
Comments: Yes I did.
Did I display the winning player piece or a draw at the end of the game?
Mark out of 3: 3
Comments: Yes I did

   8. Overall
Is my code indented correctly?
Mark out of 3: 3
Comments: Yes it is.
Do my variable names and Constants (at least four of them) make sense?
Mark out of 3: 3
Comments: Yes they do.
Do my variable names, method names and class name follow the Java coding standard
Mark out of 2: 2
Comments: Yes they do.
      Total Mark out of 100 (Add all the previous marks): 100
*/

import java.util.Scanner;

public class NoughtsandCrosses {
	public static final char BLANK = ' ';
	public static final char NOUGHT = 'O';
	public static final char CROSS = 'X';
	public static final int BOARD_SIZE = 4; 
	
	public static void main(String[] args) { //gets input location on board from user until there is a winner or board is full. Calls all the methods.
		char[][] board = new char[BOARD_SIZE][BOARD_SIZE];
		clearBoard( board );
		char currentPiece = CROSS;
		
		
		boolean gameWon = false;
		int row;
		int column;
		Scanner inputScanner = new Scanner(System.in);
		
		
		while ((!isBoardFull(board)) && (winner(board) == BLANK) && (gameWon == false)) {
			System.out.println();
			System.out.println("***************");
			printBoard(board);
			
			do {
				System.out.print("Enter an X-coordinate for " + currentPiece + ": ");
				row = inputScanner.nextInt();
				System.out.print("Enter an Y-coordinate for " + currentPiece + ": ");
				column = inputScanner.nextInt();
				
				if (!canMakeMove(board,row,column)) {
					System.out.println("Coordinates invalid, please try again");
				}
				
				
			} while (!canMakeMove(board,row,column));
			makeMove(board,currentPiece,row,column);
			
			currentPiece = (currentPiece==CROSS)?NOUGHT:CROSS;
			
		}
		printBoard(board);
		if (winner(board) == BLANK) {
			
			System.out.println("It was a draw.");
			
		}
		else {
			gameWon = true;
			System.out.println("The winner was " + winner(board) +". Congratulations!");
			
		}
		inputScanner.close();

	}
	
	public static void clearBoard (char[][] board) { //sets all locations on board to BLANK ('')
		for(int index = 0; index <= 3; index++) {
			board[index][1] = BLANK;
			board[index][2] = BLANK;
			board[index][3] = BLANK;
		}
	}
	
	public static void printBoard (char[][] board) { //prints board to the screen 
		 int row;
		 int column;
		 
		 System.out.println("  | 1 2 3 ");
		 System.out.println("--+-------");

		 for (row = 1; row <= 3; row++) {
			 System.out.print(row + " | ");
		     for (column = 1; column <= 3; column++) {
		         System.out.print(board[column][row] + " ");
		     } 
		     System.out.println();
		 } 
		
		 
	}

	public static boolean canMakeMove (char[][] board, int row, int column) { //takes a board and location and returns whether a move can be made there or not
		boolean validMove = false;
		if (row > board.length || column > board.length || row == 0 || column == 0 || row == 4 || column == 4) {
			validMove = false;
		}
		if (board[row][column] == BLANK) {
			validMove = true;
		}
		return validMove;
	}

	public static void makeMove (char[][] board, char currentPiece , int row, int column) { //adds x or o to the board in specified location
		board[row][column] = currentPiece;
		
		
	}
	
	public static boolean isBoardFull(char[][] board) { //indicates if board is full
		boolean fullBoard = false;
		for(int index = 0; index <= 3; index++) {
			if(board[index][1] != BLANK && board[index][2] != BLANK && board[index][3] != BLANK) {
				fullBoard = true;
			}
		}
		return fullBoard;
	}	

	public static char winner ( char[][] board) { //returns the piece which has won or BLANK if no one has yet won
		char winPiece = BLANK ;
		int checkO = 0;
		int checkX = 0;
		for(int index = 1; index < 4; index++) {
			if (board[index][1] == 'O' ) {
				checkO++;
			}
			if (board[index][1] == 'X') {
				checkX++;
			}
		}
		
		if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	        
	    }
	    checkO = 0;
	    checkX = 0;
	    
	    for (int index = 1; index < 4; index++) {
	        if (board[index][2] == 'O') {
	            checkO++;
	        }
	        if (board[index][2] == 'X') {
	            checkX++;
	        }
	    }
	   
	    if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	    }
	    checkO = 0;
	    checkX = 0;
	    
	    for (int index = 1; index < 4; index++) {
	        if (board[index][3] == 'O') {
	            checkO++;
	        }
	        if (board[index][3] == 'X') {
	            checkX++;
	        }
	    }
	    
	    if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	    }
	    checkO = 0;
	    checkX = 0;
	    
	    for (int index = 1; index < 4; index++) {
	    	if(board[1][index] == 'O') {
	    		checkO++;
	    	}
	    	if(board[1][index] == 'X') {
	    		checkX++;
	    	}
	    }
	    
	    if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	    }
	    checkO = 0;
	    checkX = 0;
	    
	    for (int index = 1; index < 4; index++) {
	    	if(board[2][index] == 'O') {
	    		checkO++;
	    	}
	    	if(board[2][index] == 'X') {
	    		checkX++;
	    	}
	    }
	    
	    if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	    }
	    checkO = 0;
	    checkX = 0;
	    
	    for (int index = 1; index < 4; index++) {
	    	if(board[3][index] == 'O') {
	    		checkO++;
	    	}
	    	if(board[3][index] == 'X') {
	    		checkX++;
	    	}
	    }
	    
	    if (checkO == 3) {
			winPiece = 'O';
			
	    }
	    if (checkX == 3) {
	        winPiece = 'X';
	    }
	    
	    return winPiece;
		
	}
	
	
}
