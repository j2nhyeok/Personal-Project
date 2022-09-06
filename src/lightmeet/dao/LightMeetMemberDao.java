
package lightmeet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.JdbcUtil;

public class LightMeetMemberDao {
	public LightMeetMemberDao() {
	}
	 
	//러닝 번개를 생성한 자신은 무조건 해당 번개에 참가하기 때문에, lightmeetmember에 insert.
	public void insert(Connection conn, String attendMemberId, int attendMeetId) throws SQLException {
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(
					"INSERT INTO  lightmeetmember values(?,?)");

			pstmt.setString(1, attendMemberId);
			pstmt.setInt(2, attendMeetId);
		
			pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	// 이미 참가 확정된 번개에 한 번 더 <참가하기> 버튼을 눌렀을 경우를 예방하여 중복체크 
	public boolean dupleCheck(Connection conn, String attendMemberId, int attendMeetId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(
					"SELECT * FROM lightmeetmember WHERE attendMemberId = ? AND attendMeetId = ? ");

			pstmt.setString(1, attendMemberId);
			pstmt.setInt(2, attendMeetId);
		
			rs = pstmt.executeQuery();
			
			boolean dupleOk = false;
			
			if(rs.next()) dupleOk = true;
			
			return dupleOk;
			
			
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
}
