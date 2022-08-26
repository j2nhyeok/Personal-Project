<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="auth.service.User" %>


<script language=javascript>
moveTo(800,350)
resizeTo(460, 297)
</script>

    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴하기</title>
</head>
<body>
<fieldset>
		<legend>탈퇴하기</legend>
<form action="secession.do" method = "POST">
	<p>
		암호:<br/><input type="password" name="curPwd">
		<c:if test="${errors.curPwd}"> 암호를 입력하세요.</c:if>
		<c:if test="${errors.badCurPwd}"> 암호가 일치하지 않습니다.</c:if>
	</p>
			<input type="submit" value="탈퇴하기"> 
 </form>
 </fieldset>
</body>
</html>