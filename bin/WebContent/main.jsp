<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="auth.service.User"%>
<%
	User user = (User) request.getSession().getAttribute("authUser");
%>

<script language=javascript>
	moveTo(200, 120)
</script>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Place Information UI</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<style>
body {
	font-family: "맑은 고딕", "고딕", "굴림";
}

html, body {
	margin: 0px;
	padding: 0px;
}

#wrapper {
	width: 1300px;
	margin: 0 auto;
}

<
style>body {
	font-family: "Lato", sans-serif;
}

.sidenav {
	height: 100%;
	width: 0;
	position: fixed;
	z-index: 1;
	top: 0;
	right: 0;
	background-color: #111;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 60px;
}

.sidenav a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 25px;
	color: #818181;
	display: block;
	transition: 0.3s;
}

.sidenav a:hover {
	color: #f1f1f1;
}

.sidenav .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
	margin-left: 50px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 18px;
	}
}

span1 {
	position: absolute;
	right: 0;
	padding-right: 20px;
}

.currentXY {
	position: absolute;
	top: 130;
	left: 540;
	z-index: 10;
}

.currentXYBtn {
	position: absolute;
	top: 130;
	left: 620;
}

img {
	width: 30px;
}
</style>


<br>

<body1 class="choice">

<div class="currentXY">
	<button type="button" class="currentXYBtn" onclick="panTo()">
		<img src="../../images/currentXY.png" alt="">
	</button>
	<!-------------------------------------------------------------------------------------------------------------------------------->

</div>
<input type="hidden" value="" id="clickRunId">

<input type="button" value="러닝 번개 만들기" id="makeBtn" onclick="makeRun()">
<input type="button" value="새로고침" id="refreshBtn" onclick="refresh()">
<div id="mySidenav" class="sidenav">

	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<h2 style="color: white;">
		<%=user.getName()%>
		|
	</h2>
	<a href="logout.do" onclick="window.close()">로그아웃</a> <a
		href="changePwd.do"
		onclick="window.open(this.href, '', 'width=400, height=730, left=800px, top=100px'); return false;">비밀번호변경</a>
	<a href="secession.do"
		onclick="window.open(this.href, '', 'width=400, height=730, left=800px, top=100px'); return false;">회원탈퇴</a>
</div>
<span1 style="font-size:20px;cursor:pointer" onclick="openNav()">&#9776;
menu</span1> </body1>
<br>
<br>
<span id="menu"><span class="ion-navicon-round">
		<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	width: 1160px;
	height: 720px;
}
</style>
</head>
<body onresize="parent.resizeTo(1536, 852)"
	onload="parent.resizeTo(1536, 852)">

	<div id="wrapper">

		<div class="map_wrap">

			<div id="map" style="width: 98%; height: 100%;"></div>


			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08fa980140200e6f083039f1504a1fad"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);

				var locPosition = null;
				//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
				if (navigator.geolocation) {

					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation
							.getCurrentPosition(function(position) {

								var lat = position.coords.latitude, // 위도
								lon = position.coords.longitude; // 경도

										locPosition = new kakao.maps.LatLng(
												lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
										message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다

								// 마커와 인포윈도우를 표시합니다
								displayMarker(locPosition, message);

							});

				} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

					var locPosition = new kakao.maps.LatLng(33.450701,
							126.570667), message = 'geolocation을 사용할수 없어요..'

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
				//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl,
						kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

				function openNav() {
					document.getElementById("mySidenav").style.width = "250px";
				}
				function closeNav() {
					document.getElementById("mySidenav").style.width = "0";
				}

				function makeRun() {
					window.open("makeRun.do", '',
							'width=400, height=730, left=800px, top=100px');
					return false;
				}

				let markers = [];
				function refresh() {
					for (var i = 0; i < markers.length; i++) {
						markers[i].setMap(null);
					}

					markers.length=0; 
							$.ajax({
								type : 'get', // 타입 (get, post, put 등등)
								url : 'refresh.do', // 요청할 서버url
								async : true, // 비동기화 여부 (default : true)
								headers : { // Http header
									"Content-Type" : "application/json",
									"X-HTTP-Method-Override" : "GET"
								},
								dataType : 'json', // 데이터 타입 (html, xml, json, text 등등)

								success : function(data) { // 결과 성공 콜백함수

									let latitude = [];
									let longitude = [];

									latitude = data.Latslist;
									longitude = data.Longslist;
									id = data.idlist;
									
									for (var i = 0; i < latitude.length; i++) {

										var markerPosition = new kakao.maps.LatLng(
												latitude[i], longitude[i]);

										// 마커를 생성합니다
										var marker = new kakao.maps.Marker({
											position : markerPosition,
											clickable : true,
										// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
											title : id[i]
										});
										
										markers.push(marker);
										// 마커가 지도 위에 표시되도록 설정합니다
										marker.setMap(map);
						
							
										// 인포윈도우를 생성합니다
										kakao.maps.event.addListener(marker, 'click', function(){
											document.getElementById("clickRunId").value = String(this.getTitle());
										  openWin =  window.open('attend.jsp', '_blank', "width=500, height=650, left=800, top=200");
										});

									}
									
										
								},
								error : function(request, status, error) { // 결과 에러 콜백함수
									alert("생성된 번개가 없어요.")
								}
							})

				}
				
		
				
				
			</script>
</body>
</html>









