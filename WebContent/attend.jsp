<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script language=javascript>
moveTo(800, 200)
resizeTo(500, 650)
</script>   

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
		
		#info{
			text-align: center;
		}
</style>
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>
<div id="info">
	<form action="attend.do" name="attend"  method="post"  id="attendform">
		<fieldset>
				<legend>러닝 번개 생성하기</legend>
					 번개장 : <input type="text" name="lightMeet_leader" readonly style="width:100px"> <br>
					 참가 확정 인원 : <input type="text" name="lightMeet_participant" readonly>  명<br>
					 모집 인원 : <input type="text" name="lightMeet_capacity" readonly>  명<br>
					 모집 시간 : <input type="text" name="lightMeet_hour" readonly  >시 <input type="text" name="lightMeet_minute" readonly  >분 <br>
					 모집 성별 : <input type="text" name="lightMeet_gender" readonly style="width:70px;"><br>
					 러닝 키로수 : 총  <input type="text" name="lightMeet_km" readonly style="width:70px;"> km <br>
					 나이 제한 : <input type="text" name="lightMeet_startAge" readonly>세 부터 <input type="text" name="lightMeet_endAge" readonly  >세 까지 <br>  
					
					<input type="button"  value="취소" onclick="window.close()" style="width:50px; height:20px" >
					<input type="submit"  value="참가 "  style="width:50px; height:20px">
					<input type="hidden" value="클릭한 러닝 번개 id" id="lightMeet_id" name="lightMeet_id">
		</fieldset>
	</form>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08fa980140200e6f083039f1504a1fad"></script>
<script>
/*  선택한 마커의 id를 가져와야하기때문에 제일 먼저 실행되어야 함. */
 $(document).ready(function(){ 
	   document.getElementById("lightMeet_id").value = opener.document.getElementById("clickRunId").value;
       
	   $.ajax({
		   type: "get",
		   url: 'lightmeet.do',
		   data : {lightMeet_id : document.getElementById("lightMeet_id").value },
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
			   
			   informations[10] = informations[10].replace("[", "");
			   informations[10] = informations[10].replace("]", "");
			   
			   informations[11] = informations[11].replace("[", "");
			   informations[11] = informations[11].replace("]", "");
			   
			  
			   
			   let latitudes = informations[10].split(", ");
			   let longitudes = informations[11].split(", ");
			 
			   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(parseFloat(latitudes[0]), parseFloat(longitudes[0])), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };

				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
				
	 			var linePath = [];
				
				for(var i = 0; i < latitudes.length; i++){
					linePath.push(new kakao.maps.LatLng(parseFloat(latitudes[i]), parseFloat(longitudes[i])));
				}
				var polyline = new kakao.maps.Polyline({
				    path: linePath, // 선을 구성하는 좌표배열 입니다
				    strokeWeight: 3, // 선의 두께 입니다
				    strokeColor: '#db4040', // 선의 색깔입니다
				    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid' // 선의 스타일입니다
				});

				// 지도에 선을 표시합니다 
				polyline.setMap(map); 
				
			var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
			   startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
			   startOption = { 
			       offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
			};

			// 출발 마커 이미지를 생성합니다
			var startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

			// 출발 마커가 표시될 위치입니다 
			var startPosition = new kakao.maps.LatLng(parseFloat(latitudes[0]), parseFloat(longitudes[0])); 
			
			var startMarker = new kakao.maps.Marker({
			    map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
			    position: startPosition,	    
			    image: startImage // 출발 마커이미지를 설정합니다
			});
			
			
			var arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
			arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
			arriveOption = { 
			    offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
			};

			// 도착 마커 이미지를 생성합니다
			var arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);
			
			// 도착 마커가 표시될 위치입니다 
			var arrivePosition = new kakao.maps.LatLng(parseFloat(latitudes[latitudes.length-1]), parseFloat(longitudes[longitudes.length-1]));    
			 
			// 도착 마커를 생성합니다 
			var arriveMarker = new kakao.maps.Marker({  
			    map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
			    position: arrivePosition,
			    image: arriveImage // 도착 마커이미지를 설정합니다
			});
			
		
			document.attend.lightMeet_leader.value = informations[1];
			document.attend.lightMeet_participant.value = informations[2];
			document.attend.lightMeet_capacity.value = informations[3];
			document.attend.lightMeet_hour.value = informations[4];
			document.attend.lightMeet_minute.value = informations[5];
			document.attend.lightMeet_gender.value = informations[6];
			document.attend.lightMeet_km.value = parseFloat(informations[7]);
			document.attend.lightMeet_startAge.value = informations[8];
			document.attend.lightMeet_endAge.value = informations[9];
			},
			 	error : function(request, status, error) { // 결과 에러 콜백함수
					alert("생성된 번개가 없어요.")
				}
	   })
}); 
</script>
</body>
</html>