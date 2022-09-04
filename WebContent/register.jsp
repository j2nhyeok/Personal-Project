<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>러닝 번개 참가</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <style>
		input{
	
			width:30px;
			height:15px;
			font-size:12px;
			text-align: center;
			
		}
</style>
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>
<div id="info">

	 번개장 : <input type="text" name="lightMeet_leader" readonly style="width:300px"> <br>
	 모집 인원 : <input type="text" name="lightMeet_capacity" readonly>  명<br>
	 모집 시간 : <input type="text" name="lightMeet_hour" readonly  >시 <input type="text" name="lightMeet_minute" readonly  >분 <br>
	 모집 성별 : <input type="text" name="lightMeet_gender" readonly style="width:70px;"><br>
	 러닝 키로수 : 총 <input type="text" name="lightMeet_km" readonly style="width:70px;"> km <br>
	 나이 제한 : <input type="text" name="lightMeet_startAge" readonly>세 부터 <input type="text" name="lightMeet_endAge" readonly  >세 까지 <br>  
	
	<input type="button">
	<input type="button">
		<input type="hidden" value="클릭한 러닝 번개 id" id="clickRunId">
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08fa980140200e6f083039f1504a1fad"></script>
<script>
/*  선택한 마커의 id를 가져와야하기때문에 제일 먼저 실행되어야 함. */
 $(document).ready(function(){ 
	   document.getElementById("clickRunId").value = opener.document.getElementById("clickRunId").value;
       
	   $.ajax({
		   type: "get",
		   url: 'lightmeet.do',
		   data : {lightMeet_id : document.getElementById("clickRunId").value },
		   async : true, // 비동기화 여부 (default : true)
		   headers : { // Http header
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "GET"
		   },
		   dataType : 'json', // 데이터 타입 (html, xml, json, text 등등)
		   success : function(data){
			   var informations = [];
			   
			   informations = data.informations;
			   console.log(informations);
			   console.log(informations[10]);
			   var arr = informations[10].split(", ");
			  
			
		   },
		   error : function(request, status, error) { // 결과 에러 콜백함수
				alert("생성된 번개가 없어요.")
			}
	   
		   
	   })
	   
	
}); 



var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</body>
</html>