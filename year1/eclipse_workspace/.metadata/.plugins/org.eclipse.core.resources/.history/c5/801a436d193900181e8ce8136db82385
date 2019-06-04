package OrderProgram;

import java.util.ArrayList;
import java.util.Scanner;

public class Inventory {
	public static ArrayList<Item> itemList = new ArrayList<Item>();
	public static ArrayList<Order> orderList = new ArrayList<Order>();
	public static ArrayList<Shipment> shipList = new ArrayList<Shipment>();
	
	public static void main(String[] args) {
	boolean finished = false;
	do {
		System.out.println("1) Add an item to the inventory,");
		System.out.println("2) Find the quantity of a named item,");
		System.out.println("3) Create an order,");
		System.out.println("4) Print all item details,");
		System.out.println("5) Process an order,");
		System.out.println("6) Exit.");
		System.out.println("Please enter option number you wish to select:");
		Scanner optSc = new Scanner(System.in);
		int option = optSc.nextInt();
		if(option == 1) {
			System.out.println("Enter detais of item you wish to add: ");
			System.out.println("(itemId, itemName, itemPrice, itemQuantity)");
			Scanner itemSc = new Scanner(System.in);
			if(itemSc.hasNext()) {
				String detailString = itemSc.nextLine();
				String [] itemDetails = new String[4];
				itemDetails = detailString.split(", ");
				String itemId = itemDetails[0];
				String itemName = itemDetails[1];
				String p = itemDetails[2];
				double itemPrice = Double.parseDouble(p);
				String q = itemDetails[3];
				int itemQuantity = Integer.parseInt(q);
				addItemToInventory(itemId, itemName, itemPrice, itemQuantity);
				for(int i=0; i<itemList.size(); i++) {
					System.out.println(itemList.get(i).itemQuantity);
				}
			}
			else {
				System.out.println("Nothing entered.");
			}
		}
		else if(option == 2) {
			System.out.println("Enter name of item: ");
			Scanner nameSc = new Scanner(System.in);
			if(nameSc.hasNext()) {
				String itemName = nameSc.nextLine();
				int noOfItems = findItem(itemName);
				System.out.println("Quantity of "+itemName+": "+noOfItems);
			}
			else {
				System.out.println("Nothing entered.");
			}
		}
		else if(option == 3) {
			System.out.println();
		}
		else if(option == 4) {
			
		}
		else if(option == 5) {
			
		}
		else if(option == 6 || optSc.hasNext("exit")) {
			finished = true;
		}
	}while(!finished);
	}
	
	public static void addItemToInventory(String itemId, String itemName, double itemPrice, int itemQuantity) {
		Item tmpItem = new Item(itemId, itemName, itemPrice, itemQuantity);
		itemList.add(tmpItem);
	}

	public static int findItem (String itemName) {
		int amount=0;
		for(int i=0; i<itemList.size(); i++) {
			Item tmp = itemList.get(i);
			if(tmp.itemName == itemName) {
				amount += tmp.itemQuantity;
			}
		}
		return amount;
	}
	
	public static void createOrder(Item item) {
		Order tempOrder = new Order(item, orderList.size()+1);
		orderList.add(tempOrder);
	}
	
	public static void createShipment(Shipment shipment) {
		shipList.add(shipment);
		}
	
	public static void processOrder(int orderId) {
		Shipment shipment = new Shipment(orderId);
		createShipment(shipment);
	}
	
	public static void printAllItemDetails() {
		for(int i=0; i<itemList.size(); i++) {
			Item tmp = itemList.get(i);
			System.out.println("ItemId = "+tmp.itemId+", ItemName = "+tmp.itemName
					+", ItemPrice = "+tmp.itemPrice+", ItemQuantity = "+tmp.itemQuantity);
		}
	}
}
