
abstract class Animal {
	int number = 5;
	void eat() {
		System.out.println("eating...");
	}
	void move() {
		System.out.println("moving...");
	}
	abstract void jump();       //This means all child classes must have this method, otherwise an error will occur
	
	public static void main(String[]args) {
		Dog d = new Dog();
		Bird b = new Bird();
		Puppy p = new Puppy();
		b.display();
		System.out.println(b instanceof Bird);
//		d.eat();
//		d.move();
//		d.bark();
//		System.out.println();
//		b.eat();
//		b.move();
//		b.fly();
//		System.out.println();
//		p.eat();
//		p.move();
//		p.bark();
//		p.weep();
	}
}
