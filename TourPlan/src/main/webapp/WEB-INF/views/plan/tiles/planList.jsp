<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp = request.getContextPath();
%>
<div id="planList_All">
	<div class="listDiv">
		<div class="currentDay">
		</div>
		<div class="planListBtn">
			<button id="startSelectBtn" >출발지선택</button>
			<button  >경로최적화</button>
		</div>
		<div id="planList">
			<div class="startPlace">
			</div>
			<div id="result">
			</div>
		</div>
	</div>
	<div class="listDiv" style="border:1px solid #ccc;">
		<div class="selectArea">지역선택</div>
		<div class="clipMapView_info clipMapView_info_Header" ></div>
		<div id="clipMapViewContentType">
			<div class="contentTypeDetails contentTypeActive"  data="12">
				<span class="glyphicon glyphicon-camera"></span>
			</div>
			<div class="contentTypeDetails"  data="39">
				<span class="glyphicon glyphicon-cutlery"></span>
			</div>
			<div class="contentTypeDetails"  data="38">
				<span class="glyphicon glyphicon-credit-card"></span>
			</div>
			<div class="contentTypeDetails"  data="32">
				<span class="glyphicon glyphicon-home"></span>
			</div>
			<div class="contentTypeDetails"  data="12">
				<span class="glyphicon glyphicon-send"></span>
			</div>
		</div>					
		<div id="areaList"></div>
	</div>
	
</div>

		
	<script>
	
	
	$(function(){

		
		$(".currentDay").html($(".day").html());
		$(".day").css("background-color","#006583");
		
		$(".clipMapView_info_Header").hide();
		$("#clipMapViewContentType").hide();

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
				var img="<%=cp%>/resources/areaImg/"+(i+1)+".jpg";
				$("#areaList").append('<div class="planList_area"><img src="'+img+'" alt="areaImg"></img><span class="area_name">'+data.response.body.items.item[i].name+'</span><Button class="areaListBtn" data="'+data.response.body.items.item[i].code+'"> + </Button></div>')
			}
			 
			 $(".areaListBtn").click(function(){
				 areaCode=$(this).attr('data');
				//alert(areaCode);
				 //$("#areaList").css("overflow-y","hidden");
				 $(".planList_area").hide();
				 $(".clipMapView_info_Header").append($(this).parent('div').children('span').text());
				 $(".clipMapView_info_Header").show();
	   			 $("#clipMapViewContentType").show();
				 $("#areaList").css("height","453px");
				 //alert($(this).parent('div').children('span').text());
		 		 markerMap(12);
		 		 
			 });
		},error:function(e){}
	  });

	$(".contentTypeDetails").click(function(){
		$(".contentTypeDetails").attr("class","contentTypeDetails");
		$(this).attr("class","contentTypeDetails contentTypeActive");
		clearMarkers();
		image='/tourPlan/resources/marker/'+$(this).attr("data")+'.png';
		markerMap($(this).attr("data"));
		
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

				
			},
			error:function(e){11
				alert("1111111111"+e.responseText);
			}
			
		});
        
    });

		 
 });
</script>
	