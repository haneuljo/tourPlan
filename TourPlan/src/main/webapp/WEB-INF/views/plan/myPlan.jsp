<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>
<!-- 이미지&바 묶기  -->
<div style="width: 100%;">
	<div style="height:400px; background:url(/tourPlan/resources/image/planComplbg.jpg) center;">
		<div style="font-size: 40pt; color: white; padding-top: 250px;" align="center" >여행일정</div>
	</div>
<div style="margin-top: 10px; margin-bottom: 10px;"></div>
	
	<c:if test="${!empty sessionScope.loginInfo.email}">

	<div id="indexLogin">
		<div class="indexLoginProfile">
			<img src="/tourPlan/resources/profile.jpg">
		</div>
		<div class="indexLoginText">
	
			<div class="indexLoginName">
				${name}		
			</div>
			<div>
				<div class="indexLoginContent">
					<span class="contentTitle">클립보드</span><br>
					<span class="contentCount">${clipCount}</span>
				</div>
				<div class="indexLoginContent">
					<span class="contentTitle">여행일정</span><br>
					<span class="contentCount">${planCount}</span>
				</div>
				<div class="indexLoginContent">
					<span class="contentTitle" style="padding-left: 14px;">리　뷰</span><br>
					<span class="contentCount">${reviewCount}</span>
				</div>
				<div class="indexLoginContent">
					<span class="contentTitle" style="padding-left: 12px;">Q & A</span><Br>
					<span class="contentCount">0</span>
				</div>
			</div>
		</div>
		
		
		<div id="indexLoginBtn">
			<div class="indexBtn">
				<span class="glyphicon glyphicon-calendar"></span><br>
				<span style="font-size: 7.5pt; margin-left: 10px;">일정만들기</span>
			</div>
			<div class="indexBtn">
				<span class="glyphicon glyphicon-pencil"></span><br>
				<span style="font-size: 9pt; margin-left: 12px;">리뷰쓰기</span>
			</div>
			<div class="indexBtn">
				<span class="glyphicon glyphicon-question-sign"></span><br>
				<span style="font-size: 9pt; margin-left: 12px;">질문하기</span>
			</div>		
		</div>
		

	</div>	

</c:if>
</div>
<!-- 이미지&바 묶기  -->

<br/>
		
<!-- 일정뿌리는곳 묶기 -->
<div style="width: 1300px; height: 100%; padding-left: 14%;" >
	<c:forEach var="dto" items="${lists}" varStatus="status">
<!-- for문?  -->
<div class="clipBox shadowAll" style="width: 300px; height: 250px; border: 1px solid; border-color: #BDBDBD; float: left; overflow: hidden; margin-left: 1%;margin-right: 1%; margin-bottom: 3%;">
	
	<div>	
		<a onclick="javascript:location.href='<%=cp%>/myPlanCompl?groupNum=${dto.groupNum}&title=${dto.title}'"><img src="${dto.firstimage}" style="width: 300px; height: 150px;"></a>
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
