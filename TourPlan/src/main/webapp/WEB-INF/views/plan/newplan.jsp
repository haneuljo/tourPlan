<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>
<!DOCTYPE>
<html>
<head>
  <title>Bootstrap Case</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  
   <style>
  .modal-header, h4, .close {
      background-color: #5cb85c;
      color:white !important;
      text-align: center;
      font-size: 30px;
  }
  .modal-footer {
      background-color: #f9f9f9;
  }
  
	*{
	margin:0;
	padding:0;
	}
	html,body{height:100%;}
	#map{height: 100%;}
  </style>
  <script>
	$(document).ready(function(){
	    $("#sign").click(function(){
	    	$.ajax({
				type:"GET",
				url:"<%=cp%>/signModal",
				dataType:"html",		
				success:function(data){
					$("#myModal").html(data);
					$("#myModal").modal();
				},
				error:function(e){
					alert("1111111111"+e.responseText);
				}
				
			});
	        
	    });
	    $("#login").click(function(){
	    	$.ajax({
				type:"GET",
				url:"<%=cp%>/loginModal",
				dataType:"html",		
				success:function(data){
					$("#myModal").html(data);
					$("#myModal").modal();
				},
				error:function(e){
					alert("1111111111"+e.responseText);
				}
				
			});
	        
	    });
	});
	
	 
  </script>
  
  <script type="text/javascript">
	function register(){
		
		var f = document.planForm;
		
		f.action = "<%=cp%>/register.action";
		f.submit();
	}
  
  
  
  </script>
  
</head>

<body>

<!-- ---- 모든 jsp 일단 복사 ---- -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">WebSiteName</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Page 1-1</a></li>
            <li><a href="#">Page 1-2</a></li>
            <li><a href="#">Page 1-3</a></li>
          </ul>
        </li>
        <li><a href="#">여행일정</a></li>
        <li><a href="#">Page 3</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      
      	<c:choose>
      	
      	 <c:when test="${empty sessionScope.loginInfo.email }">
      	
        <li id="sign"><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
        <li id="login"><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:when>
	        <c:otherwise>
	        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="#">Page 1-1</a></li>
	            <li><a href="<%=cp%>/planInfo.action">여행일정</a></li>
	            <li><a href="<%=cp%>/">회원정보수정</a></li>
	            <li><a href="<%=cp%>logout.action">로그아웃</a></li>
	          </ul>
	       </li>
	       </c:otherwise>
       </c:choose>
      </ul>
    </div>
  </div>
</nav>


<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    
  </div> 
<!-- ---- 여기까지 모든 jsp 일단 복사 ---- -->  
  
<div class="container">
  <h3>여행지선택${startDate}</h3>
  지역 :
	<select id="selectArea" style="width: 116px;">
		<option value="0">선택</option>
	</select>
	<!-- <select id="selectSubArea" style="width: 116px;">
		<option value="0">선택</option>
	</select> -->
	<button id="btn">검색</button>
	<button id="startsel">출발지선택</button>
	<div id="map"></div>
	
	
<form action="" name="planForm" method="post">	
	<script>
	var areaCode;
	var sigunguCode;
	var map;
	
	
	function initMap() {
	
	  map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 12,
	    center: {lat: 37.5, lng: 127.037}  
	  });
	  
	  $.ajax({
		  type:"GET",
		  url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&numOfRows=17&MobileOS=ETC&MobileApp=AppTesting&_type=json",
		  dataType:"json",
		  success:function(data){	
			$('#selectArea').empty();
			$("#selectArea").append('<option value="0">선택</option>');
			for(i=0;i<data.response.body.items.item.length;i++){	
				$("#selectArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
			}
		},error:function(e){}
	  });
	  $("#selectArea").change(function(){
		  areaCode=$("#selectArea option:selected").val();
		  //지역별로 시구군 코드가 다르므로 !!! numOfRows check할것
		  $.ajax({
			type:"GET",
			url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&MobileOS=ETC&MobileApp=AppTesting",
			dataType:"json",		
			success:function(data){
				$('#selectSubArea').empty();
				$("#selectSubArea").append('<option value="0">선택</option>');
				for(i=0;i<data.response.body.items.item.length;i++){	
					$("#selectSubArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
				}
			},error:function(e){}
		});
	});
	/* $("#selectSubArea").change(function(){
		sigunguCode=$("#selectSubArea option:selected").val();
	}); */
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
						secretMessages[i]='<div><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/>&nbsp;&nbsp;<input type="hidden" id="contentid" name="contentid" value="'+data.response.body.items.item[i].contentid+'"/><input type="button" value="일정에 추가" id="sel" onclick="choice();"/> <br/>'+data.response.body.items.item[i].title+'</div>';
						
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
	
	//var jbAry = new Array();
	 //일정추가부분?
	var buffer = new Array();
	var chk = 0;
	//검색을 할때 empty하도록
	$("#result").empty();
	function choice(){
		 alert($("#contentid").val());
		 buffer.push($("#contentid").val());
		
		// alert("여기는?");
		// alert(contentid);
		// alert(areaCode);
			$.ajax({
				type:"POST",
				//url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&numOfRows=10&_type=json",
				url:"<%=cp%>/choice.action",
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
									+'<br/>'+data.response.body.items.item[i].title+'</div><br/>');
									
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
	
	<div id="result"></div>
	<input type="button" value="일정저장" onclick="register();"/>
  </form>
</div>

</body>
</html>
