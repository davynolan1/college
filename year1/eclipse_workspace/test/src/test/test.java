package test;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.stream.IntStream;

public class test {
	public static void main(String[] args) {
//		ArrayList arrayList1;
//		arrayList1 = new ArrayList();
		ArrayList<String> names = new ArrayList<String>();
		
		names.add("John Smith");
		names.add("Davy Nolan");
		names.add("Billy Bob");
		names.add(1, "Joe John");
		names.add(2, "Amy Mary");
		//System.out.println(names);
		for(String i: names) {
			System.out.println(i);
		}
//		
//		for(int i=0; i<names.size();i++) {
//			System.out.println(names.get(i));
//		}
	}
	
}