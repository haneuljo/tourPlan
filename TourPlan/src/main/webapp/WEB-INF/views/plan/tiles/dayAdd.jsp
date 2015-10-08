<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<div id="dayList">
		<div class="day" index="1">
			day1${startDate}
		</div>
	  </div>
	<button id="dayAdd">추가</button>
	<button id="dayDelete">삭제</button>
	<script>
		var count=2;
		$("#dayAdd").click(function(){
			
			$("#dayList").append('<div class="day" index="'+count+'">day'+count+'</div>');
			count++;
		});
		$("#dayDelete").click(function(){
			
			
			if($(".day:last").attr("index")!=1){
				
				$(".day:last").remove();
				count--;
				
			}
			
		});
	</script>
	
	