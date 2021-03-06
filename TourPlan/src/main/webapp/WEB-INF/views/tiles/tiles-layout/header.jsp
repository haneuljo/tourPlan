<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); 
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
 <link rel="stylesheet" href="<%=cp%>/resources/css/index.css" type="text/css"/>
  
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
		    	$(this).attr("class","");
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
			    	$(this).attr("class","");
				},
				error:function(e){
					alert("1111111111"+e.responseText);
				}
				
			});
	        
	    });
	});
  </script>

  <script type="text/javascript">
  
  $(document).ready(function(){
		
		$(".navbar-nav>li").click(function(){
			
			$(this).attr("class","active");
			
		});
			
		
	});
  
  </script>
</head>

<body>


<!-- ---- 모든 jsp 일단 복사 ---- -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
  
    <div class="navbar-header" style="padding-right: 0px;width: 92px; padding-top: 7px;">
      <img style="width: 120px; height: 45px;" src="/tourPlan/resources/logo.jpg" id="logo">
    </div>

	<script>
	$("#logo").click(function(){
		
		location.href="<%=cp%>/";
		
	})
	
	</script>    
    <div>
      <ul class="nav navbar-nav">
        <%-- <li class="active"><a href="<%=cp%>/">Index</a></li> --%>
        <li id="menu1" class=""><a href="<%=cp%>/travel">여행지</a></li>
        <li id="menu2" class=""><a href="<%=cp%>/planInfo">여행일정</a></li>
        <li id="menu3" class=""><a href="<%=cp%>/myPlan">내일정</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      
      	<c:choose>
      	
      	<c:when test="${empty sessionScope.loginInfo.email}">
      	
        <li id="sign"><a href="#" class="headerBtn" style="padding-top: 5px; color: #fff; font-weight: normal;">Sign Up</a></li>
        <li id="login"><a href="#" class="headerBtn" style="padding-top: 5px; color: #fff; font-weight: normal;">Sign In</a></li>
        
        </c:when>
	        <c:otherwise>
	        <c:if test="${!empty planChk}">
	        	<button id="planSave" class="btn planChkBtn"> 저장 & 닫기 </button>
	        	<button id="planOk" class="btn planChkBtn" onclick="register();"> 일정 등록 </button>
	        </c:if>
	        <c:if test="${empty planChk}">
	        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="<%=cp%>/myClip">My ClipList</a></li>
	            <li><a href="<%=cp%>/myPlan">내일정</a></li>
	            <li><a href="<%=cp%>/">회원정보수정</a></li>
	            <li><a href="<%=cp%>/logout">로그아웃</a></li>
	          </ul>
	       </li>
	       </c:if>
	       </c:otherwise>
       </c:choose>
      </ul>
      
    </div>
  </div>
</nav>


<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    
  </div> 