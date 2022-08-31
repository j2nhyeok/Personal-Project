<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script language=javascript>
moveTo(800,420)
resizeTo(450,230)
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>러닝 번개 생성 실패</title>
<style>
 .container {
        width: 100%;
        height: 100%;

      }
  #close{
  	  text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
  }
  
</style>

</head>
<body>
	<fieldset>
			<legend>러닝 번개 생성 실패</legend>
	이미 러닝 번개를 생성하였습니다. <br>
	(아이디당 1개의 번개만 생성할 수 있습니다.) <br>
	(기존 번개를 지우거나, 완료 후 생성해 주십시오.)
	
	<input type="button" value="창닫기 " onclick="allClose()"/>
	</fieldset>
	
	
	<script>
		function allClose(){
			window.close();
			opener.window.close();
			
		}
		
	
	</script>
</body>
</html>