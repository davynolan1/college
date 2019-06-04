package OrderProgram;

public class Order {
	int orderId;
	Item item;
	public Order(Item item, int orderId) {
		this.item = item;
		this.orderId = orderId;
	}
}
