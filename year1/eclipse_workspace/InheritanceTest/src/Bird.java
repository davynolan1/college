
public class Bird extends Animal{
	int number = 3;
	void fly() {
		System.out.println("flying...");
	}
	void display() {
		System.out.println(super.number);
	}
	void jump() {
		System.out.println("jumping...");
	}
}
