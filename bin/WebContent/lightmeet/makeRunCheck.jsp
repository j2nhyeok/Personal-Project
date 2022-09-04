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
<style>
input{

	width:30px;
	height:15px;
	font-size:12px;
}


</style>
</head>
<body>

	<form name="makeRunCheck" action="/makeRun.do" method="post"  id="makeRunCheckform">
		<fieldset>
			<legend>러닝 번개 생성하기</legend>
			    번개장 : <%=user.getId() %> <br>
			    모집 인원 : <input type="text" name="lightMeet_capacity" readonly>  명<br>
			    모집 시간 : <input type="text" name="lightMeet_hour" readonly  >시 <input type="text" name="lightMeet_minute" readonly  >분 <br>
			    모집 성별 : <input type="text" name="lightMeet_gender" readonly style="width:70px;"><br>
			    러닝 키로수 : 총 <input type="text" name="lightMeet_km" readonly style="width:70px;"> km <br>
			    나이 제한 : <input type="text" name="lightMeet_startAge" readonly>세 부터 <input type="text" name="lightMeet_endAge" readonly  >세 까지 <br>  
			  
			  
			   
			  <input type="hidden" id="lightMeet_latitude" name="lightMeet_latitude" value="" > <br>
			  <input type="hidden" id="lightMeet_longitude" name="lightMeet_longitude" value="" >
			  <input type="hidden" id="lightMeet_startLat" name="lightMeet_startLat" value="" >
			  <input type="hidden" id="lightMeet_startLong" name="lightMeet_startLong" value="" >
					  
			  <input type="button" id="cancelBtn" name="cancelBtn" value="취소하기" onclick="window.close()" style="width:70px; height: 22px;">
			  <input type="submit" id="makeBtn" name="makeBtn" value="생성하기"  style="width:70px; height: 22px;">
			    
		</fieldset>
	</form>
	
	<script>
	$(document).ready(function(){
		document.makeRunCheck.lightMeet_capacity.value = $("#lightMeet_capacity", opener.document).val();
		document.makeRunCheck.lightMeet_hour.value = $("#lightMeet_hour", opener.document).val();
		document.makeRunCheck.lightMeet_minute.value = $("#lightMeet_minute", opener.document).val();
		document.makeRunCheck.lightMeet_gender.value = $("#lightMeet_gender", opener.document).val();
		document.makeRunCheck.lightMeet_km.value = $("#lightMeet_km", opener.document).val() *  $("#turn", opener.document).val() ;
		document.makeRunCheck.lightMeet_startAge.value = $("#lightMeet_startAge", opener.document).val();
		document.makeRunCheck.lightMeet_endAge.value = $("#lightMeet_endAge", opener.document).val();
		document.makeRunCheck.lightMeet_latitude.value = $("#lightMeet_latitude", opener.document).val();
		document.makeRunCheck.lightMeet_longitude.value = $("#lightMeet_longitude", opener.document).val();
		document.makeRunCheck.lightMeet_startLat.value = $("#lightMeet_startLat", opener.document).val();
		document.makeRunCheck.lightMeet_startLong.value = $("#lightMeet_startLong", opener.document).val();
	})
	</script>
</body>
</html>