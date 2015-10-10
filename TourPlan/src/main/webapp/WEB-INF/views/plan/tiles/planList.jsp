<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>

		
	<script>
	$(function(){
	$("#areaList").hide();
	 $.ajax({
		  type:"GET",
		  url:"<%=cp%>/areaCodeAPI",
		  dataType:"json",
		  success:function(data){	
			for(i=0;i<data.response.body.items.item.length;i++){	
				$("#areaList").append('<div class="planList_area">'+data.response.body.items.item[i].name+'<Button class="planList_btn" data="'+data.response.body.items.item[i].code+'">+</Button></div>')
			}
			 
			 $(".planList_btn").click(function(){
				 areaCode=$(this).attr('data');
				// alert(areaCode);
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
				
				$("#areaList").show();
				
			},
			error:function(e){11
				alert("1111111111"+e.responseText);
			}
			
		});
        
    });

		 
 });
</script>
	<div style="border:1px solid; float:left">
		<button id="startSelectBtn">출발지선택</button>
		<div id="result"></div>
	</div>
	<div style="border:1px solid; float:left">
		<div id="areaList"></div>
	</div>
