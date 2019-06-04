package ClimbingClub;

public class Harness {
	public static final int MAX_USES = 25;
	
	public String make;
	public String modelNumber;
	private int timesUsed;
	public String instructorName;
	public boolean onLoan;
	public String memberName;
	
	
	
	public Harness(String make, String modelNumber, int timesUsed, String instructorName,
			boolean onLoan, String memberName) {
		this.make = make;
		this.modelNumber = modelNumber;
		this.timesUsed = timesUsed;
		this.instructorName = instructorName;
		this.onLoan = onLoan;
		this.memberName = memberName;
	}
	public Harness(String make, String modelNumber, String instructorName) {
		this.make = make;
		this.modelNumber = modelNumber;
		this.timesUsed = 0;
		this.instructorName = instructorName;
		this.onLoan = false;
		this.memberName = "";
	}
	
	public boolean checkHarness(String instructorName) {
		this.timesUsed = 0;
		this.instructorName = instructorName;
		return true;
	}
	
	public boolean isHarnessOnLoan() {
		if(this.onLoan == true) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public boolean canHarnessBeLoaned() {
		if(this.onLoan == false && this.timesUsed < MAX_USES) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public void loanHarness(String memberName) {
		if(canHarnessBeLoaned()) {
			this.memberName = memberName;
			this.timesUsed++;
			this.onLoan = true;
		}
	}
	
	public void returnHarness() {
		if(isHarnessOnLoan()) {
			this.onLoan = false;
			this.memberName = "";
		}
	}
	
	public String toString() {
		String loan;
		if(onLoan == true) {
			loan = "This harness is on loan to "+this.memberName;
		}
		else {
			loan = "This harness is currently not on loan";
		}
		return "Harness [make=" + this.make + ", modelNumber=" + this.modelNumber + ", timesUsed=" + this.timesUsed
				+ ", instructorName=" + this.instructorName +". "+ loan+"]";
	}
}
