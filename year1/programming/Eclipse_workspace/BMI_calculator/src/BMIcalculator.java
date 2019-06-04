import java.util.Scanner;

public class BMIcalculator {

	public static void main(String[] args) {
	Scanner input = new Scanner( System.in);
	System.out.print("What is your weight in kg?");
	double weight = input.nextDouble();
	System.out.print("What is your height in metres?");
	double height = input.nextDouble();
	
	double bmi = weight / (height*height);
	
	System.out.println("Your BMI is " + bmi);
		// TODO Auto-generated method stub

	}

}
