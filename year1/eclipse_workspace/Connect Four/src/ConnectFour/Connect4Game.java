/* SELF ASSESSMENT

Connect4Game class (35 marks) : 35
My class creates references to the Connect 4 Grid and two Connect 4 Players. It asks the user whether he/she would like to play/quit inside a loop. If the user decides to play then: 1. Connect4Grid2DArray is created using the Connect4Grid interface, 2. the two players are initialised - must specify the type to be ConnectPlayer, and 3. the game starts. In the game, I ask the user where he/she would like to drop the piece. I perform checks by calling methods in the Connect4Grid interface. Finally a check is performed to determine a win. 
Comment: Yes it does.

Connect4Grid interface (10 marks): 10
I define all 7 methods within this interface.
Comment: Yes i do.

Connect4Grid2DArray class (25 marks) :10
My class implements the Connect4Grid interface. It creates a grid using a 2D array Implementation of the method to check whether the column to drop the piece is valid. It provides as implementation of the method to check whether the column to drop the piece is full. It provides as implementation of the method to drop the piece.  It provides as implementation of the method to check whether there is a win.
Comment: My class does implement the Connect4Grid interface. It can also check if a drop is valid and drops the piece accordingly. However, it sometimes does not recognise a win when it is vertical or diagonal.

ConnectPlayer abstract class (10 marks) : 10
My class provides at lest one non-abstract method and at least one abstract method. 
Comment: Yes it does.

C4HumanPlayer class (10 marks) : 10
My class extends the ConnectPlayer claas and overrides the abstract method(s). It provides the Human player functionality.
Comment: Yes it does

C4RandomAIPlayer class (10 marks): 10
My class extends the ConnectPlayer claas and overrides the abstract method(s). It provides AI player functionality. 
Comment: Yes it does

Total Marks out of 100:85

*/



package ConnectFour;

import java.util.Scanner;

public class Connect4Game {

	private static final int BOARD_WIDTH = 7;
	private static final int BOARD_HEIGHT = 6;
	
	public static void main(String[] args) {
		boolean restart = true;
		boolean finished = false;
		char[][] board = new char[BOARD_HEIGHT][BOARD_WIDTH];
		ConnectPlayer player1 = null;
		ConnectPlayer player2 = null;
		ConnectPlayer curPlayer = null;
		Connect4Grid grid = new Connect4Grid2DArray();
		
		do {	
			
			ConnectPlayer.currentPlayer = "Player 1";
			board = grid.emptyGrid(board);
			finished = false;
			System.out.println("Would you like to play Connect Four?(Please enter 'Yes' or 'no')");
			Scanner s = new Scanner(System.in);
			if(s.hasNext("yes") || s.hasNext("Yes") || s.hasNext("YES")) {
				
				//grid.emptyGrid();
				
				player1 = new C4HumanPlayer();
				System.out.println("Do you wish to play against a human or computer?(enter 'human' or 'computer')");
				Scanner sc = new Scanner(System.in);
				if(sc.hasNext("human")) {
				player2 = new C4HumanPlayer();
				}
				else if(sc.hasNext("computer")) {
				player2 = new C4RandomAIPlayer();
				}
				else {
					System.out.println("Invalid input.");
				}
				
			}
			else if (s.hasNext("no")) {
				System.out.println("Goodbye.");
				restart = false;
			}
			restart = false;
			while(!finished) {
				String currentPlayer = ConnectPlayer.currentPlayer;
				if(currentPlayer == "Player 1") {
					curPlayer = player1;
				}
				else if(currentPlayer == "Player 2") {
					curPlayer = player2;
				}
				
					
				System.out.println("It's "+currentPlayer+"'s turn.");
				printBoard(board);
				System.out.println("Enter column where you want to drop piece.");
				Scanner scan = new Scanner(System.in);
				int column = scan.nextInt();
				grid.dropPiece(curPlayer, column, board);
				printBoard(board);
				if(player2.getPlayerType() == "comp") {
					grid.dropPiece(player2, player2.getRandomMove(), board);
					printBoard(board);
				}
				if(grid.didLastPieceConnect4(board)) {
					System.out.println("The winner is "+Connect4Grid2DArray.winner);
					System.out.println("Do you wish to play again?");
					Scanner playSc = new Scanner(System.in);
					if(playSc.hasNext("yes")) {
						grid.emptyGrid(board);
						restart = true;
						
						
					}
					else if(playSc.hasNext("no")) {
						System.out.println("Goodbye.");
						restart = false;
						
					}
					finished = true;
					
				}
				if(grid.isGridFull(board)) {
					System.out.println("It was a draw!");
					System.out.println("Do you wish to play again?");
					Scanner playSc = new Scanner(System.in);
					if(playSc.hasNext("yes")) {
						grid.emptyGrid(board);
						restart = true;
						
						
					}
					else if(playSc.hasNext("no")) {
						System.out.println("Goodbye.");
						restart = false;
						
								
					}
					finished = true;
					
				}
				if(player2.getPlayerType() != "comp") {
					ConnectPlayer.changeCurrentPlayer();
				}
			}
		}while(restart);
			
			
			
		

	}
	
	public static void printBoard (char[][] board) { //prints board to the screen 
		 int row;
		 int column;
		 
		 

		 for (row = 0; row < BOARD_HEIGHT; row++) {
			
		     for (column = 0; column <BOARD_WIDTH; column++) {
		         System.out.print(board[row][column] + " ");
		     } 
		     
			 
		     System.out.println();
		 } 
		 System.out.println("-------------");
	     System.out.println("1 2 3 4 5 6 7");
		
		 
	}

}
