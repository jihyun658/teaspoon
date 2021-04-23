package shop.cart;

public class CartListDataBean {
	private int cart_id;
	private int product_id;
	private String image;
	private String title;
	private int product_price;
	private int buy_price;
	private int buy_count;
	
	//getter
	public int getCart_id() {
		return cart_id;
	}

	public int getProduct_id() {
		return product_id;
	}
	
	public String getImage() {
		return image;
	}
	
	public String getTitle() {
		return title;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	
	public int getBuy_price() {
		return buy_price;
	}
	
	public int getBuy_count() {
		return buy_count;
	}

	// setter
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	public void setImage(String image) {
		this.image = image;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}
	
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}

}
