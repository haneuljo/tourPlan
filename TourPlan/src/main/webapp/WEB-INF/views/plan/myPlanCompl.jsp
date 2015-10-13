<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>


 			<c:forEach var="map" items="${lists}" varStatus="status">
 			
				<div id="travel_data${status.index}"class="travel_data"></div>
 			
				<div id="sortable_item-${status.index}">
				
					<div class="sortable-item">
					<div class="sortItem_firstImg"><img alt="대표이미지" src="${map.firstimage }"></div>
				 		<div class="sortContent">
						 	<div class="sortItem_title"> <span>${map.title}<%-- //index:${status.index} --%></span></div>
			 				<div class="sortItem_addr"> <span> ${map.addr1}<%--  ${map.addr2 } --%></span> </div>
			 				<div class="sortBtnGroup">
				 				<div class="sortBtn"><span class="glyphicon glyphicon-wrench"></span></div>
				 				<div id="deleteTemp" class="deleteTemp sortBtn" data="${status.index}"><span class="glyphicon glyphicon-trash"></span></div>
			 				</div>
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
				
				


			</c:forEach>

	
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
