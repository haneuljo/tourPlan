<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

<script>
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
