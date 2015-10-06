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
   <script>
 	 $(document).ready(function(){
 		 var areaCode;
 		 var sigunguCode;
 		 var cliplike;
 		 
 		 $.ajax({
 			type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
				
				var count=1;
				for(i=0;i<data.response.body.items.item.length;i++){	
					$("#areaContainer").append('<div id="area" data="'+data.response.body.items.item[i].code+'"index="'+count+'">'+data.response.body.items.item[i].name+'<span></span></div>');
					
					if((i+1)%6==0 || i==data.response.body.items.item.length-1){
						$("#areaContainer").append('<div id="sigugun'+count+'"data="'+data.response.body.items.item[i].code+'" index="'+count+'"></div>');
						count++;
					}
				}
				$("#areaContainer div:has(span)").bind("click", function(){
					areaCode=$(this).attr('data');
					//alert(areaCode);
					if($(this).attr('id')=="area"){
						var index=$(this).attr('index');
						//alert(index);
						$.ajax({
							type:"GET",
							url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
							dataType:"json",		
							success:function(data){
								$("#sigugun"+index).empty();
								//alert(data);
								for(i=0;i<data.response.body.items.item.length;i++){
									$("#sigugun"+index).append('<div id="segugun_info" data="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'<a></div>');
								}  
								
								
								$("#sigugun"+index+" div").bind("click", function(){
									sigunguCode = $(this).attr('data');
									$.ajax({
										type:"GET",
										url:"<%=cp%>/clipCount?areaCode="+areaCode+"&sigugunCode="+sigunguCode,
										dataType:"json",		
										success:function(data){
											
											$("#clipResult").empty();
											//alert(data);
											$.each(data, function(index, value) {
												$("#clipResult").append('<div id="travel_info"><img style="width:200px; height:150px;"src="'+value.firstimage+'" onclick="article('+value.contentid+');"/><br/>클립: '+value.clipCount+' : '+value.title+'<span class="glyphicon glyphicon-heart" onclick="cliplike('+value.contentid+')"></span></div>');
											
	
													
												
												
											}); 
											
											
											 
											
										},
										error:function(e){
											alert("1111111111"+e.responseText);
										}					
									
									});
								});
								
						
								
							},
							error:function(e){
								alert("1111111111"+e.responseText);
							}
							
						});
						
					}
				
				});
				
					
			},
			error:function(e){
				//alert("1111111111"+e.responseText);
			}
 			 
 		 });
  		
  		
  	});
 	 
 	function cliplike(cd) {
 		
 		var f= document.clip;
		alert(cd);
 		f.action = '<%=cp%>/clipLike?contentid=' +cd;
 		f.submit();
 		
 		
	} 	 
 	
 	
	function article(cd) {
 		
 		var f= document.clip;
		alert(cd);
 		f.action = '<%=cp%>/article.action?contentid=' +cd;
 		f.submit();
 		
 		
	} 	
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
	            <li id="myclip"><a href="">My Clip</a></li>
	            <li><a href="#">Page 1-2</a></li>
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
<form action="" name="clip" method="post">
  <div id="areaContainer"></div>
  <div id="clipResult">
  
  </div>  
</form>
 
  
  
  
</div>


</body>
</html>
