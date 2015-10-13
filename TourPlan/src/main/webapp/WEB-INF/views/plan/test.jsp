<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"></script> 

<script
src="http://maps.googleapis.com/maps/api/js">
</script>


<script>
var map;
var myCenter=new google.maps.LatLng(37.5665350,126.9779690);

function initialize()
{
var mapProp = {
  center:myCenter,
  zoom:15,
  panControl:true,
  zoomControl:true,
  mapTypeControl:true,
  scaleControl:true,
  streetViewControl:true,
  overviewMapControl:true,
  rotateControl:true,    
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };

  map = new google.maps.Map(document.getElementById("map"),mapProp);
  
  google.maps.event.addListener(map, 'click', function(event) {
    placeMarker(event.latLng);
  });
  marker.setMap(null);
}

function placeMarker(location) {
  var marker = new google.maps.Marker({
    position: location,
    map: map,
  });
  var infowindow = new google.maps.InfoWindow({
    content: '위도: ' + location.lat() + '<br>경도: ' + location.lng()
  });
  infowindow.open(map,marker);
  
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>

  

 	
  
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
		
		
		
		
				<!-- 2 -->
				<div style="width: 100%; height:100px; border:1px solid; border-color: #BDBDBD;">
					<!-- day1 박스  -->
					<div style="background-color: white; width: 25%; height: 100px; text-align: center; float: left; overflow: hidden; ">
						<div style="color: black; font-size: 20pt; padding-top: 15%;"><b>Tour : 1</b></div>
					</div>
					
					<!-- 정보박스  -->
					<div style="background-color: white; width: 20%; height: 100px; float: left; overflow: hidden;">
						<div style="margin-top: 10px; width: 75px; height: 75px; border:1px solid; border-color: #BDBDBD; " >
							firstimage2
						</div>
					</div>
					
					<div style="background-color: white; width: 55%; height: 100px; float: left; overflow: hidden; text-align: left: ;">
						<div style="font-size: 14pt; padding-top: 4%;">
							Content
						</div>
						
					</div>
					
				</div>
				<!-- 2 -->
				
				<div style="width: 100%; height: 20px; font-size: 10pt;">
				최단거리 -> 
				</div>
				
				<!-- 3 -->
				<div style="width: 100%; height:100px; border:1px solid; border-color: #BDBDBD;">
					<!-- day1 박스  -->
					<div style="background-color: white; width: 25%; height: 100px; text-align: center; float: left; overflow: hidden; ">
						<div style="color: black; font-size: 20pt; padding-top: 15%;"><b>Tour : 2</b></div>
					</div>
					
					<!-- 정보박스  -->
					<div style="background-color: white; width: 20%; height: 100px; float: left; overflow: hidden;">
						<div style="margin-top: 10px; width: 75px; height: 75px; border:1px solid; border-color: #BDBDBD; " >
							firstimage2
						</div>
					</div>
					
					<div style="background-color: white; width: 55%; height: 100px; float: left; overflow: hidden; text-align: left: ;">
						<div style="font-size: 14pt; padding-top: 4%;">
							Content
						</div>
						
					</div>
					
				</div>
				<!-- 3 -->
				
				<div style="width: 100%; height: 20px; font-size: 10pt;">
				최단거리 -> 
				</div>
				
				<!-- 4 -->
				<div style="width: 100%; height:100px; border:1px solid; border-color: #BDBDBD;">
					<!-- day1 박스  -->
					<div style="background-color: white; width: 25%; height: 100px; text-align: center; float: left; overflow: hidden; ">
						<div style="color: black; font-size: 20pt; padding-top: 15%;"><b>Tour : 3</b></div>
					</div>
					
					<!-- 정보박스  -->
					<div style="background-color: white; width: 20%; height: 100px; float: left; overflow: hidden;">
						<div style="margin-top: 10px; width: 75px; height: 75px; border:1px solid; border-color: #BDBDBD; " >
							firstimage2
						</div>
					</div>
					
					<div style="background-color: white; width: 55%; height: 100px; float: left; overflow: hidden; text-align: left: ;">
						<div style="font-size: 14pt; padding-top: 4%;">
							Content
						</div>
						
					</div>
					
				</div>
				<!-- 4 -->
				
				<div style="width: 100%; height: 20px; font-size: 10pt;">
				최단거리 -> 
				</div>
		
		
		
			</div>
			<!-- 여행 일정 뿌리는곳 -->
			
			
			
			<!-- 지도  -->
			<div style="float: left; padding-left: 2%; margin-top: 2%;">
				<div id="map" style="width: 300px; height: 300px; border:1px solid; border-color: #BDBDBD;"></div>
			</div>
			<!-- 지도 -->

		</div>

	</div>
	<!-- body부분 전체묶기 -->
	
</div>

