<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>
  
  <script>
  	
  	function delclip(cd) {
  		
  		var f = document.Aform;
  		
  		f.action = "<%=cp%>/deletedClip?contentid=" + cd;
  		f.submit();
		
	}
  	
	function addclip(cd) {
  		
  		var f = document.Aform;
  		
  		f.action = "<%=cp%>/clipLike?contentid=" + cd;
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

  <div class="container" style="width: 1300px;">

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
