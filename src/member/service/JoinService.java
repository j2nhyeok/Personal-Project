package member.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import member.dao.MemberDao;
import member.model.Member;

public class JoinService {

	private MemberDao memberDao = new MemberDao();
	
	

	public void join(JoinRequest joinReq) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			memberDao.insert(conn, 
					new Member(
							joinReq.getId(), 
							joinReq.getPw(), 
							joinReq.getName(), 
							joinReq.getYear(),
							joinReq.getMonth(),
							joinReq.getDate(),
							joinReq.getGender(),
							joinReq.getEmail(),
							joinReq.getPhoneNumber()
							
							)
					);
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
}
