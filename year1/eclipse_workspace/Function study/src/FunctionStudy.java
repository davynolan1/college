import java.util.Scanner;

public class FunctionStudy {

	public static void main(String[] args) {
		System.out.println("Enter age");
		Scanner inputScanner = new Scanner(System.in);
		int age = inputScanner.nextInt();
		String result = MinorOrAdult(age);
		System.out.println("This age is a " + result);

	}
	public static String MinorOrAdult(int age) {
		if (age >= 18)
		{
			return "Adult";
		}
		else
		{
			return "Minor";
		}
	}
}
