<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.dao.MemberDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			    opener.document.login.idDuplication.value ="idCheck";
		// 창닫기 
			  window.close();
		} 
</script>
</head>
<body>
<%
	String checkId = request.getParameter("id");

	MemberDao memberDao = new MemberDao();
	
	Boolean dupleOK = memberDao.duplicateIdCheck(checkId);
	
	String temp = "";
	if(dupleOK){
		temp = "중복된 아이디가 있습니다. 다시 입력해주세요.";
	}
		
	else {
		temp = "사용 가능한 아이디입니다.";
} 
%>

<%= temp %>
            <br>
        <input id="cancelBtn" type="button" value="확인" onclick="window.close()">
        <input id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()">

<%if(dupleOK) { %>
<script>cantuse();</script>
<%}else{ %>
<script>canuse();</script>
<%} %>



</body>
</html>