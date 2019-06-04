import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class ClubManager {
	public static final int NAME_INDEX = 0;
	public static final int ADDRESS_INDEX = 1;
	public static final int YEAR_OF_REG_INDEX = 2;
	public static final int EMAIL_INDEX = 3;
	
	public static void main(String[] args) {
		ArrayList<ClubMember> clubMemberList = new ArrayList<ClubMember>();
		ArrayList<Group> groupList = new ArrayList<Group>();
		
		try {
			FileReader fr = new FileReader("members.txt");
			BufferedReader br = new BufferedReader(br);
			boolean endOfFile = false;
			while(!endOfFile) {
				String member = br.readLine();
				if(member!=null) {
					String[] membersList = member.split(", ");
					String name = membersList[NAME_INDEX];
					String address = membersList[ADDRESS_INDEX];
					int yearOfRegistration = Integer.parseInt(membersList[YEAR_OF_REG_INDEX]);
					String email = membersList[EMAIL_INDEX];
					ClubMember clubMember = new ClubMember(name, address, yearOfRegistration, email);
					clubMemberList.add(clubMember);
					
							
				}
				else {
					endOfFile = true;
				}
			}
			br.close();
			fr.close();
					
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		boolean exit = false;
		Scanner userInput = new Scanner(System.in);
		while(!exit) {
			System.out.println("Please select 1 to create a group, 2 to view club members, 3 to view details of a member.....");
			
			//Create a group
			String groupDescription = "spinning";
			int groupId = 5;
			Group group = manager.CreateGroup(groupId, groupDescription);
			groupList.add(group);
			
			//user has selected to view club members by name
			manager.printMembers(clubMemberList);
			
			//user has selected change user address or email
			String membersName = "Jack";
			String address = "Joly theatre, TCD";
			String email = null;
			ClubMember member = manager.getMember(clubMemberList, membersName);
			manager.updateMember(member, address, email);
			
			//
		}
		
		
		
		
		
		
		ClubManager manager = new ClubManager();
		manager.printMembers(clubMemberList);
		Scanner input = new Scanner(System.in);
		System.out.println("Enter the name of the member to print his/her membership details");
		if(input.hasNext()) {
			String name = input.next();
			System.out.println(manager.getMember(clubMemberList, name));
		}
		input.close();
		
	}
	
	public void printMembers(ArrayList<ClubMember> clubMemberList) {
		String clubMemberNames = "Names of members of the club are: ";
		for(int i = 0; i<clubMemberList.size(); i++) {
			clubMemberNames += clubMemberList.get(i).getName() + ", ";
			
		}
		System.out.println(clubMemberNames.substring(0, clubMemberNames.lastindex));
	}
	
	public ClubMember getMember(ArrayList<ClubMember> clubMemberList, String name) {
		boolean memberFound = false;
		int counter = 0;
		ClubMember member = null;
		while(!memberFound && counter < clubMemberList.size()) {
			member = clubMemberList.get(counter);
			if (name.equals(clubMemberList.get(counter).getName())) {
				memberFound = true;
			}
			else {
				counter++;
				member = null;
			}
		}
		return member;
	}
	
	public void updateMember(ClubMember member, String address, String email) {
		if(member!= null) {
			if(address != null && email!=null) {
				member.setAddress(address);
				member.setEmail(email);
				
			}
			else if(address!= null) {
				member.setEmail(email);
			}
			else {
				member.setAddress(address);
			}
		}
	}
	
	public Group CreateGroup(int groupId, String groupDescription) {
		Group clubGroup = new Group(groupId, groupDescription, new ArrayList<ClubMember>());
		return clubGroup;
	}
	
	public void addMemberToGroup(Group group, ClubMember member) {
		ArrayList <ClubMember> groupMembers = group.getGroupMembers();
		boolean memberFound = false;
		int counter = 0;
		while(!memberFound && counter < groupMembers.size()) {
			if(groupMembers.get(counter).getName().equals(member.getName())) {
				memberFound = true;
			}
			else {
				counter++;
			}
			
		}
		if(!memberFound) {
			groupMembers.add(member);
		}
	}
	
	public void printGroupMembers(Group group) {
		ArrayList<ClubMember> membersList = group.getGroupMembers();
		if(membersList!=null && membersList.size() > 0) {
			System.out.println("Members of group "+group.getGroupDescription() +"are: ");
			for(ClubMember member: membersList) {
				System.out.println(member.getName());
			}
		}
	}
	
	public void printGroupNamesAndNumberOfMembers(ArrayList<Group> groupList) {
		if(groupList!=null && groupList.size() >0) {
			for(Group group:groupList) {
				System.out.println("Group Description: "+group.getGroupDescription +);
			}
		}
		
	}
	
	
	
}
