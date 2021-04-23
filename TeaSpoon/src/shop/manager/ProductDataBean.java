package shop.manager;

import java.sql.Timestamp;

public class ProductDataBean {
	private int product_id; // 상품 번호 primary key
	private String product_category; // 상품 카테고리 varchar(1) 1:차 2:다구 3:기타
	private String product_kind; // 상품 종류 varchar(15)
	private String product_title; // 상품 이름
	private String product_brand; // 상품 브랜드
	private String product_origin; // 상품 원산지
	private String product_material; // 상품 원재료 및 함량
	private String product_type; // 상품 타입
	private String product_weight; // 용량
	private int product_price; // 가격
	private int product_count; // 갯수
	private int discount_rate; // 할인율
	private String product_content; // 상품 설명
	private String product_image1; // 상품 이미지
	private String product_image2; // 상품 이미지
	private String product_image3; // 상품 이미지
	private String product_image4; // 상품 이미지
	private Timestamp reg_date; // 상품 등록일
	private int view_count;
	private int sales_volume;
	
	// getter
	public int getProduct_id() {
		return product_id;
	}
	
	public String getProduct_category() {
		return product_category;
	}
	
	public String getProduct_kind() {
		return product_kind;
	}
	
	public String getProduct_title() {
		return product_title;
	}
	
	public String getProduct_brand() {
		return product_brand;
	}
	
	public String getProduct_origin() {
		return product_origin;
	}
	
	public String getProduct_material() {
		return product_material;
	}
	
	public String getProduct_type() {
		return product_type;
	}
	
	public String getProduct_weight() {
		return product_weight;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	
	public int getProduct_count() {
		return product_count;
	}
	
	public int getDiscount_rate() {
		return discount_rate;
	}
	
	public String getProduct_content() {
		return product_content;
	}
	
	public String getProduct_image1() {
		return product_image1;
	}
	
	public String getProduct_image2() {
		return product_image2;
	}
	
	public String getProduct_image3() {
		return product_image3;
	}
	
	public String getProduct_image4() {
		return product_image4;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public int getView_count() {
		return view_count;
	}

	public int getSales_volume() {
		return sales_volume;
	}

	// setter
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	
	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}
	
	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}
	
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	
	public void setProduct_origin(String product_origin) {
		this.product_origin = product_origin;
	}
	
	public void setProduct_material(String product_material) {
		this.product_material = product_material;
	}
	
	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}
	
	public void setProduct_weight(String product_weight) {
		this.product_weight = product_weight;
	}
	
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	
	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}
	
	public void setProduct_image1(String product_image1) {
		this.product_image1 = product_image1;
	}
	
	public void setProduct_image2(String product_image2) {
		this.product_image2 = product_image2;
	}
	
	public void setProduct_image3(String product_image3) {
		this.product_image3 = product_image3;
	}
	
	public void setProduct_image4(String product_image4) {
		this.product_image4 = product_image4;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
	public void setSales_volume(int sales_volume) {
		this.sales_volume = sales_volume;
	}
}
