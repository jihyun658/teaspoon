package shop.cart;

public class CartDataBean {
	public int cart_id;
	public String buyer;
	public int product_id;
	public int buy_count;
	
	public int getCart_id() {
		return cart_id;
	}
	public String getBuyer() {
		return buyer;
	}
	public int getProduct_id() {
		return product_id;
	}
	public int getBuy_count() {
		return buy_count;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}
	

}
