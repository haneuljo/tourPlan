<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();

%>
 
<div id="dayList">

		<div class="day" index="1">
			day1<br>
			<span class="cal">${startDate}</span>
		</div>
	  </div>
	<button id="dayAdd">추가</button>
	<button id="dayDelete">삭제</button>
	<script>
		var count=2;
		var day1;
		$("#dayAdd").click(function(){
			if($(".day:last").attr("index")==(count-1)){
				day1=$(".day:last>span").text();
				//alert(day1);
			}
			$.ajax({
		 		type:"GET",
				url:"<%=cp%>/dayCal?day1="+day1,
				dataType:"text",		
				success:function(data){
//					alert(data);
					$("#dayList").append('<div class="day" index="'+count+'">day'+count+'<br><span class="cal">'+data+'</span></div>');
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
	
	