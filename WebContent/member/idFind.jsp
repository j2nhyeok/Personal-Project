<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script language=javascript>
moveTo(800,350)
resizeTo(460, 297)
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<style>
 	h3{
 	 text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
 	}
 	
  .form-search{
  	  text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
  } 
  
  .btnSearch{
  	text-align: center;
  }
</style>

</head>
<body>
<fieldset>
		<legend>아이디 찾기</legend>
<form name="idfindscreen" method = "POST">
			<div class = "search-title">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "find-name">
				<label>이름</label>
				<input type="text" name="name" class = "btn-name" placeholder = "등록한 이름">
			<br>
			</div>
			<div class = "find-phone">
				<label>번호</label>
				<input type="text" onKeyup = "addHypen(this);" name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="찾기"  onClick="id_search()">
		<input type="button" name="cancle" value="취소" onClick="window.close()">
 	</div>
 </form>
 </fieldset>
 <script>
 
 function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("핸드폰번호를 정확하게 입력해주세요");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "/member/findIdResult.jsp"; //넘어간화면
	 frm.submit();  
	 }
 
 </script>
 
 <body>
</html>