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
  <link rel="stylesheet" href="<%=cp%>/resources/css/travelMain.css" type="text/css"/>
<!--   
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
  
  
  </style> -->
<%--   <script>
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
  </script> --%>
  
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
        <li><a href="<%=cp%>/travel">여행지</a></li>
        <li><a href="<%=cp%>/planInfo.action">여행일정</a></li>
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
	            <li><a href="#">Page 1-2</a></li>
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
<div id="areaContainer"></div>
<div id="map"></div>
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"
		async defer></script>

  <script>
	var areaCode;
	var sigunguCode;
	var map;
	function initMap() {
	
	  map = new google.maps.Map($("#map"), {
	    zoom: 12,
	    center: {lat: 37.5, lng: 127.037}  
	  });
	  
	  $.ajax({
	 		type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
					
				var count=1;
				for(i=0;i<data.response.body.items.item.length;i++){	
					$("#areaContainer").append('<div id="area" data="'+data.response.body.items.item[i].code+'"index="'+count+'">'+data.response.body.items.item[i].name+'<span></span></div>');
					
					if((i+1)%6==0 || i==data.response.body.items.item.length-1){
						$("#areaContainer").append('<div id="sigugun'+count+'"data="'+data.response.body.items.item[i].code+'" index="'+count+'"></div>');
						count++;
					}
				}
				$("#areaContainer div:has(span)").bind("click", function(){
					areaCode=$(this).attr('data');
					//alert(areaCode);
					if($(this).attr('id')=="area"){
						var index=$(this).attr('index');
						//alert(index);
						$.ajax({
							type:"GET",
							url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
							dataType:"json",		
							success:function(data){
								$("#sigugun"+index).empty();
								//alert(data);
								for(i=0;i<data.response.body.items.item.length;i++){
									$("#sigugun"+index).append('<div id="segugun_info" data="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'<a></div>');
								}  
							
								$("#sigugun"+index+" div").bind("click", function(){
									sigunguCode = $(this).attr('data');
									$.ajax({
										type:"GET",
										url:"<%=cp%>/clipCount?areaCode="+areaCode+"&sigugunCode="+sigunguCode,
										dataType:"json",		
										success:function(data){
											
											$.each(data, function(index, value) {
												var itemsXY = new google.maps.LatLng(value.mapy,value.mapx);

												var itemsMarker=new google.maps.Marker({
												  	  position:itemsXY,
												  	  });
												    itemsMarker.setMap(map);
											});  
											 
											
											alert(data);
						
										},
										error:function(e){
											alert("1111111111"+e.responseText);
										}					
									
									});
								});
									
							},	error:function(e){alert("1111111111"+e.responseText);}
						});		
					}
					
				});
			},
				error:function(e){
					//alert("1111111111"+e.responseText);
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
	
	
  
</div>

</body>
</html>
