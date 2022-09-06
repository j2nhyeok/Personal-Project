
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
			//1. �ϴ� �ش��ϴ� id�� ���� ���� ������ ������ ������ �������� Ȯ�� -> �����Ǿ��ų� �ð��� �������� false����
			boolean temp = lightmeetDao.preORabs(conn, attendMeetId);
			if(!temp) {
				number = 1;
				throw  new MeetNotFoundException();
			}
			
			//2. �̹� �����ϱ�� �� ���� ������ �ٽ� <�����ϱ�>�� ������ ���. 
			temp = lightmeetmemberDao.dupleCheck(conn, attendMemberId, attendMeetId);
			if(temp) {
				number = 2;
				throw  new AttendDupleException();
			}
				
			
			lightmeetmemberDao.insert(conn, attendMemberId, attendMeetId);

			conn.commit();
  
			return number; //���� ��� ������ ����� ���� �����Ͽ����� 0�� ������
			
  
	  }catch(Exception e){
			JdbcUtil.rollback(conn);
			return number; // 
	  }finally{
			JdbcUtil.close(conn);
      }
	
	}
}
