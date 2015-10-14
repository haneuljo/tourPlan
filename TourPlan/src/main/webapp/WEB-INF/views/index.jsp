<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ---- 여기까지 모든 jsp 일단 복사 ---- -->  
<div class="area_top">
</div>

<div class="container" style="margin-top: 10px; margin-bottom: 10px;">
<c:if test="${!empty sessionScope.loginInfo.email}">

	<div id="indexLogin" class="shadowAll">
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

<div style="margin-top:3%; height: 600px;">
  	<div align="center" class="titleName">인기 관광지 TOP 8</div>
  	<div align="center" class="subTitle">대한민국 어디까지 가봤니?</div>
  	
	  	<c:if test="${clipList !=null }">
	  	<c:forEach items="${clipList}" var="cdto" >
	  	<div class="clipBox shadowAll">
	  		<div class="imageBox">
	  			<img src="${cdto.firstimage }">
	  		</div>
	  		<div class="contentTextBox">
		  		<div class="titleBox">
			  		<div class="title">${cdto.title }</div>
		  		</div>
		  		<div class="clipAreaBox">
			  		<div class="clip"><span class="glyphicon glyphicon-send indexIcon"> ${cdto.clipCount }</span></div>
			  		<div class="area"><span class="glyphicon glyphicon-road indexIcon"> ${cdto.area }</span></div> 
		  		</div>
		  		</div>
	  		</div>
	  	</c:forEach>
	  	</c:if>
	
  </div>
  <div class="shadowAll btn" style="height: 40px; width:250px; background-color:#fff; margin-left:440px; margin-bottom: 20px;">
  <span style="color:#000042; " class="glyphicon glyphicon-triangle-bottom"></span> 더 많은 관광지 보기
  </div>
</div>
