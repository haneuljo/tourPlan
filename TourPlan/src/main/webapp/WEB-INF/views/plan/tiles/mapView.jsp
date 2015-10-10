<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div>
	
	<div id="map" style="height: 80%; width:600px;"></div>	
	
</div>

<input type="button" value="일정저장" onclick="register();"/>
	
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
	 function markerMap(){
			var sigunguCode = 0;
			alert("1");
			$.ajax({
				type:"GET",
				url:"<%=cp%>/travelMapClipCount?areaCode="+areaCode+"&sigunguCode="+sigunguCode,
				dataType:"json",		
				success:function(data){
					//alert(data);
					var secretMessages = new Array();
					var mapy;
					var mapx;
							
					$.each(data, function(index, value) {
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
								
						secretMessages[i]='<div><img style="width:200px; height:150px;"src="'+value.firstimage+'"/>&nbsp;&nbsp;<input type="hidden" id="contentid" name="contentid" value="'+value.contentid+'"/>'
						+'<input type="hidden" id="mapy" name="mapy" value="'+value.mapy+'"/><input type="hidden" id="mapx" name="mapx" value="'+value.mapx+'"/><input type="button" value="일정에 추가" id="sel" onclick="choice();"/> <br/>'+value.title+'</div>';

							
						var itemsXY = new google.maps.LatLng(value.mapy,value.mapx);
						var itemsMarker=new google.maps.Marker({
						  	  position:itemsXY,
					  	});
						itemsMarker.setMap(map);
						attachSecretMessage(itemsMarker, secretMessages[i]);
					});  
					},error:function(e){	alert("1111111111"+e.responseText);}
					
				});
			}
			// marker is clicked, the info window will open with the secret message
			function attachSecretMessage(marker, secretMessage) {
			  var infowindow = new google.maps.InfoWindow({
			    content: secretMessage
			  });
			  marker.addListener('click', function() {
			    infowindow.open(marker.get('map'), marker);
			    var mapx= $("#mapx").val();
				var mapy= $("#mapy").val();
				var itemsXY = new google.maps.LatLng(mapy,mapx);
				calculateAndDisplayRoute(directionsService, directionsDisplay, address1, itemsXY);
			  
			  });
				  
			}
				
			//json key값 있는지 판단
			function keyFind(obj, key){
				var chk=false;
				for (var j in obj) {
					if (!obj.hasOwnProperty(key)){
						chk=true;
						break;
					}
				}
			return chk;
					
		}
				
			function register(){
				
				var f = document.planForm;
				
				f.action = "<%=cp%>/register.action";
				f.submit();
			}


	var address1="${address2}";
	var address2;
	

	var durTime;
	function calculateAndDisplayRoute(directionsService, directionsDisplay, address1, address2) {            //대중교통길찾기
	  directionsService.route({
		  
	    origin: address1,
	    destination: address2,
	/*     transitOptions:{
	    	departureTime:new Date(1337675679473),
	    }, */
	    travelMode: google.maps.TravelMode.TRANSIT
	    
	  }, function(response, status) {
		  
	    if (status === google.maps.DirectionsStatus.OK) {
	    	
	    	
	      directionsDisplay.setDirections(response);
	     // alert("소요2:"+response.routes[0].legs[0].duration.value);
	      durTime = response.routes[0].legs[0].duration.value;
	      //choice();
	      
	    } else {
	      window.alert('Directions request failed due to ' + status);
	    }
	  });
}
	
	// var buffer = new Array();
	 //  var chk = 0;
	   function choice(){
	      // alert($("#contentid").val());
	      // buffer.push($("#contentid").val());
	       $.ajax({
	            type:"POST",
	            url:"<%=cp%>/choice",
	            data:"contentid=" + $("#contentid").val()+"&durTime="+durTime+"&endTime="+'${endTime}',
	            success:function(args){
	               $("#result").html(args);
	               alert(args);
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
