package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import lightmeet.dao.LightMeetDao;

@WebServlet("/lightmeet.do")
public class lightMeetServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("hello");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		LightMeetDao lightmeetDao = new LightMeetDao();

		Connection conn = null;
		List<Object> informations = new ArrayList<Object>();
		
		try {
			conn = ConnectionProvider.getConnection();
			informations = lightmeetDao.showInfo(conn, Integer.parseInt(req.getParameter("lightMeet_id")));
			
			for(int i = 0; i < informations.size(); i++) {
			}
		} catch (Exception e) {	
			e.getStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}

		JSONObject jobj = new JSONObject();
		jobj.put("informations", informations);

		resp.setContentType("application/x-json; charset=utf-8");
		resp.getWriter().print(jobj);  
	}
	
}
