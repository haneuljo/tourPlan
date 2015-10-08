<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<title>TourPlan</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="<%=cp%>/resources/css/travelMain.css" type="text/css"/>
  
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
  

  <script >
  	
  	/* $(document).ready(function(){
  		
  		
  	} */
  	
  	function delclip(cd) {
  		
  		var f = document.Aform;
  		
  		f.action = "<%=cp%>/deletedclip.action?contentid=" + cd;
  		f.submit();
		
	}
  	
	function addclip(cd) {
  		
  		var f = document.Aform;
  		
  		f.action = "<%=cp%>/clipLike.action?contentid=" + cd;
  		f.submit();
		
	}
	
	function initMap() {
		
		 var f = document.Aform;
		
		var x = f.mapx.value;
		var y = f.mapy.value;
		 
		  var myCenter=new google.maps.LatLng(y,x);
		  
		  var mapOptions = {
				  zoom: 16,
				  center: myCenter,
				  mapTypeId: google.maps.MapTypeId.SATELLITE
				};

		  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

		  var marker = new google.maps.Marker({
		    position: myCenter,
		    map: map,
		    title: 'title'
		  });
		  
		}
  
  
  </script>

</head>
<body>

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
	            <li><a href="<%=cp%>/myClip">My ClipList</a></li>
	            <li><a href="<%=cp%>/planInfo.action">여행일정</a></li>
	            <li><a href="<%=cp%>/">회원정보수정</a></li>
	            <li><a href="<%=cp%>/logout.action">로그아웃</a></li>
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
  

  <div style="width: 1300px	;">

  <form name="Aform" method="post">
<div align="center" style="border-bottom: solid 2px #D5D5D5;">
	<div style="float: left; margin-left: 100px;">  	
	 	<div> <h1>${adto.getTitle() }</h1></div>
	 	<div> ${adto.getAddr1()} ${adto.getAddr2() }</div>
	 	<div> <span class="glyphicon glyphicon-paperclip"></span> ${cCount} </div>
	</div>
	
	<div align="right" style="height: 109px; width: 500px; padding-top: 40px; padding-left: 220px;">

		<input type="hidden" name="mapx" value="${adto.getMapx() }"> 
		<input type="hidden" name="mapy" value="${adto.getMapy() }">
		
		<div style="font-size: 30pt; width: 150px; float: left;">	
		<c:choose>	
		<c:when test="${clipchk == 0 }">
			
			<span id="check" class="glyphicon glyphicon-paperclip" onclick="addclip('${adto.getContentid()}')"></span>
			
			
		</c:when>
		<c:otherwise>
		
			<span style="color: red;" id="checkout" class="glyphicon glyphicon-paperclip" onclick="delclip('${adto.getContentid()}');"></span>
		
		</c:otherwise>
		</c:choose>

		</div>
		
		
		<div style="font-size: 30pt; width: 150px; " >
		<span class="glyphicon glyphicon-bullhorn" ></span>
		</div>
	
	</div>
	
</div>
<div>
	<div style="width: 700px; float: left;">
		<div align="left" style="padding-left: 100px;">
		<img alt="" src="${adto.getFirstimage() }">

		</div>
		<div align="left" style="padding-left: 100px;">
			<div style="width: 600px;"> ${adto.getOverview()}</div> 
		</div>
	</div>
	
	<div>
	
	 <div id="map_canvas" style="width:380px; height:300px;"></div> 
	
	</div>
		
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOJtjhA9loNkOUI0RVIWarJMGMyn5V-A&signed_in=true&callback=initMap"></script> 
</div>

<div> <!-- 리뷰 -->

	<div id="review"></div>

</div>

</form>
</div>
</body>

</html>