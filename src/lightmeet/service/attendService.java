
package lightmeet.service;

import java.sql.Connection;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import lightmeet.dao.LightMeetDao;
import lightmeet.dao.LightMeetMemberDao;
import member.service.MemberNotFoundException;

public class attendService {
	private LightMeetMemberDao lightmeetmemberDao = new LightMeetMemberDao();
	private LightMeetDao lightmeetDao = new LightMeetDao(); 
	
	public int insert(String attendMemberId, int attendMeetId ) {
		Connection conn = null;
		int number = 0;
		try {
			conn =  ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			//1. 일단 해당하는 id를 가진 러닝 번개가 참여가 가능한 상태인지 확인 -> 삭제되었거나 시간이 지났으면 false리턴
			boolean temp = lightmeetDao.preORabs(conn, attendMeetId);
			if(!temp) {
				number = 1;
				throw  new MeetNotFoundException();
			}
			
			//2. 이미 참여하기로 한 러닝 번개에 다시 <참가하기>를 눌렀을 경우. 
			temp = lightmeetmemberDao.dupleCheck(conn, attendMemberId, attendMeetId);
			if(temp) {
				number = 2;
				throw  new AttendDupleException();
			}
				
			
			lightmeetmemberDao.insert(conn, attendMemberId, attendMeetId);

			conn.commit();
  
			return number; //위의 모든 조건을 통과한 다음 성공하였으면 0을 리턴함
			
  
	  }catch(Exception e){
			JdbcUtil.rollback(conn);
			return number; // 
	  }finally{
			JdbcUtil.close(conn);
      }
	
	}
}
