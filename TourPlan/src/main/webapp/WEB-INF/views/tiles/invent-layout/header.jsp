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

  
</head>
<body>

<div style="width: 100% ;text-align: center;">
	<div class="container">
		<div style="padding-top: 5px; float: left; width: 1000px;">
			<ul class="nav nav-tabs" style="float: left;">
			<c:choose>
			<c:when test="${logInfo.userId =='admin' }">
				<li><a href="<%=cp %>/category.action">Shop</a></li>
			    <li class="active"><a href="<%=cp %>/ideaMain.action">Invent</a></li>
			    <li style="padding-top: 10px; padding-bottom: 10px; padding-left: 15px; padding-right: 15px;">
			    <a href="<%=cp %>/reportlist.action">Admin</a>
			    </li>
			</c:when>
			<c:otherwise>
			    <li><a href="<%=cp %>/category.action">Shop</a></li>
			    <li class="active"><a href="<%=cp %>/ideaMain.action">Invent</a></li>
			    <li style="padding-top: 10px; padding-bottom: 10px; padding-left: 15px; padding-right: 15px;">
			    Admin</li>
			</c:otherwise>
			</c:choose>    
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

<nav class="navbar navbar-inverse" style="background-color: #ffffff; border-color: #ddd; margin-bottom: 5px; background-image: url(/god/resources/image/main1.png)">
  <div class="container-fluid" style="padding-left: 10px; padding-right: 10px; width: 1000px;">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" style="font-size: 20pt; margin-top: 5px; padding: 0px;" href="<%=cp %>/ideaMain.action">
      <img style="width: 120px; height: 60px; padding-bottom: 10px;" src="/god/resources/image/goodidea.png"></a>
    </div>
    <div>
      <ul class="nav nav-pills nav-justified" style="padding-top: 10px; padding-bottom: 10px;" >
	    <li><a href="<%=cp %>/group/list.action"><img src="/god/resources/image/Inventwh.png" style="margin-left: 20px;"></a></li>
	    <li><a href="<%=cp %>/memberList.action"><img src="/god/resources/image/communitywh.png"></a></li>
	    <li><a href="<%=cp %>/completed.action"><img src="/god/resources/image/completedwh.png"></a></li>
 	  </ul>
 	 </div>
  </div>
</nav>


</body>
</html>

<%-- 
<body>
<div style="width: 100% ;text-align: center;">
	<div class="container">
		<div style="padding-top: 5px; float: left;">
			<ul class="nav nav-tabs">
			    <li class="active"><a href="<%=cp %>/shop.action">Shop</a></li>
			    <li><a href="<%=cp %>/invent.action">Invent</a></li>
			  
		  	</ul>
		</div>
		
	</div>
</div>

<nav class="navbar navbar-inverse" style="padding-left: 100px; padding-right: 100px;">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="<%=cp %>/shopmain.action" style="">GodShop</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active" style="padding-left: 50px;"><a href="<%=cp %>/category.action">카테고리</a></li>
        <li style="padding-left: 50px;"><a href="#">베스트</a></li>
        <li style="padding-left: 50px;"><a href="#">고객의 소리</a></li> 
      </ul>
    </div>
    <div align="right">
    	<ul id="nav navbar-nav navbar-right" >
			<c:choose>
			<c:when test="${empty userId}">
			 	<li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
		        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</c:when>
			<c:otherwise>
			<a href="<%=cp%>/logout.action">Logout</a><a href="/god/myPage.action">myPage</a>
			</c:otherwise>
			</c:choose>
		</ul>
    </div>
  </div>
</nav>
 --%>
