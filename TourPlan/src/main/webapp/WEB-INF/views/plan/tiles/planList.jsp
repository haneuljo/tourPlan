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
			<div class="startPlace">
			</div>
			<div id="result">
				<%-- <div id="sortable_item-${status.index}" onprogress="initMap(${map.mapx},${map.mapy});">
					<div class="sortable-item">
						<div class="sortItem_firstImg"><img alt="대표이미지" src="${map.firstimage }"></div>
						<div class="sortContent">
						 	<div class="sortItem_title"> <span>경복궁</span></div>
			 				<div class="sortItem_addr"> <span>서울시 서대문</span> </div>
			 				<select id="lonTime${status.index}" class="form-control sortItem_time">
			 					<option value="0">0</option>
			 					<option value="30">30분</option>
			 					<option value="60">1시간</option>
			 					<option value="90">1시간30분</option>
			 					<option value="120">2시간</option>
			 					<option value="150">2시간30분</option>
			 					<option value="180">3시간</option>
			 				</select>
			 				<div class="sortBtnGroup">
				 				<div class="sortBtn"><span class="glyphicon glyphicon-wrench"></span></div>
				 				<div id="deleteTemp" class="deleteTemp sortBtn" data="${status.index}"><span class="glyphicon glyphicon-trash"></span></div>
			 				</div>
						</div>
					
					</div>
				</div>
				
				<div id="travel_data${status.index}" class="travel_data">
						소요시간 : 30분 1km
				</div>
				 --%>
			</div>
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
	