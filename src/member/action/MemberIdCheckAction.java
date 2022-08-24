package member.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDao;
import mvc.command.CommandHandler;


public class MemberIdCheckAction implements CommandHandler{
	
 

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, resp);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, resp);
		} else {
			resp.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
			
		
		
	}

	private String processSubmit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String id = req.getParameter("id");
		System.out.println(id);
		MemberDao memberDao = new MemberDao();
		PrintWriter out = null;
		boolean result = false;
		try {
			result = memberDao.duplicateIdCheck(id);
			resp.setContentType("text/html;charset=UTF-8");
			
			 out = resp.getWriter();
			if(result) out.println("0"); // 아이디 중복
			else out.println("1");

		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
		return "WebContent/member/idCheckForm.jsp";
	}

	private String processForm(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		return null;	}	
}
