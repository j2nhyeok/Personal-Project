package lightmeet.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import auth.service.User;
import lightmeet.service.MakeRequest;
import lightmeet.service.MakeRunService;
import mvc.command.CommandHandler;


public class attendHandler implements CommandHandler{
	private static final String FORM_VIEW = "main.jsp";
	private MakeRunService makeRunSvc = new MakeRunService();
	
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
		User user = (User)req.getSession().getAttribute("authUser");
		
		String lightMeet_leader = req.getParameter("lightMeet_leader"));
		
		
	
		if(result == 1)	return "/lightmeet/makeLightMeetSuccess.jsp";
		else return "/lightmeet/makeLightMeetFail.jsp";
	
	}
}
