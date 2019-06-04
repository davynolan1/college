import java.util.Scanner;

public class timesTables {

	static int[][] sMatrix = {
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9},
			{1,2,3,4,5,6,7,8,9}
	};
	
	static int rSum = 0;
	static int cSum = 0;
	static int[] rSumArray = new int[9];
	static int[] cSumArray = new int[9];
	
	public static void main(String[]args) {
		for(int i =0; i<9;i++) {
			for(int j =0; j<9; j++) {
				rSum += sMatrix[i][j];
			}
			rSumArray[i] = rSum;
			System.out.println(rSum);
			rSum = 0;
			
		}
		System.out.println();
		for(int i =0; i<9;i++) {
			for(int j =0; j<9; j++) {
				cSum += sMatrix[j][i];
			}
			cSumArray[i] = cSum;
			System.out.println(cSum);
			cSum = 0;
			
		}
	}
}
