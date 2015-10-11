<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div id="planList_All">
	<div class="listDiv">
		<div class="currentDay">
			일정클릭한 데이터 받기
		</div>
		<div class="planListBtn">
			<button id="startSelectBtn">출발지선택</button>
		</div>
		<div id="planList">
			<div id="result"></div>
		</div>
	</div>
	<div class="listDiv" style="border:1px solid #ccc;">
		<div id="areaList"></div>
	</div>
	
</div>

		
	<script>
	$(function(){
	$(".listDiv:last").hide();
	$("#tilesPlan").css("width","20%");
	$(".listDiv").css("width","100%");
	$("#tilesMapView").css("width","65%");
	$.ajax({
		  type:"GET",
		  url:"<%=cp%>/areaCodeAPI",
		  dataType:"json",
		  success:function(data){	
			for(i=0;i<data.response.body.items.item.length;i++){	
				$("#areaList").append('<div class="planList_area"><span class="area_name">'+data.response.body.items.item[i].name+'</span><Button class="areaListBtn" data="'+data.response.body.items.item[i].code+'">+</Button></div>')
			}
			 
			 $(".areaListBtn").click(function(){
				 areaCode=$(this).attr('data');
				//alert(areaCode);
		 		 markerMap();
			 });
		},error:function(e){}
	  });

	$("#startSelectBtn").click(function(){
    	$.ajax({
			type:"GET",
			url:"<%=cp%>/startPlace?startDate=" + '${startDate}',
			dataType:"html",		
			success:function(data){
				$("#myModal").html(data);
				//alert(data);
				$("#myModal").modal();

				$("#tilesPlan").css("width","40%");
				$("#tilesMapView").css("width","45%");
				$(".listDiv").css("width","50%");
				$(".listDiv:last").show();
				
			},
			error:function(e){11
				alert("1111111111"+e.responseText);
			}
			
		});
        
    });

		 
 });
</script>
	