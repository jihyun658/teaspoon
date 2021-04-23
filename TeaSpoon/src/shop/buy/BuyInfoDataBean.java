package shop.buy;

public class BuyInfoDataBean {
	private String buy_id;
	private int product_id;
	private String product_title;
	private String product_image;
	private int product_price;
	private int buy_price;
	private int buy_count;
	
	//getter
	public String getBuy_id() {
		return buy_id;
	}

	public int getProduct_id() {
		return product_id;
	}
	
	public String getProduct_title() {
		return product_title;
	}
	
	public String getProduct_image() {
		return product_image;
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
	public void setBuy_id(String buy_id) {
		this.buy_id = buy_id;
	}
	
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}
	
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
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

	@Override
	public String toString() {
		return "Buy_intoDataBean [buy_id=" + buy_id + ", product_id=" + product_id + ", product_image=" + product_image
				+ ", product_price=" + product_price + ", buy_price=" + buy_price + ", buy_count=" + buy_count + "]";
	}
	
	
}
