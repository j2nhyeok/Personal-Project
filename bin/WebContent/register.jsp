<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>지도 생성하기</title>
    
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>
<div id="info">

	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="text"><br>
	<input type="button">
	<input type="button">
		<input type="hidden" value="클릭한 러닝 번개 id" id="clickRunId">
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08fa980140200e6f083039f1504a1fad"></script>
<script>
/*  선택한 마커의 id를 가져와야하기때문에 제일 먼저 실행되어야 함. */
 $(document).ready(function(){ 
	   document.getElementById("clickRunId").value = opener.document.getElementById("clickRunId").value;
	   console.log(document.getElementById("clickRunId").value);
       
	
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