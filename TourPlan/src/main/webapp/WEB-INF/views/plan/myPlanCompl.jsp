<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div class="container" style="width: 100%; height:100%;">

	<!-- body부분 전체묶기 -->
	<div style="width: 100%; height: 100%;">

 		<div style="width: 1072px; height:502px; border: 1px solid; border-color: #BDBDBD; margin-left: 10%;">
 		
		 	<div style="width: 1070px; height:400px;  background:url(/tourPlan/resources/image/1.png); background-size: corver; "></div>
	 		
	 		<div style="width: 1070px; height:100px; background-color: white;">
	 		
	 			<div style="font-size: 16pt; padding-top: 5px;">
	 				<b>E-mail</b>
	 			</div>
	 			
	 			<div style="font-size: 20pt;">
	 				<b>Title</b>
	 			</div>
	 			
	 			<div style="font-size: 10pt;">
	 				startDate ~ endDate
	 			</div>
	 		
	 		</div>
	 		
	 
	 	</div>
	 
		<div style="width: 1702px; margin-left: 10%;">
	 
			<!-- 여행 일정 뿌리는곳 -->
			<div style="width: 43%; float: left; margin-top: 2%;">
				
				<!-- 1 -->
				<div style="width: 100%; height:60px; border:1px solid; border-color: #BDBDBD;">
					<!-- day1 박스  -->
					<div style="background-color: #000042; width: 25%; height: 60px; text-align: center; float: left; overflow: hidden; ">
						<div style="color: white; font-size: 20pt; padding-top: 7%;"><b>DAY1</b></div>
					</div>
					
					<!-- 정보박스  -->
					<div style="background-color: white; width: 75%; height: 60px; float: left; overflow: hidden;">
						<div style="font-size: 12pt; color: #B3A197; padding-top: 3px; text-align: left;" >
							startDate 
						</div>
					
			
						<div style="font-size: 15pt; text-align: left; padding-top: 5px;">
							<b>지역코드</b>
						</div>
					</div>
					
				</div>
				<!-- 1 -->
			
		
		
				<div style="width: 100%; height: 20px; margin-top: 10px; margin-bottom: 10px;">
				Tour Start!!
				</div>

 			<c:forEach var="map" items="${lists}" varStatus="status">
 			
							<div style="width: 100%; height: 20px; font-size: 10pt;">
				최단거리 -> 
				</div>
		
				<!-- 2 -->
				<div style="width: 100%; height:100px; border:1px solid; border-color: #BDBDBD;">
					<!-- day1 박스  -->
					<div style="background-color: white; width: 25%; height: 100px; text-align: center; float: left; overflow: hidden; ">
						<div style="color: black; font-size: 20pt; padding-top: 15%;"><b>Tour : 1</b></div>
					</div>
					
					<!-- 정보박스  -->
					<div style="background-color: white; width: 20%; height: 100px; float: left; overflow: hidden;">
						<div style="margin-top: 10px; width: 75px; height: 75px; border:1px solid; border-color: #BDBDBD; " >
							<img alt="대표이미지" src="${map.firstimage }"> ${map.title}//${map.addr1}
						</div>
					</div>
					
					<div style="background-color: white; width: 55%; height: 100px; float: left; overflow: hidden; text-align: left: ;">
						<div style="font-size: 14pt; padding-top: 4%;">
							${map.content}
						</div>
						
					</div>
					<input type="hidden" name="planNum" value="${map.planNum }">
					<input type="hidden" name="groupNum" value="${map.groupNum }">
					<input type="hidden" name="contentid" value="${map.contentid }contentid">
					<input type="hidden" name="contenttypeid" value="${map.contenttypeid }contenttypeid">
					<input type="hidden" name="longTime" value="${map.longTime }longtime">
					<input type="hidden" name="content" value="${map.content }content">
					<input type="hidden" name="startDate" value="${map.startDate }startDate">
					
				</div>
				<!-- 2 -->
				


			</c:forEach>
</div>
			<!-- 여행 일정 뿌리는곳 -->
</div>

	</div>
	<!-- body부분 전체묶기 -->
	
</div>

<script>
	var map;
	var directionsDisplay;
	var directionsService;
	var geocoder;
	function initMap() {
	
		directionsDisplay = new google.maps.DirectionsRenderer;
		directionsService = new google.maps.DirectionsService;
		
		geocoder = new google.maps.Geocoder();
		
	  map = new google.maps.Map();
	  
	 
	}


	transitDisplay();
	function transitDisplay(){
			  <c:forEach var="map" items="${lists}" varStatus="status">
			  calculateAndDisplayRoute(directionsService, directionsDisplay, '${status.index}');
			  </c:forEach>
  
	 	function calculateAndDisplayRoute(directionsService, directionsDisplay, index) {            //대중교통길찾기
		  <c:forEach var="map" items="${lists}" varStatus="status">
			var test = '${status.index}';
			if(test==index){
				
	 		directionsService.route({
			    origin: new google.maps.LatLng('${map.mapy}','${map.mapx}'),
			    destination: new google.maps.LatLng('${map.mapyex}','${map.mapxex}'),
			    travelMode: google.maps.TravelMode.TRANSIT       //모드는 차량, 도보, 대중교통, 자전거 등이있음 TRANSIT은 대중교통
			  }, function(response, status) {          //성공시 response json형태의 정보를 받음. 
			    if (status === google.maps.DirectionsStatus.OK) {
			        var point = response.routes[0].legs[0];
			        $( '#travel_data${status.index}' ).html( '이동시간: ' + point.duration.text + ' (' + point.distance.text + ')' );
			    } else {
			      window.alert('Directions request failed due to ' + status);
			    }
			  });
			}
		</c:forEach>
			}
	}
					</script>
	
		
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script>
