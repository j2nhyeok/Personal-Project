//
//package servlet;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import auth.service.User;
//import lightmeet.service.attendService;
//import mvc.command.CommandHandler;
//
//@WebServlet("/attend.do")
//public class attendServlet extends HttpServlet {
//	private attendService attendSvc = new attendService();
//	
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("hello");
//	}
//	
//
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		User user = (User) req.getSession().getAttribute("authUser");
//
//		int attendlightMeetId = Integer.parseInt(req.getParameter("lightMeet_id"));
//
//		
//		  attendSvc.insert(user.getId(), attendlightMeetId);
//	
//		
//			
//
//	}
//}
