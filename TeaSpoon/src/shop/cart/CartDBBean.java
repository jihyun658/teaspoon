package shop.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	// singleton 패턴 적용
	private CartDBBean() {}
	
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance() {
		return instance;
	}
	
	// Connection Pool 사용
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/teaspoon");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체 해제
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}

	// Connection, PreparedStatement, ResultSet 객체 해제
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
	
	// 장바구니 유무 확인
	public CartDataBean checkCart(int product_id, String buyer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		CartDataBean cart = null;
		try {
			conn = getConnection();
			sql = "select * from cart where product_id=? and buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, buyer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cart = new CartDataBean();
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBuy_count(rs.getInt("buy_count"));
			}
			
		} catch(Exception e) {
			System.out.println("checkCart()에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return cart;
	}
	
	// 장바구니 추가
	public int insertCart(CartDataBean cart) {
		System.out.println("insertCart() 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int x = 0;
		
		try {
			conn = getConnection();
			sql = "insert into cart values(null, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getBuyer());
			pstmt.setInt(2, cart.getProduct_id());
			pstmt.setInt(3, cart.getBuy_count());
			x = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertCart() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
		return x;
	}
	
	// 장바구니 수정
	public void updateCart(int cart_id, int buy_count) {
		System.out.println("updateCart() 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "update cart set buy_count=? where cart_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, buy_count);
			pstmt.setInt(2, cart_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("###updateCart()에러 ####");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 장바구니 개별 삭제(1개)
	public void deleteCart(int product_id, String buyer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "delete from cart where product_id = ? and buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, buyer);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("###deleteCart()에러 ####");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 장바구니 전체 삭제(전체 비우기)
	public void deleteCart(String buyer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "delete from cart where buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("###deleteCart()에러 ####");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 장바구니 목록 갯수
	public int getCartListCount(String buyer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			conn = getConnection();
			sql = "select count(*) from cart where buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			System.out.println("###getCartListCount()에러 ####");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	

	// 장바구니 전체 목록 보기
	public List<CartListDataBean> getCartList(String buyer){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<CartListDataBean> cartList = new ArrayList<CartListDataBean>();
		CartListDataBean cart = null;
		try {
			conn = getConnection();
			sql = "select p.product_id as 'id', p.product_image1 as 'image', p.product_title as 'title', " +
				  "p.product_price - (p.product_price * p.discount_rate/100) as 'buy_price', c.buy_count, " +
				  "p.product_price * p.discount_rate/100 as 'discount_price', p.product_price, c.cart_id " +
				  "from product p, cart c " + 
				  "where p.product_id = c.product_id and c.buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cart = new CartListDataBean();
				cart.setProduct_id(rs.getInt("id"));
				cart.setImage(rs.getString("image"));
				cart.setTitle(rs.getString("title"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getInt("buy_count"));
				cart.setProduct_price(rs.getInt("product_price"));
				cart.setCart_id(rs.getInt("cart_id"));
				
				cartList.add(cart);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("###getCartList()에러 ####");
		} finally {
			close(conn, pstmt, rs);
		}
		return cartList;
	}
	
	// 장바구니 목록 1개 보기
	public CartListDataBean getCart(int product_id, String buyer){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		CartListDataBean cart = new CartListDataBean();
		try {
			conn = getConnection();
			sql = "select p.product_id as 'id', p.product_image1 as 'image', p.product_title as 'title', " +
					"p.product_price - (p.product_price * p.discount_rate/100) as 'buy_price', c.buy_count, " +
					"p.product_price, c.cart_id " +
					"from product p, cart c " + 
					"where p.product_id = ? and c.buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, buyer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cart.setProduct_id(rs.getInt("id"));
				cart.setImage(rs.getString("image"));
				cart.setTitle(rs.getString("title"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getInt("buy_count"));
				cart.setProduct_price(rs.getInt("product_price"));
				cart.setCart_id(rs.getInt("cart_id"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("###getCartList()에러 ####");
		} finally {
			close(conn, pstmt, rs);
		}
		return cart;
	}
}
