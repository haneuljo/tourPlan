<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<div>

	<div id="map" style="height: 100%; width: 100%;"></div>

</div>


<form action="" name="planForm" method="post">

	<script type="text/javascript">
	var map;
	var directionsDisplay;
	var directionsService;
	var geocoder;
	function initMap() {
	
		directionsDisplay = new google.maps.DirectionsRenderer;
		directionsService = new google.maps.DirectionsService;
		
		geocoder = new google.maps.Geocoder();
		
	  map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 12,
	    center: {lat: 37.5, lng: 127.037}  
	  });
	  
	 
	}
	var image='/tourPlan/resources/marker/12.png';
	var itemsMarker  = [];
	 function markerMap(contentTypeId){
			var sigunguCode = 0;

			$.ajax({
				type:"GET",
				url:"<%=cp%>/travelMapClipCount?areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&contentTypeId="+contentTypeId,
				dataType:"json",		
				success:function(data){
					//alert(data);
					
					var secretMessages = new Array();
					var mapy;
					var mapx;
					$("#areaList").empty();
					$.each(data, function(index, value) {
						$("#areaList").append('<div class="clipMapView_info"><img src="'+value.firstimage+'"/><div class="clipMapViewContent"><div class="clipMapView_info_title">'+value.title+'</div><div class="clipMapView_info_span"><span class="glyphicon glyphicon-send"></span>'+value.clipCount+'</div></div></div>');
						 
						if(keyFind(value, 'mapx')){
							//alert(i+"주소좌표변환필요");
							$.ajax({
								type:"GET",
								url:"http://maps.googleapis.com/maps/api/geocode/json?address="+obj.addr1+"&language=ko&sensor=false",
								dataType:"json",		
								async:false,
								success:function(data){
									mapx=data.results[0].geometry.location.lng;
									mapy=data.results[0].geometry.location.lat;
								
								},error:function(e){	alert("1111111111"+e.responseText);	}
							});
						} else{
							mapy=value.mapy;
							mapx=value.mapx;
						}
								
						secretMessages[i]='<div class="clipMapViewInfoWindow"><img alt="대표이미지"src="'+value.firstimage+'"/><div>'+value.title+'</div><button id="sel" onclick="choice();">일정추가</button><input type="hidden" id="contentid" name="contentid" value="'+value.contentid+'"/><input type="hidden" id="mapy" name="mapy" value="'+value.mapy+'"/><input type="hidden" id="mapx" name="mapx" value="'+value.mapx+'"/></div>';
						addMarker(value.mapy, value.mapx, secretMessages[i]);
					});  
					},error:function(e){	alert("1111111111"+e.responseText);}
					
				});
			}
	 
	 	
			// Adds a marker to the map and push to the array.
				//var image='/tourPlan/resources/maker/관광지.png';
			
			 function addMarker(mapy, mapx, msg) {
			/* 	  var image = {
						    url: '/tourPlan/resources/marker/12.png',
						    size: new google.maps.Size(100,100),
						    //origin: new google.maps.Point(0, 0),
						   // anchor: new google.maps.Point(0, 32)
						  };
  */
 				//var image = '/tourPlan/resources/marker/12.png';
				var itemsXY = new google.maps.LatLng(mapy,mapx);
				
				var addMarker=new google.maps.Marker({
					 position:itemsXY,
				     map: map,
				     icon:image
			  	});
				itemsMarker.push(addMarker);
				attachSecretMessage(addMarker, msg);
							
			 }
		
			 // Sets the map on all markers in the array.
			 function setMapOnAll(map) {
			   for (var i = 0; i < itemsMarker.length; i++) {
				   itemsMarker[i].setMap(map);
			   }
			 }
		
			 // Removes the markers from the map, but keeps them in the array.
			 function clearMarkers() {
			   setMapOnAll(null);
				 itemsMarker = [];
			 }
		
				// marker is clicked, the info window will open with the secret message
			function attachSecretMessage(marker, secretMessage) {
			  var infowindow = new google.maps.InfoWindow({
			    content: secretMessage
			  });
			  marker.addListener('click', function() {
			    infowindow.open(marker.get('map'), marker);
			 /*    var mapx= $("#mapx").val();
				var mapy= $("#mapy").val();
				var itemsXY = new google.maps.LatLng(mapy,mapx);
				calculateAndDisplayRoute(directionsService, directionsDisplay, address1, itemsXY); */
			  
			  });
				  
			}
				
				
			function register(){
				
				var f = document.planForm;
				
				f.action = "<%=cp%>/register.action";
				f.submit();
			}

	
	// var buffer = new Array();
	 //  var chk = 0;
	   function choice(){
	      // alert($("#contentid").val());
	      // buffer.push($("#contentid").val());
	      var endTime = $("#endTime").val();
	     // alert(endTime);
	       $.ajax({
	            type:"POST",
	            url:"<%=cp%>/choice",
	            dataType:"html",
	            data:"contentid=" + $("#contentid").val()+"&durTime="+durTime+"&endTime="+endTime,
	            success:function(args){
	               $("#result").html(args);
	              // alert(args);
	            },
	            error:function(e){
	               alert(e.responseText);
	            }
	       });
	            
	    }


    </script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script>




</form>
