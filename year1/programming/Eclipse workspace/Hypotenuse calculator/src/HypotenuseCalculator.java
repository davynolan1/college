import java.util.Scanner;

public class HypotenuseCalculator {

	public static void main(String[] args) {
	Scanner input = new Scanner(System.in);	
	System.out.print("What is the adjacent side in metres?");
	double adjacent = input.nextDouble();
	System.out.print("What is the opposite side in metres?");
	double opposite = input.nextDouble();
	
	double hypotenuse = Math.sqrt((adjacent*adjacent) + (opposite*opposite));
	
	System.out.println("The hypotenuse is " + hypotenuse);
		// TODO Auto-generated method stub

	}

}
