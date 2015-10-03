<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
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
  </style>
  <script type="text/javascript">
  
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
  
  $(function(){
		var areaCode;
		var sigunguCode;
		var contentTypeId = "";
		
		$.ajax({
			type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
				$('#selectArea').empty();
				$("#selectArea").append('<option value="0">선택</option>');
				//alert(data);
				for(i=0;i<data.response.body.items.item.length;i++){	
					$("#selectArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
				}
					
			},
			error:function(e){
				//alert("1111111111"+e.responseText);
			}
			
		});

		
		$("#selectArea").change(function(){
			areaCode=$("#selectArea option:selected").val();
			
			//지역별로 시구군 코드가 다르므로 !!! numOfRows check할것
			$.ajax({
				type:"GET",
				url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
				dataType:"json",		
				success:function(data){
						$('#selectSubArea').empty();
						$("#selectSubArea").append('<option value="0">선택</option>');
						//alert(data);
						for(i=0;i<data.response.body.items.item.length;i++){	
							$("#selectSubArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
						
						}
							
					},
					error:function(e){
						//alert("1111111111"+e.responseText);
					}
					
				});
		
		});
		$("#selectSubArea").change(function(){
			sigunguCode=$("#selectSubArea option:selected").val();
		});
		

		$("#content").change(function(){
			contentTypeId=$("#content option:selected").val();
		});
		
		
		$("#btn").click(function(){
			
			
				
			$.ajax({
				type:"POST",
				//url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json",
				url:"<%=cp%>/areaBasedList",
				data:"areaCode="+areaCode+"&sigunguCode="+sigunguCode,
				dataType:"json",		
				success:function(data){
					$("#result").empty();
					if(data.response.body.totalCount==0){
						$("#result").append('데이터가 없습니다.');
						
					}else{
						for(i=0;i<data.response.body.totalCount;i++){	
							
							$("#result").append('<div style="float: left;"><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/><br/>'+data.response.body.items.item[i].title+'</div>');
							
						}
					}
				/* 	$.each(data, function(key, value) {
						//alert(value.body.items.item.length);
						$("#result").append('<img src="'+value.body.items.item[count].firstimage+'"/><br/>');
						count++;

					}); */
				},error:function(e){
					alert("1111111111"+e.responseText);
				}
			});
			
		
		});

	 $("#content").change(function(){
			
			contentTypeId=$("#content option:selected").val();
			
			$.ajax({
				type:"POST",
				//url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json",
				url:"<%=cp%>/areaBasedListAPI",
				data:"areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&contentTypeId=" + contentTypeId,
				dataType:"json",		
				success:function(data){
					$("#result").empty();
					if(data.response.body.totalCount==0){
						$("#result").append('데이터가 없습니다.');
						
					}else{
						for(i=0;i<data.response.body.totalCount;i++){	
							if(i%4==0 && !(i==0)){
								
								$("#result").append('<div><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/><br/>'+data.response.body.items.item[i].title+'</div>')
							}
							
							else{
							$("#result").append('<div style="float:left;"><img style="width:200px; height:150px;"src="'+data.response.body.items.item[i].firstimage+'"/><br/>'+data.response.body.items.item[i].title+'</div>');
							}
						}
					}
				/* 	$.each(data, function(key, value) {
						//alert(value.body.items.item.length);
						$("#result").append('<img src="'+value.body.items.item[count].firstimage+'"/><br/>');
						count++;

					}); */
				},error:function(e){
					alert("1111111111"+e.responseText);
				}
			});
		
		});
		
		
		

	});
  
  
  
  </script>
  
</head>
<body>

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
        <li><a href="#">Page 2</a></li>
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
  
  <div class="container">
  <div class="jumbotron" align="center" style="height:250px; background-image:url('/tourPlan/resources/d_0415.PNG'); ">
          
    <div align="center" style="float: left;"><input type="text" style="width: 150px; height: 50px;"> <span class="glyphicon glyphicon-search" style="width: 50px; height: 50px;"></span> </div>
  </div>
  
  지역 : 
<select id="selectArea" style="width: 116px;">
	<option value="0">선택</option>
</select>
<select id="selectSubArea" style="width: 116px;">
	<option value="0">선택</option>
</select>
<button id="btn">검색</button>

<div style="padding-bottom: 10px;">
관광타입: 
<select id ="content" style="width: 116px;">
	<option value="">선택</option>
	<option value="12">관광지</option>
	<option value="14">문화시설</option>
	<option value="32">숙박</option>
	<option value="38">쇼핑</option>
	<option value="39">음식</option>
</select>
</div>


<div id="result"></div>
     
</div>

</body>
</html>