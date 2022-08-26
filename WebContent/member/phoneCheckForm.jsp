<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.dao.BlacklistMemberDao" %>
<%@page import="member.dao.MemberDao" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전화번호 중복 확인</title>
	<style type="text/css">
		#wrap{
			width: 490px;
			text-align: center;
			margin: 0 auto 0 auto;
		}
		
		#cancelBtn{
			visibility: visible;
		}
		
		#useBtn{
			visibility: hidden;
		}
		
	
	</style> 
	
<script type="text/javascript">


		 function cantuse(){
			
						 document.getElementById("cancelBtn").style.visibility='visible';
						 document.getElementById("useBtn").style.visibility='hidden';
		 }
		 
		 function canuse(){
						  document.getElementById("cancelBtn").style.visibility='hidden'; 
						  document.getElementById("useBtn").style.visibility='visible'; 
			}
		

		// 사용하기 클릭 시 부모창으로 값 전달
		 function sendCheckValue(){
		// 중복체크 결과인 idCheck 값을 전달한다.
			    opener.document.login.phoneDuplication.value ="phoneCheck";
		// 창닫기 
			  window.close();
		} 
</script>
</head>
<body>
<%
	String phone = request.getParameter("phone");

	MemberDao memberDao = new MemberDao();
	BlacklistMemberDao blacklistMemberDao = new BlacklistMemberDao();
	
	
	
	int x = memberDao.duplicatePNCheck(phone); // x가 0일 경우 중복된 번호 없음. 1일 경우 중복된 번호 있음
	
	int y = blacklistMemberDao.duplicatePNCheck(phone); //y가 0일 경우 블랙리스트 번호 아님. 1일 겨우 블랙리스트 번호임.
	 
	 
	String temp = "";
	if(x == 1 || y ==1){
		temp = "이미 가입된 번호이거나, 블랙 리스트 번호입니다.";
	}
		
	else {
		temp = "사용 가능한 전화번호입니다.";
} 
%>

<%= temp %>
            <br>
        <input id="cancelBtn" type="button" value="확인" onclick="window.close()">
        <input id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()">

<%if(x == 1 || y ==1) { %>
<script>cantuse();</script>
<%}else{ %>
<script>canuse();</script>
<%} %>



</body>
</html>