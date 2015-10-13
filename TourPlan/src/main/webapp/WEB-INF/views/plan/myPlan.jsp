<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>



내일정 : ${listsSize}
 			<c:forEach var="dto" items="${lists}" varStatus="status">
 			
				<div class="plan"><a onclick="javascript:location.href='<%=cp%>/myPlanCompl?groupNum=${dto.groupNum}'">${dto.title }</a> </div>

			</c:forEach>
<!-- 이미지&바 묶기  -->
<div style="width: 100%;">
	<div style="width:100%; height:300px; background:url(/tourPlan/resources/image/8.jpg) center;">
		<div style="font-size: 40pt; color: white; padding-top: 150px;" align="center" >여행일정</div>
	</div>
	
	<div class="container" style="width: 100%">
	  <ul class="nav nav-tabs">
	    <li style="padding-left: 20%; font-size: 12pt;"><a href="#">클립보드</a></li>
	    <li style="font-size: 12pt;"><a href="#">여행일정</a></li>
	    <li style="font-size: 12pt;"><a href="#">리뷰</a></li>
	  </ul>
	</div>
</div>
<!-- 이미지&바 묶기  -->

		
<!-- 일정뿌리는곳 묶기 -->
<div style="width: 1300px; height: 100%; padding-left: 14%;" >
	<c:forEach var="dto" items="${lists}" varStatus="status">
<!-- for문?  -->
<div style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<a onclick="javascript:location.href='<%=cp%>/myPlanCompl?groupNum=${dto.groupNum}'"><img src="${dto.firstimage}" style="width: 300px; height: 150px;"></a>
	</div>
	
	<div style="width: 300px; height: 100px;">
		<div style="color: #01A6BC; font-size: 14pt; float: left; overflow: hidden;">startDate</div>
		
		<div align="right" style="padding-right: 15px; padding-top: 4px;">
			<span class="glyphicon glyphicon-send"></span> : 0
			<span class="glyphicon glyphicon-map-marker"></span> : 0
		</div>
		
		<br/>
		
		<div style="clear: both; font-size: 12pt;">
			<b>${dto.title}</b>
		</div>
		
		<div style="font-size: 12pt;">
			${dto.groupNum}
		</div>
	
	</div>

</div>
<!-- for문?  -->
</c:forEach>


</div>
<!-- 일정뿌리는곳 묶기 -->
			