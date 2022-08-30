package make.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import auth.service.User;
import make.service.MakeRequest;
import make.service.MakeRunService;
import member.service.JoinRequest;
//import make.service.MakeRunService;
import mvc.command.CommandHandler;


public class MakeRunHandler implements CommandHandler{
	private static final String FORM_VIEW = "make/makeRun.jsp";
	private MakeRunService makeRunSvc = new MakeRunService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) 
	throws Exception {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			System.out.println("gds");
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
		
		MakeRequest makeReq = new MakeRequest();
		
		makeReq.setLeader(user.getId());
		makeReq.setCapacity(Integer.parseInt(req.getParameter("lightMeet_capacity")));
		makeReq.setHour(Integer.parseInt(req.getParameter("lightMeet_hour")));
		makeReq.setMinute(Integer.parseInt(req.getParameter("lightMeet_minute")));
		makeReq.setGender(req.getParameter("lightMeet_gender"));
		makeReq.setKm(Float.valueOf(req.getParameter("lightMeet_km")));
		makeReq.setStartAge(Integer.parseInt(req.getParameter("lightMeet_startAge")));
		makeReq.setEndAge(Integer.parseInt(req.getParameter("lightMeet_endAge")));
		makeReq.setLatitude(req.getParameter("lightMeet_latitude"));
		makeReq.setLongitude(req.getParameter("lightMeet_longitude"));
		makeReq.setStartLat(req.getParameter("lightMeet_startLat"));
		makeReq.setStartLong(req.getParameter("lightMeet_startLong"));
	
		
		makeRunSvc.make(makeReq);
		return "/make/makeLightMeetSuccess.jsp";
	}
}
