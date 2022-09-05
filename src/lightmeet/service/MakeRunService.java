package lightmeet.service;

import java.sql.Connection;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import lightmeet.dao.LightMeetDao;
import lightmeet.model.LightMeet;

public class MakeRunService {
	private LightMeetDao lightmeetDao = new LightMeetDao();

	public int make(MakeRequest makeReq) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			boolean isitDuple = lightmeetDao.selectById(conn, makeReq.getLeader());
			
			if(!isitDuple) {
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
				return 1;
			}else { 
				JdbcUtil.rollback(conn);
				
				return 0;
			}
			
		} catch (Exception e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}

	}
}
