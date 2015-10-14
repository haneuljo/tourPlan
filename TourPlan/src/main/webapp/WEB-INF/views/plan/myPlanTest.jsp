<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
     <!-- drag JavaScript files -->
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-ui-1.8.custom.min.js"></script>

	<div id="example-1-1">
		<div class="sortable-list">

 			<c:forEach var="map" items="${lists}" varStatus="status">
 			
				<div id="travel_data${status.index}"class="travel_data"></div>
 			
				<div id="sortable_item-${status.index}">
				
					<div class="sortable-item">
					<div class="sortItem_firstImg"><img alt="대표이미지" src="${map.firstimage }"></div>
				 		<div class="sortContent">
						 	<div class="sortItem_title"> <span>${map.title}<%-- //index:${status.index} --%></span></div>
			 				<div class="sortItem_addr"> <span> ${map.addr1}<%--  ${map.addr2 } --%></span> </div>
			 				<select id="lonTime" class="form-control sortItem_time" data="${status.index}">
			 					<option value="0">0</option>
			 					<option value="30">30분</option>
			 					<option value="60">1시간</option>
			 					<option value="90">1시간30분</option>
			 					<option value="120">2시간</option>
			 					<option value="150">2시간30분</option>
			 					<option value="180">3시간</option>
			 				</select>
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
	
		
	<!-- 		<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script> -->

	
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
		
 			$(".sortItem_time").change(function(){
				var time_index = $(this).attr("data");
				//alert(del_index);
		    	$.ajax({
		            type:"POST",
					url:"<%=cp%>/longTime",
					data:"index="+time_index+"&longTime="+$(".sortItem_time").val(),	
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
		 	        $.ajax({
 
			            type:"POST",
			            url: '<%=cp%>/orderUpdate',
		            	data: data,
			            dataType:"html",	
						success:function(args){
							//alert(args);
					        $("#result").html(args);
					        transitDisplay();
						},
				        error:function(e){
				            alert(e.responseText);
				         }
			        }); 
			    }
			});
		});
		
		</script>
