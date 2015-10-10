<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
     <!-- drag JavaScript files -->
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resources/dragJS/jquery-ui-1.8.custom.min.js"></script>

	<div id="example-1-1">
		<div class="sortable-list" style="width: 450;float: left;">

 			<c:forEach var="map" items="${lists}" varStatus="status">
				<div id="sortable_item-${status.index}" style="border: solid 1px;" onprogress="initMap(${map.mapx},${map.mapy});">
					<div style="height: 120;width: 470" class="sortable-item">
					<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${map.firstimage }"></div>
				 	<div> <h3>${map.title}//index:${status.index}</h3></div>
	 				<div> ${map.addr1} ${map.addr2 }</div>
	 				<div class="btn-group">
	 				<select id="lonTime${status.index}">
	 					<option value="0">0</option>
	 					<option value="30">30분</option>
	 					<option value="60">1시간</option>
	 					<option value="90">1시간30분</option>
	 					<option value="120">2시간</option>
	 					<option value="150">2시간30분</option>
	 					<option value="180">3시간</option>
	 				</select>
					   <button type="button" class="btn btn-primary">수정//${map.mapx}</button>
					   <button id="deleteTemp" type="button" class="btn btn-primary deleteTemp" data="${status.index}">삭제</button>
					</div>
					</div>
					<input type="hidden" name="planNum" value="${map.planNum }">
					<input type="hidden" name="groupNum" value="${map.groupNum }">
					<input type=""text"" name="contentid" value="${map.contentid }contentid">
					<input type=""text"" name="contenttypeid" value="${map.contenttypeid }contenttypeid">
					<input type=""text"" name="longTime" value="${map.longTime }longtime">
					<input type=""text"" name="content" value="${map.content }content">
					<input type=""text"" name="startDate" value="${map.startDate }startDate">
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
<!-- 			<div id="right-panel"></div>
   			 <div id="map" style="width: 300px;height: 300px;float: right;"></div> -->
	</div>
	

	
	<!-- Example jQuery code (JavaScript)  -->
		
		<script type="text/javascript">

		$(document).ready(function(){                                                                    //드래그앤 드랍 및 순서 업데이트
			
			
			$(".deleteTemp").click(function(){
				var del_index = $(this).attr("data");
				//alert(del_index);
		    	$.ajax({
		            type:"POST",
					url:"<%=cp%>/deleteTemp",
					data:"index="+del_index,	
					success:function(args){
				           $("#result").html(args);
					},
			        error:function(e){
			            alert(e.responseText);
			         }
					
				});
				
			});

		        
			
		
		
			$('#example-1-1 .sortable-list').sortable({
			    axis: 'y',
			    update: function (event, ui) {
			        var data = $(this).sortable('serialize');
			        alert(data);
		 	        $.ajax({
		 	        	
			            data: data,
			            dataType:"json",
			            type: 'POST',
			            url: '<%=cp%>/orderUpdate'
			        }); 
			    }
			});
		});
		
		</script>
