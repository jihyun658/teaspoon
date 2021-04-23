package shop.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDBBean {
	
	// 싱글톤 패턴
	private ProductDBBean() {}
	private static ProductDBBean instance = new ProductDBBean();
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// 커넥션풀을 통해 커넥션을 획득하는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/teaspoon");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체를 닫는 메소드
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// Connection, PreparedStatement 객체를 닫는 메소드
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// conn, pstmt, rs, sql 전역변수
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

	// 관리자 인증 메소드
	public int managerCheck(String id, String passwd) {		
		int x = -1; 
		try {
			conn = getConnection();
			sql = "select managerPasswd from manager where managerId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디가 없을 때 -1, 비밀번호 불일치 0 비밀번호 일치 1
			if(rs.next()) {
				if(passwd.equals(rs.getString(1))) x = 1; 
				else x = 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("## managerCheck() 에러 ##");
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
	// 상품 삽입 메소드
	public void insertProduct(ProductDataBean product) {
		try {
			conn = getConnection();
			sql = "insert into product values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product.getProduct_id());
			pstmt.setString(2, product.getProduct_category());
			pstmt.setString(3, product.getProduct_kind());
			pstmt.setString(4, product.getProduct_title());
			pstmt.setString(5, product.getProduct_brand());
			pstmt.setString(6, product.getProduct_origin());
			pstmt.setString(7, product.getProduct_material());
			pstmt.setString(8, product.getProduct_type());
			pstmt.setString(9, product.getProduct_weight());
			pstmt.setInt(10, product.getProduct_price());
			pstmt.setInt(11, product.getProduct_count());
			pstmt.setInt(12, product.getDiscount_rate());
			pstmt.setString(13, product.getProduct_content());
			pstmt.setString(14, product.getProduct_image1());
			pstmt.setString(15, product.getProduct_image2());
			pstmt.setString(16, product.getProduct_image3());
			pstmt.setString(17, product.getProduct_image4());
			pstmt.setTimestamp(18, product.getReg_date());
			pstmt.setInt(19, 0);
			pstmt.setInt(20, 0);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### insertProduct() 에러 ###");
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 카테고리별 상품 갯수 구하는 메소드
	public int getProductCount(String product_category, String select) {
		int count = 0;
		String sql2 = "";
		if(select == null || select == "") select = "product_category";
		try {
			conn = getConnection();
			sql = "select count(*) from product";
			sql2 = sql + " where "+ select +" = ?";
			
			if(product_category.equals("all")) pstmt = conn.prepareStatement(sql);
			else {
				pstmt=conn.prepareStatement(sql2);
				pstmt.setString(1, product_category);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getProductCount()에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 상품 분류 별 상품 갯수 구하는 메소드
	public int getProductKindCount(String product_kind) {
		int count = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from product where product_kind = ?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getProductKindCount()에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 카테고리별 상품 목록 보기
	public List<ProductDataBean> getProducts(String product_category, String select, String order_by, int start, int end){
		String sql2 = "";
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		if(order_by == null || order_by == "") order_by = "reg_date";
		if(select == null || select == "") select = "product_category";
		try {
			conn = getConnection();
			sql = "select * from product order by " + order_by + " desc limit ?, ?";
			sql2 = "select * from product where " + select + "=? order by " + order_by + " desc limit ?, ?";
			
			if(product_category.equals("all")) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_category);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDataBean();
				
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_material(rs.getString("product_material"));
				product.setProduct_type(rs.getString("product_type"));
				product.setProduct_weight(rs.getString("product_weight"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				
				productList.add(product);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getProducts() 에러");
		} finally {
			close(conn, pstmt, rs);
		}
		
		return productList;
	}
	
	// 분류별 상품보기
	public List<ProductDataBean> getProductKinds(String product_kind, String order_by, int start, int end){
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		if(order_by == null || order_by == "") order_by = "reg_date";
		try {
			conn = getConnection();
			sql = "select * from product where product_kind=? "
					+ "order by " + order_by + " desc limit ?, ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDataBean();
				
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_material(rs.getString("product_material"));
				product.setProduct_type(rs.getString("product_type"));
				product.setProduct_weight(rs.getString("product_weight"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				
				productList.add(product);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getProducts() 에러");
		} finally {
			close(conn, pstmt, rs);
		}
		
		return productList;
	}
	
	// category를 한글로 변환하는 메소드
	public String getCategoryName(String category) {
		String categoryName="";
		if(category.equals("1")) categoryName="차";
		else if(category.equals("2")) categoryName="다구";
		else categoryName="기타";

		return categoryName;
	}
	
	// kind를 한글로 변환하는 메소드
	public String getKindName(String kind) {
		String kinds[];
		int intKind = Integer.parseInt(kind);
		if(intKind / 100 == 1) {
			kinds = new String[] {"블랜딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효자", "녹차", "기타"};
		} else if(intKind / 100 == 2) {
			kinds = new String[] {"티컵/티팟", "티백주머니", "인퓨저", "보틀/텀블러", "기타"};
		} else {kinds = new String[] {"선물 꽃", "쿠키/디저트", "기타"};
		}
		int i = intKind % 100 -1;
		return kinds[i];
	}
	
	// 카테고리 별 신상품 보기
	public List<ProductDataBean> getProducts(String product_category, int count){
		List<ProductDataBean> productList = null;
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// 상품종류에 따라 등록일을 내림차수하여 count 갯수만큼만 조회
			sql = "select * from product where product_category=? order by reg_date desc limit ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_category);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			productList = new ArrayList<ProductDataBean>();
			while(rs.next()) {
				product = new ProductDataBean();
				
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_material(rs.getString("product_material"));
				product.setProduct_type(rs.getString("product_type"));
				product.setProduct_weight(rs.getString("product_weight"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 카인드별 별 신상품 보기
	public List<ProductDataBean> getKindProducts(String product_kind, int count){
		List<ProductDataBean> productList = null;
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// 상품종류에 따라 등록일을 내림차수하여 count 갯수만큼만 조회
			sql = "select * from product where product_kind=? order by reg_date desc limit ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			productList = new ArrayList<ProductDataBean>();
			while(rs.next()) {
				product = new ProductDataBean();
				
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_material(rs.getString("product_material"));
				product.setProduct_type(rs.getString("product_type"));
				product.setProduct_weight(rs.getString("product_weight"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 제품 상세보기 - 1건
	public ProductDataBean getProduct(int product_id) {
		ProductDataBean product = null;
		try {
			conn = getConnection();
			
			// view_count 필드 1씩 증가
			sql = "update product set view_count=view_count+1 where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeLargeUpdate();
			
			sql = "select * from product where product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDataBean();
				
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_material(rs.getString("product_material"));
				product.setProduct_type(rs.getString("product_type"));
				product.setProduct_weight(rs.getString("product_weight"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getProduct() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return product;
	}
	
	// 상품 수정 메소드
	public void updateProduct(ProductDataBean product) {
		try {
			conn = getConnection();
			sql = "update product set "
					+ "product_category=?, product_kind=?, product_title=?, product_brand=?,"
					+ "product_origin=?, product_material=?, product_type=?, product_weight=?,"
					+ "product_price=?, product_count=?, discount_rate=?, product_content=?, product_image1=?, "
					+ "product_image2=?, product_image3=?, product_image4=? where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_category());
			pstmt.setString(2, product.getProduct_kind());
			pstmt.setString(3, product.getProduct_title());
			pstmt.setString(4, product.getProduct_brand());
			pstmt.setString(5, product.getProduct_origin());
			pstmt.setString(6, product.getProduct_material());
			pstmt.setString(7, product.getProduct_type());
			pstmt.setString(8, product.getProduct_weight());
			pstmt.setInt(9, product.getProduct_price());
			pstmt.setInt(10, product.getProduct_count());
			pstmt.setInt(11, product.getDiscount_rate());
			pstmt.setString(12, product.getProduct_content());
			pstmt.setString(13, product.getProduct_image1());
			pstmt.setString(14, product.getProduct_image2());
			pstmt.setString(15, product.getProduct_image3());
			pstmt.setString(16, product.getProduct_image4());
			pstmt.setInt(17, product.getProduct_id());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### updateProduct() 에러");
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 상품정보를 삭제하는 메소드
		public void deleteProduct(int product_id) {
			try {
				conn = getConnection();
				
				sql = "delete from product where product_id=?";
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, product_id);
				pstmt.executeUpdate();
			} catch(Exception e) {
				 e.printStackTrace();
			} finally {
				close(conn, pstmt);
			}
		}
		
	// 상품 검색
		public List<ProductDataBean> searchProducts(String search, String order_by, int start, int end){
			List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
			ProductDataBean product = null;
			if(order_by == null || order_by.equals("")) order_by = "reg_date";
			try {
				conn = getConnection();
				
				sql = "select * from product where product_title like ? order by " + order_by + " desc limit ?, ?";
				System.out.println(sql);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					product = new ProductDataBean();
					
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_category(rs.getString("product_category"));
					product.setProduct_kind(rs.getString("product_kind"));
					product.setProduct_title(rs.getString("product_title"));
					product.setProduct_brand(rs.getString("product_brand"));
					product.setProduct_origin(rs.getString("product_origin"));
					product.setProduct_material(rs.getString("product_material"));
					product.setProduct_type(rs.getString("product_type"));
					product.setProduct_weight(rs.getString("product_weight"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_count(rs.getInt("product_count"));
					product.setDiscount_rate(rs.getInt("discount_rate"));
					product.setProduct_content(rs.getString("product_content"));
					product.setProduct_image1(rs.getString("product_image1"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					
					productList.add(product);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return productList;
		}
		// 검색된 상품 갯수
		public int searchCount(String search) {
			int count = 0;
			try {
				conn = getConnection();
				sql = "select count(*) from product where product_title like ?";
				
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) count = rs.getInt(1);
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("### searchCount()에러 ###");
			} finally {
				close(conn, pstmt, rs);
			}
			return count;
		}
		
}
