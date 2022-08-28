<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>탈퇴 완료</title>

<style>
	body{
	
		text-align: center;
	}
	
</style>
</head>
<body>
<fieldset>
		<legend>탈퇴 완료</legend>
탈퇴 완료 했습니다.
<input type="button" value="창닫기 " onclick="closed()"/>
</fieldset>
<script>

	function closed(){
		window.close();
		window.opener.close();
	}
	
</script>
</body>
</html>

