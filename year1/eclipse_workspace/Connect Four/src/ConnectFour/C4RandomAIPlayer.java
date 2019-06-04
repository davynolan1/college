package ConnectFour;

public class C4RandomAIPlayer extends ConnectPlayer{
	char playerPiece;
	int playerNumber;
	String playerType;
	
	 	public String getPlayerType() {
	        return "comp";

	    }
	    public char getPlayerPiece() {
	        return  PLAYER2_PIECE;
	    }
	    public int getPlayerNumber() {

	        return 2;
	    }
	    public String getPlayerName() {

	       return "Player 2";
	    }
}
