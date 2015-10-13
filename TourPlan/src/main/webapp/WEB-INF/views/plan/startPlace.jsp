<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>    
<script type="text/javascript">

var address1;
var address2;

/* var directionsDisplay = new google.maps.DirectionsRenderer;
var directionsService = new google.maps.DirectionsService; */

var geocoder = new google.maps.Geocoder();
var hour;
var min;
//var time;
var start = new Date();


//var time=(hour*3600)+(min*60);
 //directionsDisplay.setPanel(document.getElementById('rootList'));
 document.getElementById('submit1').addEventListener('click', function() {               //출발지
     address1 = document.getElementById('address1').value;
     //alert(address1);
     //alert(start);
     //geocodeAddress(geocoder, map, address1);
  });
  document.getElementById('submit2').addEventListener('click', function() {                //도착지
     address2 = document.getElementById('address2').value;
     geocodeAddress(geocoder, map, address2);
  }); 

  document.getElementById('Gdirection').addEventListener('click', function() {              //길찾기
	  startcalculateAndDisplayRoute(directionsService, directionsDisplay, address1, address2); 
  }); 
  
  function geocodeAddress(geocoder, resultsMap, address) {                                                 //검색마커찍기(주소->좌표변환)
	  geocoder.geocode({'address': address}, function(results, status) {
	    if (status === google.maps.GeocoderStatus.OK) {
	    	$("#mapy").val(results[0].geometry.location.lat());
	    	$("#mapx").val(results[0].geometry.location.lng());
	    } else {
	      alert('Geocode was not successful for the following reason: ' + status);
	    }
	  });
	}

  var durTime;
  var durText;
function startcalculateAndDisplayRoute(directionsService, directionsDisplay, address1, address2) {            //대중교통길찾기
  // alert(time);
  directionsService.route({
     
    origin: address1,
    destination: address2,
    transitOptions:{
       departureTime: start
    },
    travelMode: google.maps.TravelMode.TRANSIT
    
  }, function(response, status) {
     
    if (status === google.maps.DirectionsStatus.OK) {
      
    	directionsDisplay.setDirections(response);
      
      durTime = response.routes[0].legs[0].duration.value;
      durText = response.routes[0].legs[0].duration.text;
      disText = response.routes[0].legs[0].distance.text;
      //alert(response.routes[0].fare.location);
      //alert(durText);
      //alert(disText);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
    
    $("#rootList").append('<div><font size="4px"><b>'+ address1+'</b></font>&nbsp;<span class="glyphicon glyphicon-arrow-right"/>&nbsp;<font size="4px"><b>' + address2 +'</b></font> <font size="2px"><b>하차</b></font><br/>총시간:'+durText+'&nbsp;&nbsp;총거리: '+ disText +'</div>')
  });
}

  $(document).ready(function(){
      
	  $("#hour option:eq(9)").attr("selected","selected");
      $("#hour").change(function(){
         //alert($("#hour").val());
         hour = $("#hour").val();
         start.setHours(hour);
      });
      
      $("#min").change(function(){
         
         //alert($("#min").val());
         min = $("#min").val();
         start.setMinutes(min);
         //time = hour*3600+min*60;
         //alert(time);
      });
         
   
   });
  

function startPut(){

	$("#durTime").val(durTime);
	$("#startDate").val('${startDate}');
	//serialize() 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
	var f = $("#myForm").serialize();
	$.ajax({
		  type:"POST",
		  url:"<%=cp%>/startPut",
		  data : f,
		  contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
		  dataType:"text",
		  success:function(endTime){
			  
			  //alert(data);
			  
			  //req.setAttribute("startDate", gp.getStartDate());
			  //req.setAttribute("endTime", endTime);
			  //req.setAttribute("address2", address2);//다음 관광지와 거리는 시간 구하기위해
			  if(endTime!=null){
				$(".startPlace").append('<span>'+address1+'</span> <span class="glyphicon glyphicon-arrow-right startArrow"></span> <span>'+address2+'</span><span id="startDurTime"></span><input type="hidden" id="endTime" value="'+endTime+'">');
				$(".startPlace").show();
				$("#startDurTime").text(durText);
				$("#myModal").modal("hide");
				

				$("#tilesPlan").css("width","40%");
				$("#tilesMapView").css("width","45%");
				$(".listDiv").css("width","50%");
				$(".listDiv:last").show();
				
			  }
		},error:function(e){}
	  });
	
}
</script>
    
	<div class="modal-dialog" style="width: 400px; height: 500pxl">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px; background-color: #000042;" >
          <button type="button" class="close" data-dismiss="modal" style="margin-top: -10;">&times;</button>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form name="myForm" action="" id="myForm" method="post">
            <div>
              <div style="float: left;">
	              <label for="startDate" style="
    margin-bottom: 0px;
    margin-right: 10px;
    margin-top: 5px;
	              "><span class="glyphicon glyphicon-time"></span> 출발시간</label>
              </div>
              <div style="float: left;width: 200px;">
              	  <div style="float: left; width: 100px;">
		              <select name="hour" id="hour" class="form-control" style="width: 76px;float: left; height: 32px;">
		              <c:forEach var="i" begin="0" end="24" step="1">
		              	<option value="${i}">${i}</option>
		              </c:forEach>
		              </select>
		              <span style="float:left;margin-left: 5px;margin-top: 5px;">시</span>
	              </div>
	              <div style="float: left; width: 100px;">
		              <select name="min" id="min" class="form-control"style="width: 76px;float: left; height: 32px;">
		              <c:forEach var="i" begin="0" end="50" step="10">
		              	<option value="${i}">${i}</option>
		              </c:forEach>
		              </select>
		              <span style="float:left;margin-left: 5px;margin-top: 5px;">분</span>
	              </div>
	              
              </div>
            </div>
            
            <div class="form-group">
              <label for="address1" style="width: 300px;"><span class="glyphicon glyphicon-home"></span> 출발지</label>
              	<div style="float:left;">
	              <input type="text" name="address1" class="form-control" id="address1" placeholder="강남역" style=" width: 220px;">
              	</div>
              	<div style="float:left; margin-left: 10px;">
	              <input id="submit1" type="button" value="검색" class="btn" style="background-color: #FF7012; color:#fff;" >
              	</div>
            </div>
            
            <div class="form-group">
              <label for="address2"  style="width: 300px;"><span class="glyphicon glyphicon-flag"></span> 도착지</label>
              	<div style="float:left;">
              	  <input type="text" name="address2" class="form-control" id="address2" placeholder="영등포" style=" width: 220px;">
              	</div>
              	<div style="float:left;margin-left: 10px;">
	              <input id="submit2" type="button"  value="검색" class="btn" style="background-color: #FF7012; color:#fff;" >
              	</div>
            </div>
            
            <input id="Gdirection" type="button" value="길찾기"  class="btn" style="width: 286px;margin-top: 10px; background-color: #FF7012; color:#fff;"/>
           
            <!-- <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> 찾기</button> -->
          <div id="rootList" align="center" style="margin-top:20px; margin-left:0px; border:1px solid #ccc;"></div>
          
          <input type="hidden" name="durTime" id="durTime">
          <input type="hidden" name="startDate" id="startDate">
          <input type="hidden" name="mapx" id="mapx">
          <input type="hidden" name="mapy" id="mapy">
          
          
          
          </form>
        </div>
        <div class="modal-footer">
          <input type="button" value=" 등 록 " onclick="startPut();" class="btn btn-default pull-right" style="background-color: #000042; color:#fff;"/>
        </div>
      </div>
      
    </div>