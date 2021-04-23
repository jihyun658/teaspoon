package shop.faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class FaQDBBean {
	// singleton 패턴
	private static FaQDBBean instance = new FaQDBBean();
	public static FaQDBBean getInstance() {
		return instance;
	}
	private FaQDBBean() {}
	
	// 커넥션풀 연결
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/teaspoon");
		return ds.getConnection();
	}
		
	// Connection, PreparedStatement, ResultSet 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// FaQ 리스트 불러오기
	public List<FaQDataBean> getFaqList(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<FaQDataBean> faqList = new ArrayList<FaQDataBean>();
		FaQDataBean faq = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select * from faq";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				faq = new FaQDataBean();
				faq.setFaq_no(rs.getInt("faq_no"));
				faq.setManager_id(rs.getString("manager_id"));
				faq.setQ_kind(rs.getString("q_kind"));
				faq.setSubject(rs.getString("subject"));
				faq.setContent(rs.getString("content"));
				faq.setReg_date(rs.getTimestamp("reg_date"));
				faqList.add(faq);
			}
			
		} catch(Exception e) {
			System.out.println("getReviewList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}	
		return faqList;
	}
	
}
