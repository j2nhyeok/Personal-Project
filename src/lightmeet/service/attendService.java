package lightmeet.service;

import java.sql.Connection;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import lightmeet.dao.LightMeetDao;
import lightmeet.model.LightMeet;

public class attendService {
	private LightMeetDao lightmeetDao = new LightMeetDao();

	public int make(String id) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			
				lightmeetDao.updateAttendMember(conn, id);
				lightmeetDao.riseAttendMemberCnt(conn);
				conn.commit();
				return 1;
			}else { 
				JdbcUtil.rollback(conn);
				
				return 0;
			}
			
		} catch(Exception e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally{
			JdbcUtil.close(conn);
		}

	}
}
