package ConnectFour;

public interface Connect4Grid {

	public void emptyGrid(char[][]board);
	public String toString(char[][]board);
	public boolean isValidColumn(int column, char[][]board);
	public boolean isColumnFull(int column, char[][]board);
	public void dropPiece(ConnectPlayer player, int column, char[][]board);
	public boolean didLastPieceConnect4(char[][]board);
	public boolean isGridFull(char[][]board);  
}