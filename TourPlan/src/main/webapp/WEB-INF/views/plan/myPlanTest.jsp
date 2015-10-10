<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
     <!-- drag JavaScript files -->
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-ui-1.8.custom.min.js"></script>
					
	<div id="example-1-1">
	<div id="map"></div>
		<div class="sortable-list" style="width: 450;float: left;">
			
 			<c:forEach var="map" items="${lists}" varStatus="status">
				<div id="sortable_item-${status.index}" style="border: solid 1px;">
					<div style="height: 120;width: 470" class="sortable-item">
					
					<div id="travel_data${status.index}"></div>
					
					<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${map.firstimage }"></div>
				 	<div> <h3>${map.title}//index:${status.index}</h3></div>
	 				<div> ${map.addr1} ${map.addr2 }</div>
	 				<div class="btn-group">
					   <button type="button" class="btn btn-primary">수정//${map.mapx}/${map.mapy}</button>
					   <button id="deleteTemp" type="button" class="btn btn-primary deleteTemp" data="${status.index}">삭제</button>
					</div>
					
					</div>
					<input type="hidden" name="planNum" value="${map.planNum }">
					<input type="hidden" name="groupNum" value="${map.groupNum }">
					<input type="hidden" name="mapx${status.index}" value="${map.mapx }">
					<input type="hidden" name="mapy${status.index}" value="${map.mapy }">
					<input type=""text"" name="contentid" value="${map.contentid }contentid">
					<input type=""text"" name="contenttypeid" value="${map.contenttypeid }contenttypeid">
					<input type=""text"" name="longTime" value="${map.longTime }longtime">
					<input type=""text"" name="content" value="${map.content }content">
					<input type=""text"" name="startDate" value="${map.startDate }startDate">
				</div>

			</c:forEach>
			
<%-- 			<c:forEach var="adto" items="${alists}" varStatus="i"> 
			<div style="height: 120;width: 600" class="sortable-item">
			<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${adto.firstimage }"></div>
				 	<div> <h3>${adto.title}</h3></div>
	 				<div> ${adto.addr1} ${adto.addr2 }</div>
			</div>
			</c:forEach> --%>
		</div>
<!-- 			<div id="right-panel"></div>
   			 <div id="map" style="width: 300px;height: 300px;float: right;"></div> -->
	</div>
	
<script>
					function initMap() {
						  alert("1");
						  var directionsDisplay = new google.maps.DirectionsRenderer;
						  var directionsService = new google.maps.DirectionsService;
						  
						  var geocoder = new google.maps.Geocoder(); 
						  
						  var map = new google.maps.Map({
						  });
						  <c:forEach var="map" items="${lists}" varStatus="status">
						  calculateAndDisplayRoute${status.index}(directionsService, directionsDisplay);
						  </c:forEach>
						}
					  
					  <c:forEach var="map" items="${lists}" varStatus="status">
					function calculateAndDisplayRoute${status.index}(directionsService, directionsDisplay) {            //대중교통길찾기
						  directionsService.route({
						    origin: {${map.mapy},${map.mapx}},
						    destination: {${map.mapyex},${map.mapxex}},
						    travelMode: google.maps.TravelMode.TRANSIT       //모드는 차량, 도보, 대중교통, 자전거 등이있음 TRANSIT은 대중교통
						  }, function(response, status) {          //성공시 response json형태의 정보를 받음. 
						    if (status === google.maps.DirectionsStatus.OK) {
						        var point = response.routes[0].legs[0];
						        $( '#travel_data${status.index}' ).html( '이동시간: ' + point.duration.text + ' (' + point.distance.text + ')' );
						        alert("11");
						    } else {
						      window.alert('Directions request failed due to ' + status);
						    }
						  });
						}
					</c:forEach>
					
					</script>
	
	<!-- Example jQuery code (JavaScript)  -->
		
		<script type="text/javascript">
		

		$(document).ready(function(){                                                                    //드래그앤 드랍 및 순서 업데이트
			
			$(".deleteTemp").click(function(){
				var del_index = $(this).attr("data");
				//alert(del_index);
		    	$.ajax({
		            type:"POST",
					url:"<%=cp%>/deleteTemp",
					data:"index="+del_index,	
					success:function(args){
				           $("#result").html(args);
					},
			        error:function(e){
			            alert(e.responseText);
			         }
					
				});
				
			});
	


			$('#example-1-1 .sortable-list').sortable({
			    axis: 'y',
			    update: function (event, ui) {
			        var data = $(this).sortable('serialize');
			        alert(data);
		 	        $.ajax({
		 	        	
			            data: data,
			            dataType:"json",
			            type: 'POST',
			            url: '<%=cp%>/orderUpdate'
			        }); 
			    }
			});
			
			
			

			
		});
		
		</script>
		
			<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script>
