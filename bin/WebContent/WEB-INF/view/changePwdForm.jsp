<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script language=javascript>
moveTo(800,350)
resizeTo(460, 297)
</script>

<!DOCTYPE html>
<html>
<head>
<title>암호 변경</title>
</head>
<body>

<fieldset>
		<legend>비밀번호 변경하기</legend>
		
<form action="changePwd.do" method="post">
<p>
	현재 비밀번호:<br/><input type="password" name="curPwd" placeholder="8 ~ 15자 영문, 숫자, 특수문자를 최소 한가지씩 조합" style="width:320px;"><br>
	<c:if test="${errors.curPwd}">현재 비밀번호를 입력하세요.</c:if>
	<c:if test="${errors.badCurPwd}">현재 비밀번호가 일치하지 않습니다.</c:if>
</p>
<p>
	새 비밀번호:<br/><input type="password" name="newPwd" placeholder="8 ~ 15자 영문, 숫자, 특수문자를 최소 한가지씩 조합" style="width:320px;"><br>
	<c:if test="${errors.newPwd}">새 비밀번호를 입력하세요.</c:if>
	<c:if test="${errors.notMatchNewPwd }"> 새 비밀번호가 정규 표현식에 맞지 않습니다.</c:if>
</p>
<input type="submit" value="비밀번호 변경">
</form>
</fieldset>
</body>
</html>