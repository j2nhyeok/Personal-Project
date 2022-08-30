package member.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import member.service.JoinRequest;
import member.service.JoinService;
import mvc.command.CommandHandler;

public class JoinHandler implements CommandHandler {

	private static final String FORM_VIEW = "/member/join.jsp";
	private JoinService joinService = new JoinService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req, res);
		} else if (req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req, res);
		} else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}

	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}

	private String processSubmit(HttpServletRequest req, HttpServletResponse res) {
		//db�뿉 �꽔�뼱�빞 �븯�뒗 �옉�뾽�쓣 �뿬湲곗꽌 �빐�빞 �븿.
		
		// �엯�젰�맂 ���샃瑜� joinReq濡� �삷源�.
		JoinRequest joinReq = new JoinRequest();
		joinReq.setId(req.getParameter("id"));
		joinReq.setPw(req.getParameter("pw"));
		joinReq.setName(req.getParameter("name"));
		joinReq.setYear(req.getParameter("year"));
		joinReq.setMonth(req.getParameter("month"));
		joinReq.setDate(req.getParameter("date"));
		joinReq.setGender(req.getParameter("gender"));
		joinReq.setEmail(req.getParameter("email"));
		joinReq.setPhoneNumber(req.getParameter("phone"));
			
			joinService.join(joinReq);
			return "/WEB-INF/view/joinSuccess.jsp";
		
	}
}
