<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div class="container">
<button type="button" class="btn btn-primary" onclick="location='<%=cp%>/forTest'">ForTest</button>
<form action="">

	<div id="example-1-1">
		<div class="sortable-list" style="width: 450;float: left;">

 			<c:forEach var="map" items="${lists}" varStatus="status">
				<div id="sortable_item-${status.index}" style="border: solid 1px;" onprogress="initMap(${map.mapx},${map.mapy});">
					<div style="height: 120;width: 470" class="sortable-item">
					<div style="float: left;"><img style="width:100px; height:100px" alt="" src="${map.firstimage }"></div>
				 	<div> <h3>${map.title}//index:${status.index}</h3></div>
	 				<div> ${map.addr1} ${map.addr2 }</div>
	 				<div class="btn-group">
					   <button type="button" class="btn btn-primary">수정//${map.mapx}</button>
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
<!-- 			<div id="right-panel"></div>
   			 <div id="map" style="width: 300px;height: 300px;float: right;"></div> -->
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
			            dataType:"json",
			            type: 'POST',
			            url: '<%=cp%>/orderUpdate'
			        }); 
			    }
			});
		});
		</script>
