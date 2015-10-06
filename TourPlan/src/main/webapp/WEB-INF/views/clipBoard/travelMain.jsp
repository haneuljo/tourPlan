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
	            <li><a href="#">Page 1-1</a></li>
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
 

	<div id="areaContainer">
		<div id="seoul" class ="area area0">서울</div>
		<div id="incheon" class ="area area1">인천</div>
		<div id="daejeon" class ="area area2">대전</div>
		<div id="daogu" class ="area area3">대구</div>
		<div id="gwangju" class ="area area4">광주</div>
		<div id="busan" class ="area area5">부산</div>
		<div id="ulsan" class ="area area6">울산</div>
		<div id="sejong" class ="area area7">세종</div>
		<div id="gyeonggi" class ="area area8">경기도<span class="caret"></span></div>
		<div id="gangwon" class ="area area9">강원도<span class="caret"></span></div>
		<div id="chungbuk" class ="area area10">충청북도<span class="caret"></span></div>
		<div id="chungnam" class ="area area11">충청남도<span class="caret"></span></div>
		<div id="sigungu1" class="sigungu"></div>
		<div id="gyeongbuk" class ="area area12">경상북도<span class="caret"></span></div>
		<div id="gyeongnam" class ="area area13">경상남도<span class="caret"></span></div>
		<div id="jeonnam" class ="area area14">전라북도<span class="caret"></span></div>
		<div id="jeonbuk" class ="area area15">전라남도<span class="caret"></span></div>
		<div id="jeju" class ="area area16">제주도</div>
		<div id="sigungu2" class="sigungu"></div>
	</div>
	<form name="clip" method="post">
	<div id="clipResult"></div> 

	</form>
	
	<script>
		var areaCode;
		var sigunguCode=0;
		$.ajax({
	 		type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
				var count=0;
				for(i=0;i<data.response.body.items.item.length;i++){	
					$(".area"+i).attr("data", data.response.body.items.item[i].code);
					$(".area"+i).attr("index", count);

					if((i+1)%6==0 || i==data.response.body.items.item.length-1){
						count++;
					}
				}

			},
				error:function(e){
					//alert("1111111111"+e.responseText);
				}
		});
		
		$(".area").click(function(){
			areaCode=$(this).attr('data');
			if($(this).children("span").length==1){
				var index=$(this).attr('index');
				//alert(index);
				$(".sigugun").hide();
				$.ajax({
					type:"GET",
					url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
					dataType:"json",		
					success:function(data){
						$("#sigungu"+index).empty();
						//alert(data);
						for(i=0;i<data.response.body.items.item.length;i++){
							$("#sigungu"+index).append('<div class="sigungu_info" data="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</div>');
															
						}  
						
						$("#sigungu"+index).show();
						$("#sigungu"+index+" div").bind("click", function(){
							
							sigunguCode = $(this).attr('data');
							//alert(sigunguCode);
							clipCount(1);
						});
							
					},	error:function(e){alert("1111111111"+e.responseText);}
				});		
			}else{
				clipCount(1);
			}
			
		});
		
		
		function clipCount(page){
			$.ajax({
				type:"GET",
				url:"<%=cp%>/travelMain?areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&page="+page,
				dataType:"json",		
				success:function(data){
					
					$("#clipResult").empty();
					//alert(data);
					
					$.each(data, function(index, value) {
						$("#clipResult").append('<div class="travel_info" onclick="article('+value.contentid+');"><img style="width:200px; height:150px;"src="'+value.firstimage+'"/><br/>클립: '+value.clipCount+' : '+value.title+'</div>');
					});  
					 
					
					if(page==1){
						$(".pagination").empty();
						//alert('${sessionScope.clipJSON.totalPage}');
						
						for(var i=1; i<=10; i++){
/* 						for(var i=1; i<='${sessionScope.clipJSON.totalPage}'; i++){ */
							
							$(".pagination").append('<li><a href="javascript:clipCount('+i+')">'+i+'</a></li>');
							
						}
						
						
					}
	
				},
				error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }			
			
			});
			
		}
		

		function article(cd) {
	 		
	 		var f=document.clip;
			alert(cd);
	 		f.action = '<%=cp%>/article.action?contentid=' +cd;
	 		f.submit();
	 		
		} 	
	
	</script> 
  
  	<div id="page">
  		<ul class="pagination">
  		</ul>
  	</div>
 
  
</div>


</body>
</html>
