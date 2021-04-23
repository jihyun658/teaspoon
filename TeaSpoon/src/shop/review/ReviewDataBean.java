package shop.review;

import java.sql.Timestamp;

public class ReviewDataBean {
	private int review_no;
	private String member_id;
	private int product_id; // 상품 아이디별로 게시판이 나타나게 됨.
	private double rating;
	private String content;
	private Timestamp reg_date;
	
	// getter
	public int getReview_no() {
		return review_no;
	}

	public String getMember_id() {
		return member_id;
	}
	
	public int getProduct_id() {
		return product_id;
	}
	
	public double getRating() {
		return rating;
	}
	
	public String getContent() {
		return content;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	// setter
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	public void setRating(double rating) {
		this.rating = rating;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
