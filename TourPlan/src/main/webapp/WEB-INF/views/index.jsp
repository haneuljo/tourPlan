<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ---- 여기까지 모든 jsp 일단 복사 ---- -->  
<div class="area_top">
</div>

<div class="container" style="margin-top: 10px; margin-bottom: 10px;">
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
