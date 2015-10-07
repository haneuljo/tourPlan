<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>    
<script type="text/javascript">

	var address1;
	var address2;

	var directionsDisplay = new google.maps.DirectionsRenderer;
	var directionsService = new google.maps.DirectionsService;
	
	var geocoder = new google.maps.Geocoder();
	 
	 directionsDisplay.setPanel(document.getElementById('rootList'));
	 document.getElementById('submit1').addEventListener('click', function() {               //출발지
	     address1 = document.getElementById('address1').value;
	     //alert(address1);
	     geocodeAddress(geocoder, map, address1);
	  });
	  document.getElementById('submit2').addEventListener('click', function() {                //도착지
	     address2 = document.getElementById('address2').value;
	     geocodeAddress(geocoder, map, address2);
	  }); 

	  document.getElementById('Gdirection').addEventListener('click', function() {              //길찾기
	     calculateAndDisplayRoute(directionsService, directionsDisplay, address1, address2); 
	  }); 

	  var durTime
function calculateAndDisplayRoute(directionsService, directionsDisplay, address1, address2) {            //대중교통길찾기
	  directionsService.route({
		  
	    origin: address1,
	    destination: address2,
	/*     transitOptions:{
	    	departureTime:,
	    }, */
	    travelMode: google.maps.TravelMode.TRANSIT
	    
	  }, function(response, status) {
		  
	    if (status === google.maps.DirectionsStatus.OK) {
	    	
	    	
	      directionsDisplay.setDirections(response);
	      alert(response.routes[0].legs[0].duration.value);
	      durTime = response.routes[0].legs[0].duration.value;

	      
	    } else {
	      window.alert('Directions request failed due to ' + status);
	    }
	  });
}

function startPut(){
	//alert(durTime)
	var f = document.myForm;
	
	f.action = "<%=cp%>/startPut?durTime=" + durTime + "&startDate=" + '${startDate}';
	f.submit();
	
}
</script>
    
	<div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> 출발지선택</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form name="myForm" action="" method="post">
            <div class="form-group">
              <label for="startDate"><span class="glyphicon glyphicon-eye-open"></span> 출발시간</label>
              <select name="hour">
              <c:forEach var="i" begin="0" end="24" step="1">
              	<option value="${i}">${i}</option>
              </c:forEach>
              </select>시
                <select name="min">
              <c:forEach var="i" begin="0" end="60" step="10">
              	<option value="${i}">${i}</option>
              </c:forEach>
              </select>분
            </div>
            
            <div class="form-group">
              <label for="address1"><span class="glyphicon glyphicon-user"></span> 출발지</label>
              <input type="text" name="address1" class="form-control" id="address1" placeholder="강남역">
              <input id="submit1" type="button" value="검색"/>
            </div>
            
            <div class="form-group">
              <label for="address2"><span class="glyphicon glyphicon-eye-open"></span> 도착지</label>
              <input type="text" name="address2" class="form-control" id="address2" placeholder="영등포">
              <input id="submit2" type="button" value="검색"/>
            </div>
            
            <input id="Gdirection" type="button" value="길찾기">
            <!-- <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> 찾기</button> -->
          <div id="rootList"></div>
          <input type="button" value="등록" onclick="startPut();"/>
          </form>
          
          
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
        </div>
      </div>
      
    </div>