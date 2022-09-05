<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script language=javascript>
moveTo(830,440)
resizeTo(450,180)
</script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>    
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String leader = request.getParameter("lightMeet_leader");
%>
</head>
<body>
	<fieldset>
			<legend>러닝 번개  참가</legend>
	해당 러닝 번개에 참가 하시겠습니까? <br>
	<input type="button" value="돌아가기" onclick="history.back()"/>
	<input type="button" value="참가하기 " onclick="window.close()"/>
	</fieldset>
</body>
</html>