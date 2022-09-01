package refresh.servlet;

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
import make.dao.LightMeetDao;


@WebServlet("/refresh.do")
public class refreshServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("hello");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		LightMeetDao lightmeetDao = new LightMeetDao();

		Connection conn = null;
		List<Double> startLats = new ArrayList<Double>();
		List<Double> startLongs = new ArrayList<Double>();
		List<Integer> id = new ArrayList<Integer>();
		try {
			conn = ConnectionProvider.getConnection();
			startLats = lightmeetDao.selectStartLat(conn);
			startLongs = lightmeetDao.selectStartLong(conn);
			id = lightmeetDao.selectId(conn);
		} catch (Exception e) {	
			e.getStackTrace();
		} finally {
			JdbcUtil.close(conn);
		}

		JSONObject jobj = new JSONObject();
		jobj.put("Latslist", startLats);
		jobj.put("Longslist", startLongs);
		jobj.put("idlist", id);

		resp.setContentType("application/x-json; charset=utf-8");
		resp.getWriter().print(jobj); // 전송이 되는 부분
	}

}
