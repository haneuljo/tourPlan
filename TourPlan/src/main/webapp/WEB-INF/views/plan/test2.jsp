<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); 
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE>
<html>
<head>
  <title>Tour Plan</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <script src="<%=cp%>/resources/all.js"></script>
 <link rel="stylesheet" href="<%=cp%>/resources/css/header.css" type="text/css"/>
 <link rel="stylesheet" href="<%=cp%>/resources/css/planList.css" type="text/css"/>
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
  
</head>

<body>


<!-- ---- 모든 jsp 일단 복사 ---- -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="<%=cp%>/">TourPlan</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active"><a href="<%=cp%>/">Index</a></li>
        <li><a href="<%=cp%>/travel">여행지</a></li>
        <li><a href="<%=cp%>/planInfo">여행일정</a></li>
        <li><a href="<%=cp%>/myPlan">내일정</a></li>
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
	            <li><a href="<%=cp%>/myPlan">내일정</a></li>
	            <li><a href="<%=cp%>/">회원정보수정</a></li>
	            <li><a href="<%=cp%>/logout">로그아웃</a></li>
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
  
<!-- 헤더 끝  -->  



<!-- 이미지&바 묶기  -->
<div style="width: 100%;">
	<div style="width:100%; height:300px; background:url(/tourPlan/resources/image/8.jpg) center;">
		<div style="font-size: 40pt; color: white; padding-top: 150px;" align="center" >여행일정</div>
	</div>
	
	<div class="container" style="width: 100%">
	  <ul class="nav nav-tabs">
	    <li style="padding-left: 20%; font-size: 12pt;"><a href="#">클립보드</a></li>
	    <li style="font-size: 12pt;"><a href="#">여행일정</a></li>
	    <li style="font-size: 12pt;"><a href="#">리뷰</a></li>
	  </ul>
	</div>
</div>
<!-- 이미지&바 묶기  -->


<!-- 일정뿌리는곳 묶기 -->
<div style="width: 1300px; height: 100%; padding-left: 14%;" >

<!-- for문?  -->
<div style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<img src="/tourPlan/resources/image/1.png" style="width: 300px; height: 150px;">
	</div>
	
	<div style="width: 300px; height: 100px;">
		<div style="color: #01A6BC; font-size: 14pt; float: left; overflow: hidden;">startDate</div>
		
		<div align="right" style="padding-right: 15px; padding-top: 4px;">
			<span class="glyphicon glyphicon-send"></span> : 0
			<span class="glyphicon glyphicon-map-marker"></span> : 0
		</div>
		
		<br/>
		
		<div style="clear: both; font-size: 12pt;">
			<b>Title</b>
		</div>
		
		<div style="font-size: 12pt;">
			contentId
		</div>
	
	</div>

</div>
<!-- for문?  -->

<div style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<img src="/tourPlan/resources/image/4.jpg" style="width: 300px; height: 150px;">
	</div>
	
	<div style="width: 300px; height: 100px;">
		<div style="color: #01A6BC; font-size: 14pt; float: left; overflow: hidden;">startDate</div>
		
		<div align="right" style="padding-right: 15px; padding-top: 4px;">
			<span class="glyphicon glyphicon-send"></span> : 0
			<span class="glyphicon glyphicon-map-marker"></span> : 0
		</div>
		
		<br/>
		
		<div style="clear: both; font-size: 12pt;">
			<b>Title</b>
		</div>
		
		<div style="font-size: 12pt;">
			contentId
		</div>
	
	</div>

</div>

<div style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<img src="/tourPlan/resources/image/2.png" style="width: 300px; height: 150px;">
	</div>
	
	<div style="width: 300px; height: 100px;">
		<div style="color: #01A6BC; font-size: 14pt; float: left; overflow: hidden;">startDate</div>
		
		<div align="right" style="padding-right: 15px; padding-top: 4px;">
			<span class="glyphicon glyphicon-send"></span> : 0
			<span class="glyphicon glyphicon-map-marker"></span> : 0
		</div>
		
		<br/>
		
		<div style="clear: both; font-size: 12pt;">
			<b>Title</b>
		</div>
		
		<div style="font-size: 12pt;">
			contentId
		</div>
	
	</div>

</div>

<div style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<img src="/tourPlan/resources/image/7.jpg" style="width: 300px; height: 150px;">
	</div>
	
	<div style="width: 300px; height: 100px;">
		<div style="color: #01A6BC; font-size: 14pt; float: left; overflow: hidden;">startDate</div>
		
		<div align="right" style="padding-right: 15px; padding-top: 4px;">
			<span class="glyphicon glyphicon-send"></span> : 0
			<span class="glyphicon glyphicon-map-marker"></span> : 0
		</div>
		
		<br/>
		
		<div style="clear: both; font-size: 12pt;">
			<b>Title</b>
		</div>
		
		<div style="font-size: 12pt;">
			contentId
		</div>
	
	</div>

</div>


</div>
<!-- 일정뿌리는곳 묶기 -->





<!-- 풋터시작  -->

<div style="width: 100%; height:150; background-color: #006583; clear: both;" align="center">
	<div style="padding-top: 30px; width: 310px" align="left">
	<font color="#ffffff">[reference]  www.data.go.kr <br/>
			              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			              https://developers.google.com/maps/<br />

			</font>
	</div>
	<div style="padding-top: 20px;">
	<font color="#BDBDBD">
			Copyright ⓒ 2015 TourPlan, All Rights Reserved.
			</font>
	</div>
</div>


</body>
</html>
  