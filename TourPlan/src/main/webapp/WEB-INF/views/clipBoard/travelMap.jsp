<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>
<div class="container">
  <div id="areaContainer">
	<div id="seoul" class ="area area0">서울</div>
	<div id="incheon" class ="area area1">인천</div>
	<div id="daejeon" class ="area area2">대전</div>
	<div id="daogu" class ="area area3">대구</div>
	<div id="gwangju" class ="area area4">광주</div>
	<div id="busan" class ="area area5">부산</div>
	<div id="ulsan" class ="area area6">울산</div>
	<div id="sejong" class ="area area7">세종</div>
	<div id="gyeonggi" class ="area area8">경기도<span class="caret"></span></div>
	<div id="gangwon" class ="area area9">강원도<span class="caret"></span></div>
	<div id="chungbuk" class ="area area10">충청북도<span class="caret"></span></div>
	<div id="chungnam" class ="area area11">충청남도<span class="caret"></span></div>
	<div id="sigungu1" class="sigungu"></div>
	<div id="gyeongbuk" class ="area area12">경상북도<span class="caret"></span></div>
	<div id="gyeongnam" class ="area area13">경상남도<span class="caret"></span></div>
	<div id="jeonnam" class ="area area14">전라북도<span class="caret"></span></div>
	<div id="jeonbuk" class ="area area15">전라남도<span class="caret"></span></div>
	<div id="jeju" class ="area area16">제주도</div>
	<div id="sigungu2" class="sigungu"></div>

  </div>
  <script>
	var areaCode;
	var sigunguCode=0;
	var map;
	
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 12,
	    center: {lat: 37.5, lng: 127.037}  
	  });
	  $.ajax({
	 		type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
				var count=0;
				for(i=0;i<data.response.body.items.item.length;i++){	
					$(".area"+i).attr("data", data.response.body.items.item[i].code);
					$(".area"+i).attr("index", count);

					if((i+1)%6==0 || i==data.response.body.items.item.length-1){
						count++;
					}
				}
			},
				error:function(e){
					//alert("1111111111"+e.responseText);
				}
		});
	}
	$(".area").click(function(){
		areaCode=$(this).attr('data');
		//alert(areaCode);
		//alert($(this).children("span").length);
		if($(this).children("span").length==1){
			var index=$(this).attr('index');
			//alert(index);
			$(".sigugun").hide();
			$.ajax({
				type:"GET",
				url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
				dataType:"json",		
				success:function(data){
					$("#sigungu"+index).empty();
					//alert(data);
					for(i=0;i<data.response.body.items.item.length;i++){
						$("#sigungu"+index).append('<div class="sigungu_info" data="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</div>');
														
					}  
					
					$("#sigungu"+index).show();
					$("#sigungu"+index+" div").bind("click", function(){
						
						sigunguCode = $(this).attr('data');
						//alert(sigunguCode);
						markerMap();
					});
						
				},	error:function(e){alert("1111111111"+e.responseText);}
			});		
		}else{
			markerMap();
		}
		
	});
 

	function markerMap(){
	
		$.ajax({
			type:"GET",
			url:"<%=cp%>/travelMapClipCount?areaCode="+areaCode+"&sigunguCode="+sigunguCode,
			dataType:"json",		
			success:function(data){
				
				var secretMessages = new Array();
				
				var mapy;
				var mapx;
				
				
				$.each(data, function(index, value) {
					secretMessages[i]='<div><img style="width:200px; height:150px;"src="'+value.firstimage+'"/> <br/>'+value.title+'</div>';
					
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
							
							},error:function(e){	alert("1111111111"+e.responseText);
							}
						});
					} else{
						mapy=value.mapy;
						mapx=value.mapx;
						
					}
					
					var itemsXY = new google.maps.LatLng(value.mapy,value.mapx);

					var itemsMarker=new google.maps.Marker({
					  	  position:itemsXY,
					  	  });
					    itemsMarker.setMap(map);
						attachSecretMessage(itemsMarker, secretMessages[i]);
				});  
				 
		
					
			
			},
			error:function(e){
				alert("1111111111"+e.responseText);
			}					
		
		});
	}
	// marker is clicked, the info window will open with the secret message
	function attachSecretMessage(marker, secretMessage) {
	  var infowindow = new google.maps.InfoWindow({
	    content: secretMessage
	  });

	  marker.addListener('click', function() {
	    infowindow.open(marker.get('map'), marker);
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
	<div id="map"></div>
</div>
