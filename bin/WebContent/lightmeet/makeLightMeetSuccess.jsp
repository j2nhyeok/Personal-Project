<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script language=javascript>
moveTo(830,440)
resizeTo(450,180)
</script>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>러닝 번개 생성 완료</title>

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
			<legend>러닝 번개  생성 완료</legend>
	정상적으로 러닝 번개를 생성하였습니다. <br>
	
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