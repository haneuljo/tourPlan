<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <title>GodShop</title>
  <meta charset="utf-8"> 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script>
	$("#invent").click(function(){
		$("#invent").css("class","active");
		$("#shop").css("class","");
	});

	$("#shop").click(function(){
		$("#shop").css("class","active");
		$("#invent").css("class","");
	});

</script>  

</head>


<body>



<div style="width: 100% ;text-align: center;">
	<div class="container">
		<div style="padding-top: 5px; float: left; width: 1000px;">
			<ul class="nav nav-tabs" style="float: left;">
			    <li id="shop" class="active"><a href="<%=cp %>/category.action">Shop</a></li>
			    <li id="invent"><a href="<%=cp %>/ideaMain.action">Invent</a></li>
		  	</ul>
	<div align="right">
    	<ul id="nav navbar-nav navbar-right" style="width: 240px; padding-top: 20px; margin-bottom: 0px; margin-right: 0px;">
			<c:choose>
			<c:when test="${empty logInfo}">
				<a href="<%=cp %>/basket.action"><span class="glyphicon glyphicon-shopping-cart"></span> basket</a>
			 	<a href="<%=cp %>/write.action"><span class="glyphicon glyphicon-user"></span> Sign Up</a>
		        <a href="<%=cp %>/login.action"><span class="glyphicon glyphicon-log-in"></span> Login</a>		        
			</c:when>
			<c:otherwise>			
				<a href="/god/myPage.action"><span class="glyphicon glyphicon-list-alt">myPage</span></a>
				<a href="<%=cp %>/basket.action"><span class="glyphicon glyphicon-shopping-cart"></span> basket</a>
				<a href="<%=cp%>/logout.action"><span class="glyphicon glyphicon-log-out">Logout</span></a>
			</c:otherwise>
			</c:choose>
		</ul>
   	 </div>
		</div>
	</div>
</div>

<nav class="navbar navbar-inverse" style="background-color: #616161; border-color: #ddd; background-image: url(/god/resources/image/main1.png)">
  <div class="container-fluid" style="padding-left: 10px; padding-right: 10px; width: 1020px; margin-left: 370px; margin-right: 150px;">
    <div class="navbar-header" style="margin-bottom: 10px;">
      <!-- <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button> -->
      <a class="navbar-brand" href="<%=cp %>/category.action"><img style="margin-right: 80px;"  src="<%=cp%>/resources/image/ideaShop.PNG"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="<%=cp %>/category.action">
          <img src="<%=cp%>/resources/image/ideaproduct.png">
          <span class="caret"></span></a>
          <ul style="margin-left: 40px;" class="dropdown-menu">
            <li><a href="<%=cp %>/idea_category.action">생활/건강</a></li>
            <li><a href="#">디지털/가전</a></li>
            <li><a href="#">가구/인테리어</a></li>
            <li><a href="#">패션잡화</a></li>
            <li><a href="#">스포츠/레저</a></li>
          </ul>
        </li>
        <li><a href="<%=cp %>/category.action"><img style="margin-left: 80px;" src="<%=cp%>/resources/image/bestproduct.png"></a></li>
        <li><a href="<%=cp %>/golist.action"><img style="margin-left: 80px;" src="<%=cp%>/resources/image/customer.png"></a></li>
      </ul>
    </div>
  
  </div>
</nav>

</body>
</html>

