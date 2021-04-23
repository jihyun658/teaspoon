package shop.buy;

import java.sql.Timestamp;

public class BuyDataBean {
	private String buy_id;
	private String buyer;
	private Timestamp buy_date;
	private String payment_option;
	private String payment_com;
	private String payment_no;
	private int total_price;
	private String delivery_name;
	private String delivery_tel;
	private String delivery_address;
	private String delivery_state;
	
	// getter
	public String getBuy_id() {
		return buy_id;
	}

	public String getBuyer() {
		return buyer;
	}
	
	public Timestamp getBuy_date() {
		return buy_date;
	}
	
	public String getPayment_option() {
		return payment_option;
	}
	
	public String getPayment_com() {
		return payment_com;
	}
	
	public String getPayment_no() {
		return payment_no;
	}
	
	public int getTotal_price() {
		return total_price;
	}
	
	public String getDelivery_name() {
		return delivery_name;
	}
	
	public String getDelivery_tel() {
		return delivery_tel;
	}
	
	public String getDelivery_address() {
		return delivery_address;
	}
	
	public String getDelivery_state() {
		return delivery_state;
	}
	
	// setter
	public void setBuy_id(String buy_id) {
		this.buy_id = buy_id;
	}
	
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	
	public void setBuy_date(Timestamp buy_date) {
		this.buy_date = buy_date;
	}
	
	public void setPayment_option(String payment_option) {
		this.payment_option = payment_option;
	}
	
	public void setPayment_com(String payment_com) {
		this.payment_com = payment_com;
	}
	
	public void setPayment_no(String payment_no) {
		this.payment_no = payment_no;
	}
	
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	
	public void setDelivery_tel(String delivery_tel) {
		this.delivery_tel = delivery_tel;
	}
	
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	
	public void setDelivery_state(String delivery_state) {
		this.delivery_state = delivery_state;
	}

}
