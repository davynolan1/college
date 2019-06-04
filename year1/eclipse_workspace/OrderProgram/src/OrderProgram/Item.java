package OrderProgram;

public class Item {
		String itemId;
		String itemName;
		double itemPrice;
		int itemQuantity;
		
		public Item(String itemId, String itemName, double itemPrice, int itemQuantity){
			this.itemId = itemId;
			this.itemName = itemName;
			this.itemPrice = itemPrice;
			this.itemQuantity = itemQuantity;
		}

		public String getItemName() {
			return itemName;
		}

		public void setItemName(String itemName) {
			this.itemName = itemName;
		}

		public double getItemPrice() {
			return itemPrice;
		}

		public void setItemPrice(double itemPrice) {
			this.itemPrice = itemPrice;
		}

		public int getItemQuantity() {
			return itemQuantity;
		}

		public void setItemQuantity(int itemQuantity) {
			this.itemQuantity = itemQuantity;
		}

		@Override
		public String toString() {
			return "Item [itemName=" + itemName + ", itemPrice=" + itemPrice + ", itemQuantity=" + itemQuantity + "]";
		}
		
}
