<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String cp = request.getContextPath();

%>
 
 <fmt:parseDate value="${startDate}" pattern ="yyyy-MM-dd" var="date"> </fmt:parseDate>
<div class="dayAdd">	
	<div id="dayList">
		<div class="day" index="1">
			<span class="dayCount">DAY1</span>
			<span class="cal">
				<fmt:formatDate value="${date}" pattern="yy.MM.dd"></fmt:formatDate>
			</span>
		</div>
	</div>
	<div class="dayBtnDiv">
		<button id="dayDelete" class="dayAddBtn">삭제</button>
		<button id="dayAdd" class="dayAddBtn">추가</button>
	</div>
</div>
	<script>
		var count=2;
		var day1;
		$("#dayAdd").click(function(){
			if($(".day:last").attr("index")==(count-1)){
				if(count==2){
					day1='${startDate}'					
				}else{
				
					var dateFormat = $(".day:last>span:last").text().split(".");
					day1 = "20"+dateFormat[0] + "-" +dateFormat[1] + "-" +dateFormat[2];

				}
				//alert(day1);
			}
			$.ajax({
		 		type:"GET",
				url:"<%=cp%>/dayCal?day1="+day1,
				dataType:"text",		
				success:function(data){

					var dateFormat = data.split("-");
					var dateFormatChange = dateFormat[0].substring(2) + "." +dateFormat[1] + "." +dateFormat[2];
//					alert(data);
					$("#dayList").append('<div class="day" index="'+count+'"><span class="dayCount">DAY'+count+'</span> <span class="cal">'+dateFormatChange+'</span></div>');
					count++;
				},
					error:function(e){
						//alert("1111111111"+e.responseText);
					}
			});
		});
		$("#dayDelete").click(function(){
			if($(".day:last").attr("index")!=1){
				
				$(".day:last").remove();
				count--;
				
			}
			
		});
	</script>
	
	