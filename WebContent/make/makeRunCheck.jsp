<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="auth.service.User"%>
<%
	User user = (User) request.getSession().getAttribute("authUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>러닝 번개 생성 확인창</title>
  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>

	<form>
		<fieldset>
			<legend>러닝 번개 생성하기</legend>
			    번개장 : <%=user.getName() %> <br>
			    모집 인원 : <span id="lightMeet_capacity"></span><br> 명
			    모집 시간 : <span id="lightMeet_Date"></span> <span id="lightMeet_hour"></span>시  <span id="lightMeet_minute"></span>분 <br>
			    모집 성별 : <span id="lightMeet_gender"></span><br>
			    러닝 키로수 : 총 <span id="lightMeet_km"></span> km <br>
			    나이 제한 : <span id="lightMeet_startAge"></span>세 부터 <span id="lightMeet_endAge"></span>세 까지 <br>  
			  
			  <input type="button" id="cancelBtn" name="cancelBtn" value="취소하기" onclick="window.close()">
			  <input type="submit" id="makeBtn" name="makeBtn" value="생성하기" onclick="window.close()">
			    
		</fieldset>
	</form>
	
	<script>
	$(document).ready(function(){
		document.getElementById("lightMeet_capacity").innerHTML = $("#lightMeet_capacity", opener.document).val();
		document.getElementById("lightMeet_Date").innerHTML = $("#lightMeet_Date", opener.document).val();
		document.getElementById("lightMeet_hour").innerHTML = $("#lightMeet_hour", opener.document).val();
		document.getElementById("lightMeet_minute").innerHTML = $("#lightMeet_minute", opener.document).val();
		document.getElementById("lightMeet_gender").innerHTML = $("#lightMeet_gender", opener.document).val();
		document.getElementById("lightMeet_km").innerHTML = $("#lightMeet_km", opener.document).val() *  $("#turn", opener.document).val() ;
		document.getElementById("lightMeet_startAge").innerHTML = $("#lightMeet_startAge", opener.document).val();
		document.getElementById("lightMeet_endAge").innerHTML = $("#lightMeet_endAge", opener.document).val();
		
	})
	</script>
</body>
</html>