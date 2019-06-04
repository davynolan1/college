package ConnectFour;

public class C4HumanPlayer extends ConnectPlayer {
	 char playerPiece;
	 int playerNumber;
	 String playerType;
	
	 	public String getPlayerType() {
	        return "human";

	    }
	    public char getPlayerPiece() {
	    	if(currentPlayer == "Player 2") {
	    		return PLAYER2_PIECE;
	    	}
	    	
	    	return  PLAYER1_PIECE;
	    }
	    public int getPlayerNumber() {

	        if(currentPlayer.equals("Player 1")) {
	            return 1;
	        }
	        else
	            return 2;
	    }
	    public String getPlayerName() {

	        if(currentPlayer.equals("Player 1")) {
	            return "Player 1";
	        }
	        else
	            return "Player 2";
	    }

	    
}
