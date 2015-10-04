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
<script>
	 //일정추가부분?
	 function choice(){
		 var contentid = $("#contentid").val();
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
					$("#result").empty();
					if(data.response.body.totalCount==0){
						$("#result").append('데이터가 없습니다.');
						
					}else{
						for(i=0;i<data.response.body.totalCount;i++){	
							//alert("아놔"+data.response.body.items.item[i].title);
							if(data.response.body.items.item[i].contentid==contentid){
								$("#result").append('<div><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/>'
								+'<select style="width: 116px;"><option value="0">날짜</option></select>'
								+'<select style="width: 116px;"><option value="0">시간</option></select><br/>'+data.response.body.items.item[i].title+'</div>');
							}
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
  
</div>

</body>
</html>
