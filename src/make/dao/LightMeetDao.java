
 package make.dao;
 
  import java.sql.Connection; import java.sql.PreparedStatement; import
  java.sql.SQLException;

import org.apache.commons.dbcp2.Jdbc41Bridge;

import jdbc.JdbcUtil;
import make.model.LightMeet;
import member.model.Member;
  
  public class LightMeetDao { 
	  public LightMeetDao() { }
	  
	  public boolean selectById(Connection conn, String userId) throws SQLException{
		return false;}
  //신규 러닝 번개 그룹 추가 
	  public void insert(Connection conn, LightMeet meet) throws SQLException { 
		  PreparedStatement pstmt = null;
		
		  try{
			  pstmt = conn.prepareStatement
					  ("INSERT INTO  lightmeet(lightMeet_leader, lightMeet_capacity, lightMeet_hour, lightMeet_minute, lightMeet_gender, lightMeet_km, "
					  		+ "lightMeet_startAge, lightMeet_endAge, lightMeet_latitude, lightMeet_longitude, lightMeet_startLat, lightMeet_startLong)"
					  		+ " values(?,?,?,?,?,?,?,?,?,?,?,?)");
			  
			  
			  pstmt.setString(1, meet.getLeader());
			  pstmt.setInt(2, meet.getCapacity());
			  pstmt.setInt(3, meet.getHour());
			  pstmt.setInt(4, meet.getMinute());
			  pstmt.setString(5, meet.getGender());
			  pstmt.setFloat(6, meet.getKm());
			  pstmt.setInt(7, meet.getStartAge());
			  pstmt.setInt(8, meet.getEndAge());
			  pstmt.setString(9, meet.getLatitude());
			  pstmt.setString(10, meet.getLongitude());
			  pstmt.setString(11, meet.getStartLat());
			  pstmt.setString(12, meet.getStartLong());
			  
			  
			  pstmt.executeUpdate();
		  } finally {
			  JdbcUtil.close(pstmt);
		  }
	  }
  
  }
 