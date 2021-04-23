package shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
	
	// 싱글톤 패턴
	private MemberDBBean() {}
	private static MemberDBBean instance = new MemberDBBean();
	public static MemberDBBean getInstance() {
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

	// 회원가입
	public int insertMember(MemberDataBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int check = 0;
		
		try {
			conn = getConnection();
			
			// 중복 아이디 체크 - confirmId() 메소드 호출
			// check가 1이면 중복 아이디, check가 -1이면 새로운 아이디
			check = confirmId(member.getId());
			
			if(check == -1) { // 아이디가 없을 때(아이디가 중복되지 않을 때)
				sql = "insert into member values(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPasswd());
				pstmt.setString(3, member.getName());
				pstmt.setTimestamp(4, member.getReg_date());
				pstmt.setString(5, member.getAddress());
				pstmt.setString(6, member.getTel());
				pstmt.executeUpdate();
			}	
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("insertMember() 에러");
		} finally {
			close(conn, pstmt);
		}
		return check;
	}
	
	// 사용자 인증 처리 (아이디와 비밀번호 확인)
	public int userCheck(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String dbPasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			sql = "select passwd from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디가 있고, 비밀번호 일치하면, x=1
			// 아이디가 있고, 비밀번호 일치하지 않으면, x=0
			// 아이디가 없다면, x=-1
			if(rs.next()) {
				dbPasswd = rs.getString("passwd");
				
				if(dbPasswd.equals(passwd)) x = 1;
				else x = 0;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
	// 회원가입시에 중복아이디를 체크
	public int confirmId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			sql = "select id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디가 이미 존재하면 1, 아이디가 존재하지 않으면 -1
			if(rs.next()) x = 1;
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}	
		return x;
	}
	
	// 회원정보 확인 - 회원 자신의 정보 확인 (1명) - 사용자	
	public MemberDataBean getMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		MemberDataBean member = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));	
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
		return member;
	}
	
	// 회원정보 전체 확인 - 관리자
	public List<MemberDataBean> getMembers() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<MemberDataBean> memberList = null;
		MemberDataBean member = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from board order by reg_date desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberList = new ArrayList<MemberDataBean>();
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				memberList.add(member);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
		return memberList;
	}
	
	// 회원정보 수정
	public void updateMember(MemberDataBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = getConnection();
			
			sql = "update member set passwd=?, name=?, address=?, tel=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  member.getPasswd());
			pstmt.setString(2,  member.getName());
			pstmt.setString(3,  member.getAddress());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getId());
			pstmt.executeLargeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		} 
	}
	
	// 회원정보(회원탈퇴)
	@SuppressWarnings("resource")
	public int deleteMember(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			sql = "select passwd from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// x=-1: 아이디가 없을 때, 
			// x=1: 아이디와 비밀번호가 모두 일치할 때, 
			// x=0: 아이디는 일치하지만, 비밀번호가 일치하지 않을 때
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))) {
					sql = "delete from member where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;
				} else {
					x = 0;
				}
			}   
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
		return x;
	}

}
