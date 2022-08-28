<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<fieldset>
		<legend>로그인</legend>
		
		<form action="login.do" method="post">
			아이디 : <input type="text" name="id" required> <br>
			비밀번호 : <input type="password" name="password" required>
			<input type="submit" value="로그인"> <br>
			
			<br>
			
			<a href="join.do" onClick="window.open(this.href, '', 'width=400, height=730, left=800px, top=100px'); return false;">회원가입</a> |
			<a href="member/idFind.jsp" onClick="window.open(this.href, '', 'width=400, height=430, left=800px, top=100px'); return false;">아이디 찾기</a> |
			<a href="member/pwFind.jsp" onClick="window.open(this.href, '', 'width=400, height=430, left=800px, top=100px'); return false;">비밀번호 찾기</a> 
		</form>
	</fieldset>
</body>
</html>