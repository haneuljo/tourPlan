<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>

<script>
	$(function(){
		 $.ajax({
			  type:"GET",
			  url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&numOfRows=17&MobileOS=ETC&MobileApp=AppTesting&_type=json",
			  dataType:"json",
			  success:function(data){	
				$('#selectArea').empty();
				$("#selectArea").append('<option value="0">선택</option>');
				for(i=0;i<data.response.body.items.item.length;i++){	
					$("#selectArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
				}
			},error:function(e){}
		  });
		  $("#selectArea").change(function(){
			  areaCode=$("#selectArea option:selected").val();
			  //지역별로 시구군 코드가 다르므로 !!! numOfRows check할것
			  $.ajax({
				type:"GET",
				url:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?ServiceKey=sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D&areaCode="+areaCode+"&MobileOS=ETC&MobileApp=AppTesting",
				dataType:"json",		
				success:function(data){
					$('#selectSubArea').empty();
					$("#selectSubArea").append('<option value="0">선택</option>');
					for(i=0;i<data.response.body.items.item.length;i++){	
						$("#selectSubArea").append('<option value="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</option>')
					}
				},error:function(e){}
			});
		});
		/* $("#selectSubArea").change(function(){
			sigunguCode=$("#selectSubArea option:selected").val();
		}); */
	});
</script>
<div style="border:1px solid; float:left">일정이 들어갈 부분
	
		<div id="result"></div>
	</div>
	<div style="border:1px solid; float:left">
		지역 :
		<button id="startsel">출발지선택</button>
	<select id="selectArea" style="width: 116px;">
		<option value="0">선택</option>
	</select>
		<button id="btn">검색</button>
			
	</div>
	