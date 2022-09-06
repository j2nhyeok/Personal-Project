package lightmeet.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import auth.service.User;
import lightmeet.service.attendService;
import mvc.command.CommandHandler;

public class attendHandler implements CommandHandler {
	private static final String FORM_VIEW = "lightmeet/makeRun.jsp";
	private attendService attendSvc = new attendService();
	
	
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) 
	throws Exception {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		} else {
			res.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}
	
	
	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}


	private String processSubmit(HttpServletRequest req, HttpServletResponse res)
	throws Exception {
		User user = (User) req.getSession().getAttribute("authUser");
		int attendlightMeetId = Integer.parseInt(req.getParameter("lightMeet_id"));

			
		  int temp = attendSvc.insert(user.getId(), attendlightMeetId);
		  
		  if(temp == 0) return "/WEB-INF/lightMeet/attendSuccess.jsp";
		  else if(temp ==1)  return "/WEB-INF/lightMeet/attendFail.jsp";
		  else return "/WEB-INF/lightMeet/attendFail2.jsp";
	
	}
	

	 
}
