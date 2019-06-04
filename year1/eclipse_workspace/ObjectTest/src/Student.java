
public class Student {
	
	int id;
	String name;
	int age;
	Student(int idNum, String studentName){
		id = idNum;
		name = studentName;
	}
	
	
	Student(int idNum, String studentName, int studentAge){
		id = idNum;
		name = studentName;
		age = studentAge;
	}
	
	void display() {
		System.out.println(id + " " + name + " " + age);
	}
	
	public static void main(String args[]) {
		Student s1 = new Student(123456,"Davy Nolan");
		Student s2 = new Student(654321,"Daniel Nolan", 19);
		s1.display();
		s2.display();
	}
}
