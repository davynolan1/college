package ConnectFour;

import java.util.Random;

abstract public class ConnectPlayer {
	    public static final char PLAYER1_PIECE = 'X';
	    public static final char PLAYER2_PIECE = 'O';
	    public static String currentPlayer = "Player 1";

	   
	    
	    abstract String getPlayerType();
	    abstract char getPlayerPiece();
	    abstract int getPlayerNumber();
	    abstract String getPlayerName();
	    
	    

	    public static void changeCurrentPlayer() {
	        if(currentPlayer.equals("Player 1")) {
	            currentPlayer = "Player 2";
	        }
	        else
	            currentPlayer = "Player 1";
	    }
	    public int getRandomMove() {
	        Random rand = new Random();
	        int n = rand.nextInt(7);
	        if(n==0) {
	        	n=1;
	        }
	        return n;
	    }

	}

