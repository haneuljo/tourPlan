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
  
  <!-- drag JavaScript files -->
	<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-ui-1.8.custom.min.js"></script>
	
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
<button type="button" class="btn btn-primary" onclick="location='<%=cp%>/forTest'">ForTest</button>
<form action="">

	<div id="example-1-1">
		<div class="sortable-list" style="width: 620;">

 			<c:forEach var="map" items="${lists}" varStatus="status">
				<div id="sortable_item-${status.index}" style="border: solid 1px;">
					<div style="height: 120;width: 600" class="sortable-item">
					<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${map.firstimage }"></div>
				 	<div> <h3>${map.title}//index:${status.index}</h3></div>
	 				<div> ${map.addr1} ${map.addr2 }</div>
	 				<div class="btn-group">
					   <button type="button" class="btn btn-primary">수정</button>
					   <button type="button" class="btn btn-primary" onclick="location='<%=cp%>/deleteTemp?index=${status.index}'">삭제</button>
					</div>
					</div>
					<input type="hidden" name="planNum" value="${map.planNum }">
					<input type="hidden" name="groupNum" value="${map.groupNum }">
					<input type="hidden" name="contentid" value="${map.contentid }">
					<input type="hidden" name="contenttypeid" value="${map.contenttypeid }">
					<input type="hidden" name="longTime" value="${map.longTime }">
					<input type="hidden" name="content" value="${map.content }">
					<input type="hidden" name="startDate" value="${map.startDate }">
				</div>
			</c:forEach>
			
<%-- 			<c:forEach var="adto" items="${alists}" varStatus="i"> 
			<div style="height: 120;width: 600" class="sortable-item">
			<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${adto.firstimage }"></div>
				 	<div> <h3>${adto.title}</h3></div>
	 				<div> ${adto.addr1} ${adto.addr2 }</div>
			</div>
			</c:forEach> --%>
		</div>
	</div>
	
	<!-- Example jQuery code (JavaScript)  -->
		<script type="text/javascript">
		
		$(document).ready(function(){
			$('#example-1-1 .sortable-list').sortable({
			    axis: 'y',
			    update: function (event, ui) {
			        var data = $(this).sortable('serialize');
					alert(data);
		 	        $.ajax({
			            data: data,
			            type: 'POST',
			            url: '<%=cp%>/orderUpdate'
			        }); 
			    }
			});
		});
		</script>

 </form>
</div>

</body>
</html>
