package member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import member.model.Member;

public class MemberDao {
	
	public MemberDao() {

	}
	public void deleteUser(String id) throws SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(
					"DELETE FROM member WHERE member_id = ? ");
			pstmt.setString(1, id);
	
			pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
		
		
	}
	public Member selectById(Connection conn, String id) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(
					"select * from member where member_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			Member member = null;
			if (rs.next()) {
				member = new Member(
						rs.getString("member_id"), 
						rs.getString("member_pw"), 
						rs.getString("member_name"),
						rs.getInt("member_year"),
						rs.getInt("member_month"),
						rs.getInt("member_date"),
						rs.getString("member_gender"),
						rs.getString("member_email"),
						rs.getString("member_phone")
						);

			}
			return member;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	
	
	// 아이디 찾기에 사용하는 메서드
	public String findId( String name, String phone) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id = "";
		
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(
					"select member_id from member where  member_name=? and member_phone=? ");
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			
			if (rs.next()) id = rs.getString("member_id");
			
			return id;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
	}
	
	//비밀번호 찾기에 사용하는 메서드
	public String findPw( String id, String phone) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pw = "";
		
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(
					"select member_pw from member where  member_id=? and member_phone=? ");
			pstmt.setString(1, id);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			
			if (rs.next()) pw = rs.getString("member_pw");
			
			return pw;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
	}
	
	
		//아이디 중복확인용 메서드
	   public boolean duplicateIdCheck(String id) throws SQLException {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      boolean x = false;
		    
		      try{
		    	 conn = ConnectionProvider.getConnection();
		         pstmt = conn.prepareStatement("SELECT * from member WHERE member_id = ?");
		         pstmt.setString(1,  id);
		         rs = pstmt.executeQuery();
		         
		        
		         if(rs.next()) x = true;
		         
		         return x;
		      } finally {
		         JdbcUtil.close(rs);
		         JdbcUtil.close(pstmt);
		         JdbcUtil.close(conn);
		      }
		   }
	   
	   //신규 멤버 추가
	   public void insert(Connection conn, Member mem) throws SQLException {
		try (PreparedStatement pstmt = 
				conn.prepareStatement("insert into member values(?,?,?,?,?,?,?,?,?)")) {
			pstmt.setString(1, mem.getId());
			pstmt.setString(2, mem.getPassword());
			pstmt.setString(3, mem.getName());
			pstmt.setInt(4, mem.getBirthYear());
			pstmt.setInt(5, mem.getBirthMonth());
			pstmt.setInt(6, mem.getBirthDate());
			pstmt.setString(7, mem.getGender());
			pstmt.setString(8, mem.getEmail());
			pstmt.setString(9, mem.getPhoneNumber());
			
			pstmt.executeUpdate();
		}
	}
	
		// 이미 가입된 번호가 있나 확인
	   public int duplicatePNCheck(String phone) throws SQLException {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      int x = 0;
		    
		      try{
		    	 conn = ConnectionProvider.getConnection();
		         pstmt = conn.prepareStatement("SELECT * from member WHERE member_phone = ?");
		         pstmt.setString(1, phone);
		         rs = pstmt.executeQuery();
		         
		        
		         if(rs.next()) x = 1;
		         
		         return x;
		      } finally {
		         JdbcUtil.close(rs);
		         JdbcUtil.close(pstmt);
		         JdbcUtil.close(conn);
		      }
		   }
	   
	   //멤버 이름 패스워드 수정.
	public void update(Connection conn, Member member) throws SQLException {
		try (PreparedStatement pstmt = conn.prepareStatement(
				"update member set  member_pw = ? where member_id = ?")) {
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getId());
			pstmt.executeUpdate();
		}
	}
}
