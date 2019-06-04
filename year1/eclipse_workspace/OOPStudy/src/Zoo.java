
public class Zoo {
	public static void main(String[] args) {
		Animal animal1 = new Animal(12, "M", 23);
		animal1.eat();
		
		Bird bird1 = new Bird(5, "M", 23);
		bird1.fly();
		bird1.eat();
	}
}
