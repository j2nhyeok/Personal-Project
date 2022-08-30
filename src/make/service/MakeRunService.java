package make.service;

import java.sql.Connection;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import make.dao.LightMeetDao;
import make.model.LightMeet;

public class MakeRunService {
	private LightMeetDao lightmeetDao = new LightMeetDao();

	public void make(MakeRequest makeReq) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);

			lightmeetDao.insert(conn,
					new LightMeet(
							makeReq.getLeader(),
							makeReq.getCapacity(),
							makeReq.getHour(),
							makeReq.getMinute(),
							makeReq.getGender(),
							makeReq.getKm(),
							makeReq.getStartAge(),
							makeReq.getEndAge(),
							makeReq.getLatitude(),
							makeReq.getLongitude(),
							makeReq.getStartLat(),
							makeReq.getStartLong()
							)
					);
			conn.commit();
		} catch (Exception e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}

	}
}
