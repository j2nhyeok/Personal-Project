package member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import member.model.Member;

public class BlacklistMemberDao {
	
	public BlacklistMemberDao() {

	}
//	public Member selectById(Connection conn, String id) throws SQLException {
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		try {
//			pstmt = conn.prepareStatement(
//					"select * from member where member_id = ?");
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			Member member = null;
//			if (rs.next()) {
//				member = new Member(
//						rs.getString("member_id"), 
//						rs.getString("member_pw"),
//						rs.getString("member_name"), 
//						rs.getInt("member_year"),
//						rs.getInt("member_month"),
//						rs.getInt("member_date"),
//						rs.getString("member_email"),
//						rs.getString("member_phone"));
//						
//			}
//			return member;
//		} finally {
//			JdbcUtil.close(rs);
//			JdbcUtil.close(pstmt);
//		}
//	}
	//	블랙리스트에 등록되어 있는 전화번호는 가입 못하게 하기위해서 
	   public int duplicatePNCheck(String phone) throws SQLException {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      int x = 0;
		    
		      try{
		    	 conn = ConnectionProvider.getConnection();
		         pstmt = conn.prepareStatement("SELECT * from blacklist WHERE blacklist_phone = ?");
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
//<!-- _____________________________________________________________________________ -->
//	public void insert(Connection conn, Member mem) throws SQLException {
//		try (PreparedStatement pstmt = 
//				conn.prepareStatement("insert into member values(?,?,?,?,?,?,?,?,?)")) {
//			pstmt.setString(1, mem.getId());
//			pstmt.setString(2, mem.getPassword());
//			pstmt.setString(3, mem.getName());
//			pstmt.setInt(4, mem.getBirthYear());
//			pstmt.setInt(5, mem.getBirthMonth());
//			pstmt.setInt(6, mem.getBirthDate());
//			pstmt.setString(7, mem.getGender());
//			pstmt.setString(8, mem.getEmail());
//			pstmt.setString(9, mem.getPhoneNumber());
//			
//			pstmt.executeUpdate();
//		}
//	}
//
//	public void update(Connection conn, Member member) throws SQLException {
//		try (PreparedStatement pstmt = conn.prepareStatement(
//				"update member set name = ?, password = ? where memberid = ?")) {
//			pstmt.setString(1, member.getName());
//			pstmt.setString(2, member.getPassword());
//			pstmt.setString(3, member.getId());
//			pstmt.executeUpdate();
//		}
//	}
}
