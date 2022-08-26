package member.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import member.dao.MemberDao;
import member.model.Member;

public class SecessionService {

	private MemberDao memberDao = new MemberDao();
	
	public void secessionUser(String userId,String userPwd,  String inputPwd) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			
			if(inputPwd.equals(userPwd)) {
				memberDao.deleteUser(userId);
				conn.commit();
			}else {
				throw new InvalidPasswordException();
			}
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
