package shop.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ReviewDBBean {
	// singleton 패턴
	private static ReviewDBBean instance = new ReviewDBBean();
	public static ReviewDBBean getInstance() {
		return instance;
	}
	private ReviewDBBean() {}
	
	// 커넥션풀 연결
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/teaspoon");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
		
	// Connection, PreparedStatement, ResultSet 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// 리뷰등록
	public void insertReview(ReviewDataBean review) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "insert into review values(null, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review.getMember_id());
			pstmt.setInt(2, review.getProduct_id());
			pstmt.setDouble(3, review.getRating());
			pstmt.setString(4, review.getContent());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertReview() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}	
	}
	
	// 리뷰수정
	public void updateReview(ReviewDataBean review) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "update review set rating=?, content=? where review_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, review.getRating());
			pstmt.setString(2, review.getContent());
			pstmt.setInt(3, review.getReview_no());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("updateReview() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}	
	}
	
	// 리뷰삭제
	public void deleteReview(int review_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "delete from review where review_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_no);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("deleteReview() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}	
	}
	
	// 전체 리뷰수
	public int getReviewCount(int product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0; // 전체 글수
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from review where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) x = rs.getInt(1);	
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getArticleCount() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
	// 리뷰 전체 보기
	public List<ReviewDataBean> getReviewList(int start, int end, int product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDataBean> reviewList = new ArrayList<ReviewDataBean>();
		ReviewDataBean review = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select * from review where product_id = ? order by reg_date desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setInt(2, start-1); // limit는 0번부터 시작
			pstmt.setInt(3, end);     // 가져올 로우수 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				review = new ReviewDataBean();
				review.setReview_no(rs.getInt("review_no"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setRating(rs.getDouble("rating"));
				review.setContent(rs.getString("content"));
				review.setReg_date(rs.getTimestamp("reg_date"));
				reviewList.add(review);
			}
			
		} catch(Exception e) {
			System.out.println("getReviewList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}	
		return reviewList;
	}
	
	// 상품별 리뷰 평점
	public double getRatingAVG(int product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		double avg = 0;
		try {
			conn = getConnection();
			sql = "select round(avg(rating),2) as 'avg' from review where product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) avg = rs.getDouble("avg");
		} catch(Exception e) {
			System.out.println("getRatingAVG() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return avg;
	}
	
	// 리뷰 하나
	public ReviewDataBean getReview(int review_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDataBean review = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select * from review where review_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				review = new ReviewDataBean();
				review.setReview_no(rs.getInt("review_no"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setRating(rs.getDouble("rating"));
				review.setContent(rs.getString("content"));
				review.setReg_date(rs.getTimestamp("reg_date"));
			}
			
		} catch(Exception e) {
			System.out.println("getReviewList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}	
		return review;
	}
	
	public List<ReviewDataBean> getMyReview(String member_id, int start, int end){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDataBean> reviewList = new ArrayList<ReviewDataBean>();
		ReviewDataBean review = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select * from review where member_id = ? order by reg_date desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, start-1); // limit는 0번부터 시작
			pstmt.setInt(3, end);     // 가져올 로우수 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				review = new ReviewDataBean();
				review.setReview_no(rs.getInt("review_no"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setRating(rs.getDouble("rating"));
				review.setContent(rs.getString("content"));
				review.setReg_date(rs.getTimestamp("reg_date"));
				reviewList.add(review);
			}
			
		} catch(Exception e) {
			System.out.println("getReviewList() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}	
		return reviewList;
	}
}
