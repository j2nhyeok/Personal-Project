<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="member.dao.MemberDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<style>
	   
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	MemberDao dao = new MemberDao();
	String id = dao.findId(name, phone); //아이디를 디비에서 가져옴..실패시 널
	%>

	<fieldset>
	<form name="idsearch" method="post">
		<%
			if (id != "") {
		%>
		<div class="container">
			<div class="found-success">
				<h4>회원님의 아이디는</h4><%=id%><h4>입니다</h4>
			</div>
			<div class="found-login">
				<input type="button" id="close" value="닫기" onClick='window.close()' />
			</div>
		</div>
		<%
			} else {
		%>
		<div class="container">
			<div class="found-fail">
				<h4>등록된 정보가 없습니다</h4>
			</div>
			<div class="found-login">
				<input type="button" id="btnback" value="다시 찾기"
					onClick="history.back()" /> 
				<input type="button" id="close" value="닫기" onClick='window.close()' />
			</div>
		</div>

		<div class="adcontainer">
		
		</div>
		<%
			}
		%>
	</form>
	</fieldset>
</body>
</html>