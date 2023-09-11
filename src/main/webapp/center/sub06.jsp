<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
 <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=590vefx5go"></script>
</script>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/center/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<img src="../images/center/left_title.gif" alt="센터소개 Center Introduction" class="left_title" />
				<%@ include file="../include/center_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/center/sub07_title.gif" alt="오시는길" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;센터소개&nbsp;>&nbsp;오시는길<p>
				</div>
				<div class="con_box">
					<p class="con_tit"><img src="../images/center/sub07_tit01.gif" alt="오시는길" /></p>
					<div id="map" style="width: 700px; height: 300px; margin:auto"></div>
			  
					
					  <script>
					
					      var map = new naver.maps.Map('map', {
					          center: new naver.maps.LatLng(37.569730, 126.984257), // 잠실 롯데월드를 중심으로 하는 지도
					          zoom: 18
					      });
					
					      var marker = new naver.maps.Marker({
					          position: new naver.maps.LatLng(37.569730, 126.984257),
					          map: map
					      });
					
					  </script>
					
					
					<p class="con_tit" style="padding-top:12px"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스</p>
						<p style="margin-bottom:15px;">101번, 103번, 143번, 150번, 160번, 201번, 260번, 262번, 270번, 271번, <br>
													273번, 370번, 470번, 501번, 720번, 721번, 741번, 7212번 종로2가(중)에서 하차  </p>
						<p class="dot_tit">지하철</p>
						<p style="margin-bottom:15px;">1호선-종각역 4번, 9번 출구 사이 스타벅스 끼고 골목으로 들어가서 전방 50m직진 (우측 1층 GS편의점건물 7층)<br /> </p>
						<p class="dot_tit">마을버스</p>
						<p>종로01, 종로02번 종각역YMCA에서 하차</p>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
