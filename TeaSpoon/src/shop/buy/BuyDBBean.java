package shop.buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BuyDBBean {
	// singleton 패턴
	private BuyDBBean() {}
	
	private static BuyDBBean instance = new BuyDBBean();
	
	public static BuyDBBean getInstance() {
		return instance;
	}
	
	// Connection Pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/teaspoon");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체 해제
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// Connection, PreparedStatement 객체 해제
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// 구매 목록 추가하고, 장바구니 목록에서는 삭제 ---> 트랜잭션 처리
	@SuppressWarnings("resource")
	public int insertBuyList(BuyDataBean buy, List<BuyInfoDataBean> buyInfoList) {
		System.out.println("===> insertBuyList() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int x = 0;
		
		try { 
			conn = getConnection();
			
			// 하나의 트랜잭션으로 처리 - 시작
			conn.setAutoCommit(false);
			
			// 구매목록에 추가
			sql = "insert into buy values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy.getBuy_id());
			pstmt.setString(2, buy.getBuyer());
			pstmt.setTimestamp(3, buy.getBuy_date());
			pstmt.setString(4, buy.getPayment_option());
			pstmt.setString(5, buy.getPayment_com());
			pstmt.setString(6, buy.getPayment_no());
			pstmt.setInt(7, buy.getTotal_price());
			pstmt.setString(8, buy.getDelivery_name());
			pstmt.setString(9, buy.getDelivery_tel());
			pstmt.setString(10, buy.getDelivery_address());
			pstmt.setString(11, buy.getDelivery_state());
			x = pstmt.executeUpdate();
			
			for(BuyInfoDataBean buyInfo : buyInfoList) {
				// cart에서 상품 삭제
				sql = "delete from cart where product_id = ? and buyer = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, buyInfo.getProduct_id());
				pstmt.setString(2, buy.getBuyer());
				pstmt.executeUpdate();
				
				// 상품 테이블에 잔여 수량, 판매수량 변경
				sql = "update product set sales_volume = sales_volume+?, product_count = product_count-? where product_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, buyInfo.getBuy_count());
				pstmt.setInt(2, buyInfo.getBuy_count());
				pstmt.setInt(3, buyInfo.getProduct_id());
				pstmt.executeUpdate();
		
				// buyInfo 테이블 삽입
				sql = "insert into buy_info values(?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buyInfo.getBuy_id());
				pstmt.setInt(2, buyInfo.getProduct_id());
				pstmt.setString(3, buyInfo.getProduct_title());
				pstmt.setString(4, buyInfo.getProduct_image());
				pstmt.setInt(5, buyInfo.getProduct_price());
				pstmt.setInt(6, buyInfo.getBuy_price());
				pstmt.setInt(7, buyInfo.getBuy_count());
				pstmt.executeUpdate();
			}
			// 하나의 트랜잭션으로 처리 - 끝
			
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch(Exception e) {
			System.out.println("### insertBuyList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
		return x;
	}
	
	// 구매 리스트
	public List<HashMap<String, String>> getBuyList(String buyer){
		System.out.println("===> getBuyList() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HashMap<String, String>> buyList = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> buy = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "select i.buy_id, i.product_title, i.product_image, b.total_price, b.buy_date, b.delivery_state, count(*)-1 as 'et'" + 
					"from buy b, buy_info i where i.buy_id = b.buy_id and buyer = ? group by i.buy_id";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				buy = new HashMap<String, String>();
				buy.put("buy_id", rs.getString("buy_id"));
				buy.put("product_title", rs.getString("product_title"));
				buy.put("product_image", rs.getString("product_image"));
				buy.put("total_price", rs.getString("total_price"));
				buy.put("buy_date", rs.getString("buy_date"));
				buy.put("delivery_state", rs.getString("delivery_state"));
				buy.put("et", rs.getString("et"));
				
				buyList.add(buy);
			}
		} catch(Exception e) {
			System.out.println("===> getBuyList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return buyList;
	}
	
	// 구매 상품 정보 확인 (buy_info 테이블)
	public List<BuyInfoDataBean> getBuyInfo(String buy_id){
		System.out.println("===> getBuyInfo() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BuyInfoDataBean> buyInfoList = new ArrayList<BuyInfoDataBean>();
		BuyInfoDataBean buyInfo = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "select * from buy_info where buy_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				buyInfo = new BuyInfoDataBean();
				buyInfo.setProduct_id(rs.getInt("product_id"));
				buyInfo.setProduct_title(rs.getString("product_title"));
				buyInfo.setProduct_image(rs.getString("product_image"));
				buyInfo.setProduct_price(rs.getInt("product_price"));
				buyInfo.setBuy_price(rs.getInt("buy_price"));
				buyInfo.setBuy_count(rs.getInt("buy_count"));
				
				buyInfoList.add(buyInfo);
			}
		} catch(Exception e) {
			System.out.println("===> getBuyInfo() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return buyInfoList;
	}
	
	// 구매 정보 (buy 테이블) 
	public BuyDataBean getBuy(String buy_id) {
		System.out.println("===> getBuy() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BuyDataBean buy =new BuyDataBean();
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "select * from buy where buy_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setPayment_option(rs.getString("payment_option"));
				buy.setPayment_com(rs.getString("payment_com"));
				buy.setPayment_no(rs.getString("payment_no"));
				buy.setTotal_price(rs.getInt("total_price"));
				buy.setDelivery_name(rs.getString("delivery_name"));
				buy.setDelivery_tel(rs.getString("delivery_tel"));
				buy.setDelivery_address(rs.getString("delivery_address"));
				buy.setDelivery_state(rs.getString("delivery_state"));
			}
		} catch(Exception e) {
			System.out.println("===> getBuy() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return buy;
	}

}
