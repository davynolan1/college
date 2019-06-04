package ClimbingClub;


import java.util.ArrayList;

public class HarnessRecords {
	private ArrayList<Harness> harnessList;
	
		
	public HarnessRecords() {
		harnessList = new ArrayList<Harness>();
	}
	
	public HarnessRecords(int numOfHarnesses, String[] make, String[] modelNumber, 
			int[] timesUsed, String[] instructorName, boolean[] onLoan, String[] memberName) {
		for(int i=0; i<numOfHarnesses; i++) {
			Harness tempHarness = new Harness(make[i], modelNumber[i], instructorName[i]);
			harnessList.add(tempHarness);
		}
	}
	
	
	public boolean isEmpty() {
		if(harnessList.isEmpty()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public void addHarness(Harness currentHarness) {
		harnessList.add(currentHarness);
	}
	
	public Harness findHarness(String make, String modelNumber) {
		for(int i=0; i<harnessList.size(); i++) {
			if(harnessList.get(i).make == make && harnessList.get(i).modelNumber == modelNumber) {
				return harnessList.get(i);
			}
		}
		return null;
	}
	
	public Harness checkHarness(String instructorName, String make, String modelNumber) {
		Harness myHarness = findHarness(make, modelNumber);
		if(myHarness != null && !myHarness.onLoan ) {
			myHarness.checkHarness(instructorName);
			return myHarness;
		}
		return null;
	}
	
	public Harness loanHarness(String memberName) {
		for(int i=0; i<harnessList.size(); i++) {
			if(!harnessList.get(i).isHarnessOnLoan()) {
				harnessList.get(i).loanHarness(memberName);
				return harnessList.get(i);
			}
		}
		return null;
	}
	
	public Harness returnHarness(String make, String modelNumber) {
		Harness temp = findHarness(make, modelNumber);
		if(temp != null && temp.isHarnessOnLoan()) {
			temp.returnHarness();
			return temp;
		}
		return null;
	}
	
	public Harness removeHarness(String make, String modelNumber) {
		Harness tmp = findHarness(make, modelNumber);
		if(tmp != null) {
			harnessList.remove(tmp);
			return tmp;
		}
		return null;
	}
}
