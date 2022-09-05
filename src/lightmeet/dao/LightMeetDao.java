
package lightmeet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jdbc.JdbcUtil;
import lightmeet.model.LightMeet;

public class LightMeetDao {
	public LightMeetDao() {
	}

	// id 중복 체크 메서드
	public boolean selectById(Connection conn, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean x = false;
		try {
			pstmt = conn.prepareStatement("select * from lightmeet where lightmeet_leader = ?");

			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next())
				x = true;
			return x;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

	public List<Integer> selectId(Connection conn) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
		List<Integer> id = new ArrayList<Integer>();

		try {
			stmt = conn.createStatement();
			String sql = "SELECT lightMeet_id from lightmeet";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {

				id.add(rs.getInt(("lightMeet_id")));

			}
			return id;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}

	}

	public List<Double> selectStartLat(Connection conn) throws SQLException {

		Statement stmt = null;
		ResultSet rs = null;
		List<Double> startLats = new ArrayList<Double>();

		try {
			stmt = conn.createStatement();
			String sql = "SELECT lightMeet_startLat from lightmeet";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {

				startLats.add(rs.getDouble(("lightMeet_startLat")));

			}
			return startLats;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}

	public List<Double> selectStartLong(Connection conn) throws SQLException {

		Statement stmt = null;
		ResultSet rs = null;
		List<Double> startLongs = new ArrayList<Double>();

		try {
			stmt = conn.createStatement();
			String sql = "SELECT lightMeet_startLong from lightmeet";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {

				startLongs.add(rs.getDouble(("lightMeet_startLong")));

			}
			return startLongs;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}

	// 러닝 번개 추가하는 메서드
	public void insert(Connection conn, LightMeet meet) throws SQLException {
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(
					"INSERT INTO  lightmeet(lightMeet_leader, lightMeet_capacity, lightMeet_hour, lightMeet_minute, lightMeet_gender, lightMeet_km, "
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

	// 해당 하는 id의 모든 정보를 알려주는 메서드
	public List<Object> showInfo(Connection conn, int lightMeet_id) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Object> informations = new ArrayList<Object>();

		try {
			pstmt = conn.prepareStatement("SELECT * FROM lightmeet where lightMeet_id = ?");

			pstmt.setInt(1, lightMeet_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				informations.add(rs.getInt("lightMeet_id"));
				informations.add(rs.getString("lightMeet_leader"));
				informations.add(rs.getInt("lightMeet_participant"));
				informations.add(rs.getInt("lightMeet_capacity"));
				informations.add(rs.getInt("lightMeet_hour"));
				informations.add(rs.getInt("lightMeet_minute"));
				informations.add(rs.getString("lightMeet_gender"));
				informations.add(rs.getFloat("lightMeet_km"));
				informations.add(rs.getInt("lightMeet_startAge"));
				informations.add(rs.getInt("lightMeet_endAge"));
				informations.add(rs.getObject("lightMeet_latitude"));
				informations.add(rs.getObject("lightMeet_longitude"));
				informations.add(rs.getString("lightMeet_member"));

			}
			return informations;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}

	}
}
