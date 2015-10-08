<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div style="border:1px solid; float:left">
	
	<div id="map" style="height: 400px; width:400px"></div>	
	
</div>


<input type="button" value="일정저장" onclick="register();"/>
	
<form action="" name="planForm" method="post">	
	
	<script type="text/javascript">
	function register(){
		
		var f = document.planForm;
		
		f.action = "<%=cp%>/register.action";
		f.submit();
	}
	</script>
	<script>
	var areaCode;
	var sigunguCode;
	var map;
	var directionsDisplay;
	var directionsService;
	var geocoder;
	function initMap() {
	
		alert("지도 왜안그려져");
		directionsDisplay = new google.maps.DirectionsRenderer;
		directionsService = new google.maps.DirectionsService;
		
		geocoder = new google.maps.Geocoder();
		
	  map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 12,
	    center: {lat: 37.5, lng: 127.037}  
	  });
	  
	 
}
	
	$("#btn").click(function(){
		$.ajax({
			type:"GET",
			//url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&numOfRows=10&_type=json",
			url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+ "&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json",
			dataType:"json",		
			success:function(data){
				if(data.response.body.items.item.length==0){
					alert("데이터가 없습니다.");
				}else{ 
					var secretMessages = new Array(data.response.body.totalCount);
					var mapy;
					var mapx;
					
					for(i=0;i<data.response.body.items.item.length;i++){	
						var obj = data.response.body.items.item[i];
						//var contentid = data.response.body.items.item[i].contentid;
						//alert(data.response.body.items.item[i].contentid);
						secretMessages[i]='<div><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/>&nbsp;&nbsp;<input type="hidden" id="contentid" name="contentid" value="'+data.response.body.items.item[i].contentid+'"/>'
						+'<input type="hidden" id="mapy" name="mapy" value="'+data.response.body.items.item[i].mapy+'"/><input type="hidden" id="mapx" name="mapx" value="'+data.response.body.items.item[i].mapx+'"/><input type="button" value="일정에 추가" id="sel" onclick="choice();"/> <br/>'+data.response.body.items.item[i].title+'</div>';

						if(keyFind(obj, 'mapx')){
							//alert(i+"주소좌표변환필요");
							$.ajax({
								type:"GET",
								url:"http://maps.googleapis.com/maps/api/geocode/json?address="+obj.addr1+"&language=ko&sensor=false",
								dataType:"json",		
								async:false,
								success:function(data){
									mapx=data.results[0].geometry.location.lng;
									mapy=data.results[0].geometry.location.lat;
									
								
								},error:function(e){	alert("1111111111"+e.responseText);
								}
							});
						} else{
							mapy=obj.mapy;
							mapx=obj.mapx;
							
						}  
						
						//alert(i + " : " + mapy);
						var itemsXY = new google.maps.LatLng(mapy,mapx);
						var itemsMarker=new google.maps.Marker({ //마커
						  	  position:itemsXY,
						  		 map: map
						  	  });
						attachSecretMessage(itemsMarker, secretMessages[i]);
						    
					}
					
					
				}  
		
			},error:function(e){
				alert("1111111111"+e.responseText);
			}
		});
	
	});
	
	var address1="${address2}";
	var address2;

	

	var durTime
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
	   var chk = 0;
<%-- 	function choice(){
		var contentid = $("#contentid").val();

		$.ajax({
			type:"GET",
			url:"<%=cp%>/choice?durTime="+durTime+"&endTime="+'${endTime}'+"&contentid=" + contentid,
			success:function(data){
				
			},
			error:function(e){
				alert("1111111111"+e.responseText);
			}
			
		});
	}
	 --%>
	
	//var jbAry = new Array();
	 //일정추가부분?
	//var buffer = new Array();                        쓰는부분업길래 
	
	//검색을 할때 empty하도록
	<%-- $("#result").empty();
	function choice(){
		 alert($("#contentid").val());
		 buffer.push($("#contentid").val());
		
		// alert("여기는?");
		// alert(contentid);
		// alert(areaCode);
			$.ajax({
				type:"POST",
				//url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&numOfRows=10&_type=json",
				url:"<%=cp%>/choice",
				//data:"contentid=" + contentid,
				data:"areaCode="+areaCode,
				dataType:"json",		
				success:function(data){
				
					if(data.response.body.totalCount==0){
						$("#result").append('데이터가 없습니다.');
						
					}else{
						
						for(j=chk;j<buffer.length;j++){
							chk=buffer.length;
							//alert(buffer.length);
							//alert(j);
							for(i=0;i<data.response.body.totalCount;i++){	
								//alert("아놔"+data.response.body.items.item[i].title);
								 //alert(buffer.length);
								if(data.response.body.items.item[i].contentid==buffer[j]){
									
									$("#result").append('<div><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/><input type="hidden" name="contentid" value="' + buffer[j] +'"/>'
									+'<select id="longTime"><option value="0">소요시간</option><option value="30">30분</option><option value="60">1시간</option><option value="90">1시간30분</option><option value="120">2시간</option><option value="150">2시간30분</option><option value="180">3시간</option><option value="210">3시간30분</option><option value="240">4시간</option></select><br/>'+data.response.body.items.item[i].title+'</div><br/>');
									
									//alert("d" + buffer[j]);
								}
							}
							//alert("두번째"  + buffer[j])
						}
					}
					
			
				},error:function(e){
					alert("1111111111"+e.responseText);
				}
			});
	 } --%>
	 
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
	

    </script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script>
		
	<script>
	$("#startsel").click(function(){
    	$.ajax({
			type:"GET",
			url:"<%=cp%>/startPlace?startDate=" + '${startDate}',
			dataType:"html",		
			success:function(data){
				$("#myModal").html(data);
				//alert(data);
				$("#myModal").modal();
			},
			error:function(e){
				alert("1111111111"+e.responseText);
			}
			
		});
        
    });

	
	

	</script>
	
	
	
  </form>
