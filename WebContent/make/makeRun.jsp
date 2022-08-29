<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="auth.service.User"%>
<%
	User user = (User) request.getSession().getAttribute("authUser");
%>
<script language=javascript>
	moveTo(200, 120)
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>러닝 번개 생성</title>
<style>

body {
	background-color: black;
}

#makeform{
	position:absolute;
	background-color: white;
	margin: -760px 0 0  1200px;
	width: 22%;
	height: 100%;
}

.currentXY{

position:absolute;
  top:130;
  left:540;
  z-index:10;
}

.lightMeet_time{ /* 시간을 입력받는 input칸 크기 조절 */
	width: 60px;
	height: 20px;
}

#lightMeet_startAge{
	width: 40px;
	height: 20px;
}

#lightMeet_endAge{
	width: 40px;
	height: 20px;
}

.currentXYBtn{
position:absolute;

  top:130;
  left:620;
}
/* 
.makeBtn{
position:absolute;
   top:100;
  left:510;

} */


img{
	width: 30px;
}

.dot {
	overflow: hidden;
	float: left;
	width: 12px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');
}

.dotOverlay {
	position: relative;
	bottom: 10px;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	float: left;
	font-size: 12px;
	padding: 5px;
	background: #fff;
}

.dotOverlay:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.number {
	font-weight: bold;
	color: #ee6152;
}

.dotOverlay:after {
	content: '';
	position: absolute;
	margin-left: -6px;
	left: 50%;
	bottom: -8px;
	width: 11px;
	height: 8px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')
}

.distanceInfo {
	position: relative;
	top: 5px;
	left: 5px;
	list-style: none;
	margin: 0;
}

.distanceInfo .label {
	display: inline-block;
	width: 50px;
}

.distanceInfo:after {
	content: none;
}
</style>
</head>

<body onresize="parent.resizeTo(1536, 852)" onload="parent.resizeTo(1536, 852)">

	<div id="map" style="width: 80%; height: 750px;"></div>
	
<!-------------------------------현위치 버튼 생성---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  -->
	<div class="currentXY"> 
	<button type="button" class="currentXYBtn" onclick="panTo()"><img src="../../images/currentXY.png" alt=""></button>
<!-------------------------------------------------------------------------------------------------------------------------------->		
		
	</div>
	
	<form name="make"  id="makeform" >
		<fieldset>
		<legend>러닝 번개 생성하기</legend>
	   	    번개장 : <%=user.getName() %> 
	   	<br>
   		    모집 인원 : <input type="number" id="lightMeet_capacity" name="lightMeet_capacity" placeholder="최소인원 2(명)" min="02" >명
   		<br>
   		    모임 시간 : <select id = "lightMeet_Date" name="lightMeet_Date" style="width:60px; height:22px; font-size:12px; ">
      			 	  <option value="오늘">오늘</option>
      				  <option value="내일">내일</option>
     			   </select>
     			   <input type="time" id="whatTime" name="whatTime"/>
     			   
      			   <input type="hidden"  name="hour" id="lightMeet_hour" value="">
      			   <input type="hidden"  name="minute" id="lightMeet_minute" value="">
      
   		<br>
   		  모집 성별 :  <select id = "lightMeet_gender" name="lightMeet_gender" style="width:70px; height:22px; font-size:12px; ">
      			  	   <option value="제한없음">제한없음</option>	
      			  	   <option value="남성">남성</option>
     			       <option value="여성">여성</option>
     		   	   </select>
   		<br>
   		    러닝 키로수 :  <input type="text" id="lightMeet_km" readonly style="width:70px; height:22px; font-size:12px; "/>km   X   
   		    		  <input type="number" id="turn" name="turn" value="1" style="width:40px; height:22px; font-size:12px;"  min="1" max="100"  />바퀴  <br>

   		<br>
   		       나이 제한 :  <input type="number" id="lightMeet_startAge" name="lightMeet_startAge" placeholder="0" min="00" max="99" >세부터
   		  		      <input type="number" id="lightMeet_endAge" name="lightMeet_endAge" placeholder="99" min="00" max="99" >세까지		
		    
	
			<input type="button" id="cancleBtn" value="취소하기" onclick="window.close()"> 
			<input type="button" id="makeBtn" value="생성하기" onclick="makeFunc()"> 
		</fieldset>
	</form>

<!-------------------------------카카오 맵 생성---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08fa980140200e6f083039f1504a1fad"></script>
	<script>
	

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
		var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
		var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
			let arr = []; // 위도와 경도를 저장할 그런 그런 배열
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 마우스로 클릭한 위치입니다 
			var clickPosition = mouseEvent.latLng;
			arr.push(mouseEvent.latLng);
			console.log(arr);
			// 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
			if (!drawingFlag) {

				// 상태를 true로, 선이 그리고있는 상태로 변경합니다
				drawingFlag = true;

				// 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
				deleteClickLine();

				// 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
				deleteDistnce();

				// 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
				deleteCircleDot();

				// 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
				clickLine = new kakao.maps.Polyline({
					map : map, // 선을 표시할 지도입니다 
					path : [ clickPosition ], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
					strokeWeight : 3, // 선의 두께입니다 
					strokeColor : '#db4040', // 선의 색깔입니다
					strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
					strokeStyle : 'solid' // 선의 스타일입니다
				});

				// 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
				moveLine = new kakao.maps.Polyline({
					strokeWeight : 3, // 선의 두께입니다 
					strokeColor : '#db4040', // 선의 색깔입니다
					strokeOpacity : 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
					strokeStyle : 'solid' // 선의 스타일입니다    
				});

				// 클릭한 지점에 대한 정보를 지도에 표시합니다
				displayCircleDot(clickPosition, 0);

			} else { // 선이 그려지고 있는 상태이면

				// 그려지고 있는 선의 좌표 배열을 얻어옵니다
				var path = clickLine.getPath();

				// 좌표 배열에 클릭한 위치를 추가합니다
				path.push(clickPosition);

				// 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
				clickLine.setPath(path);

				var distance = Math.round(clickLine.getLength());
				displayCircleDot(clickPosition, distance);
			}
		});

		// 지도에 마우스무브 이벤트를 등록합니다
		// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
		kakao.maps.event
				.addListener(
						map,
						'mousemove',
						function(mouseEvent) {

							// 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
							if (drawingFlag) {

								// 마우스 커서의 현재 위치를 얻어옵니다 
								var mousePosition = mouseEvent.latLng;

								// 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
								var path = clickLine.getPath();

								// 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
								var movepath = [ path[path.length - 1],
										mousePosition ];
								moveLine.setPath(movepath);
								moveLine.setMap(map);

								var distance = Math.round(clickLine.getLength()
										+ moveLine.getLength()), // 선의 총 거리를 계산합니다
								content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">'
										+ distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다

								// 거리정보를 지도에 표시합니다
								showDistance(content, mousePosition);
							}
						});

		// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
		// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
		kakao.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
			let deepArr = JSON.parse(JSON.stringify(arr));
			arr.length=0;
			console.log(deepArr);
			// 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
			if (drawingFlag) {

				// 마우스무브로 그려진 선은 지도에서 제거합니다
				moveLine.setMap(null);
				moveLine = null;

				// 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
				var path = clickLine.getPath();

				// 선을 구성하는 좌표의 개수가 2개 이상이면
				if (path.length > 1) {

					// 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
					if (dots[dots.length - 1].distance) {
						dots[dots.length - 1].distance.setMap(null);
						dots[dots.length - 1].distance = null;
					}

					var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
				
					content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다

					// 그려진 선의 거리정보를 지도에 표시합니다
					showDistance(content, path[path.length - 1]);

				} else {

					// 선을 구성하는 좌표의 개수가 1개 이하이면 
					// 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
					deleteClickLine();
					deleteCircleDot();
					deleteDistnce();

				}

				// 상태를 false로, 그리지 않고 있는 상태로 변경합니다
				drawingFlag = false;
			}
		});

		// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
		function deleteClickLine() {
			if (clickLine) {
				clickLine.setMap(null);
				clickLine = null;
			}
		}

		// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
		// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
		function showDistance(content, position) {

			if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면

				// 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
				distanceOverlay.setPosition(position);
				distanceOverlay.setContent(content);

			} else { // 커스텀 오버레이가 생성되지 않은 상태이면

				// 커스텀 오버레이를 생성하고 지도에 표시합니다
				distanceOverlay = new kakao.maps.CustomOverlay({
					map : map, // 커스텀오버레이를 표시할 지도입니다
					content : content, // 커스텀오버레이에 표시할 내용입니다
					position : position, // 커스텀오버레이를 표시할 위치입니다.
					xAnchor : 0,
					yAnchor : 0,
					zIndex : 3
				});
			}
		}

		// 그려지고 있는 선의 총거리 정보와 
		// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
		function deleteDistnce() {
			if (distanceOverlay) {
				distanceOverlay.setMap(null);
				distanceOverlay = null;
			}
		}

		// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
		function displayCircleDot(position, distance) {

			// 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
			var circleOverlay = new kakao.maps.CustomOverlay({
				content : '<span class="dot"></span>',
				position : position,
				zIndex : 1
			});

			// 지도에 표시합니다
			circleOverlay.setMap(map);

			if (distance > 0) {
				// 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
				var distanceOverlay = new kakao.maps.CustomOverlay(
						{
							content : '<div class="dotOverlay">거리 <span class="number">'
									+ distance + '</span>m</div>',
							position : position,
							yAnchor : 1,
							zIndex : 2
						});

				// 지도에 표시합니다
				distanceOverlay.setMap(map);
			}

			// 배열에 추가합니다
			dots.push({
				circle : circleOverlay,
				distance : distanceOverlay
			});
		}

		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
		function deleteCircleDot() {
			var i;

			for (i = 0; i < dots.length; i++) {
				if (dots[i].circle) {
					dots[i].circle.setMap(null);
				}

				if (dots[i].distance) {
					dots[i].distance.setMap(null);
				}
			}

			dots = [];
		}

		// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
		// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
		// HTML Content를 만들어 리턴하는 함수입니다
		function getTimeHTML(distance) {
			// 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
			var walkkTime = distance / 67 | 0;
			var walkHour = '', walkMin = '';

			// 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
			if (walkkTime > 60) {
				walkHour = '<span class="number">' + Math.floor(walkkTime / 60)
						+ '</span>시간 '
			}
			walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

			// 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
			var bycicleTime = distance / 227 | 0;
			var bycicleHour = '', bycicleMin = '';

			// 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
			if (bycicleTime > 60) {
				bycicleHour = '<span class="number">'
						+ Math.floor(bycicleTime / 60) + '</span>시간 '
			}
			bycicleMin = '<span class="number">' + bycicleTime % 60
					+ '</span>분'

			// 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
			var content = '<ul class="dotOverlay distanceInfo">';
			content += '    <li>';
			content += '        <span class="label">총거리</span><span class="number">'
					+ distance/1000 + '</span>km';
			// 러닝 km칸에 km수 표시		
			document.getElementById("lightMeet_km").value = distance/1000;
			content += '    </li>';
			content += '    <li>';
			content += '        <span class="label">도보</span>' + walkHour
					+ walkMin;
			content += '    </li>';
			content += '    <li>';
			content += '        <span class="label">자전거</span>' + bycicleHour
					+ bycicleMin;
			content += '    </li>';
			content += '</ul>'

			return content;
		}
		
			var locPosition = null;
			//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
			if (navigator.geolocation) {
				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
				navigator.geolocation.getCurrentPosition(function(position) {

					var lat = position.coords.latitude, // 위도
					lon = position.coords.longitude; // 경도

					locPosition	 = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
					message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다

					// 마커와 인포윈도우를 표시합니다
					displayMarker(locPosition, message);

				});
			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
				message = 'geolocation을 사용할수 없어요..'

				displayMarker(locPosition, message);
			}
			// 지도에 마커와 인포윈도우를 표시하는 함수입니다
			function displayMarker(locPosition, message) {

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : locPosition
				});
				var iwContent = message, // 인포윈도우에 표시할 내용
				iwRemoveable = true;

				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
					content : iwContent,
					removable : iwRemoveable
				});

				// 인포윈도우를 마커위에 표시합니다 
				infowindow.open(map, marker);

				// 지도 중심좌표를 접속위치로 변경합니다
				map.setCenter(locPosition);
			}
			function panTo() {
			    // 이동할 위도 경도 위치를 생성합니다 
			    var moveLatLon = locPosition;
			    // 지도 중심을 부드럽게 이동시킵니다
			    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
			    map.panTo(moveLatLon);            
			}
		
<!---------------------------일반 뷰 , 스카이뷰 토글--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->				
		//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

<!---------------------------일반 뷰 , 스카이뷰 토글--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->						
		
		function makeFunc(){
			var lightMeet_capacity =  parseInt($("#lightMeet_capacity").val());
			var whatTime =  $("#whatTime").val();
			var lightMeet_km =  parseFloat($("#lightMeet_km").val());
			var lightMeet_startAge =  parseInt($("#lightMeet_startAge").val());
			var lightMeet_endAge =  parseInt($("#lightMeet_endAge").val());
			
			
			if(lightMeet_capacity == "" || lightMeet_capacity < 2){
	    		   alert("모집인원을 다시 확인해주세요 (최소 2명 이상)");
	    		   return;
	    	}
			
			if(whatTime == "" ){
				   alert("모임시간을 선택해주세요.");
	    		   return;
	    	}
			
			if(lightMeet_km == "" ){
					alert("러닝 km를  다시 확인해주세요.");
	    		   return;
	    	}
			
			if(lightMeet_startAge == "" || lightMeet_startAge < 0){
	    		   alert("참가 가능한 최소 나이를 다시 확인해주세요.");
	    		   return;
	    	}
			
			if(lightMeet_endAge == "" || lightMeet_endAge > 100 || lightMeet_endAge < lightMeet_startAge){
					console.log(lightMeet_startAge);
					console.log(lightMeet_endAge);
	    		   alert("참가 가능한 최대 나이를 다시 확인해주세요.");
	    		   return;
	    	}
			
			
			
			document.make.hour.value = $("#whatTime").val().slice(0, 2);
			document.make.minute.value = $("#whatTime").val().slice(3);
			window.open("makeRunCheck.jsp", "_blank", "width=500, height=250, left=800, top=200");
		}
	</script>
<!---------------------------일반 뷰 , 스카이뷰 토글--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
</body>
</html>