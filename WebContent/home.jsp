<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript">
function joinPopup() { window.open("join.do", "join", "width=500, height=650, left=800, top=200"); }
function loginPopup() { window.open("login.do", "login", "width=400, height=150, left=800, top=350"); }

</script>

<style>
#testImg {
	postiion: relative;
	width: 700px;
	height: 350px;
}

button.joinBtn {
  display: inline-block;
    text-align: center;
	position: absolute;
	top: 600px;
	left: 800px;
	width: 80px;
	height: 40px;
	background-color: blue;
	border: none;
	border-radius: 5px;
	color: white;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	cursor: pointer;
	
}

button.joinBtn:hover {
	background-color: #4CAF50;
	color: white;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19);
}

button.loginBtn {
  text-align: center;
  display: inline-block;
	position: absolute;
	top: 600px;
	left: 1100px;
	width: 80px;
	height: 40px;
	background-color: blue;
	border: none;
	border-radius: 5px;
	color: white;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	cursor: pointer;
}

button.loginBtn:hover {
	background-color: #4CAF50;
	color: white;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19);
}
</style>
</head>
<body>
	<div id="testImg">
		<img src="images/home.png" width="1890" height="1000" alt="홈 이미지." />
		<button class="joinBtn" type="button" onclick="joinPopup();">회원가입</button>
		<button class="loginBtn" type="button" onclick="loginPopup();">로그인</button>
	</div>
</body>
</html>