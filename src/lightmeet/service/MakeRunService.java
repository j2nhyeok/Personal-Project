package lightmeet.service;

import java.sql.Connection;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import lightmeet.dao.LightMeetDao;
import lightmeet.dao.LightMeetMemberDao;
import lightmeet.model.LightMeet;

public class MakeRunService {
	private LightMeetDao lightmeetDao = new LightMeetDao();
	private LightMeetMemberDao lightmeetmemberDao = new LightMeetMemberDao();
	public int make(MakeRequest makeReq) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			int isitDuple = lightmeetDao.selectById(conn, makeReq.getLeader());
			
			if(isitDuple == 0) {     
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
			
				int completeId = lightmeetDao.selectById(conn, makeReq.getLeader()); //completeId는 막 생성된 러닝 번개의 id
				lightmeetmemberDao.insert(conn, makeReq.getLeader(), completeId);
				
				
				
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
