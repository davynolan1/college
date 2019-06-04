package testttt;
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
public class testttt {

	public static void main(String[] args) throws Exception {
		
		Scanner s = new Scanner(new File("C:\\Users\\Davy\\Documents\\My Documents\\Eclipse Workspace\\Word links\\src\\words.txt"));
		ArrayList<String> list = new ArrayList<String>();
		while (s.hasNext()){
		    list.add(s.next());
		}
		s.close();
		for(int i = 1; i < 658964; i++) {
			System.out.println(list);
		}
		
	}
}
