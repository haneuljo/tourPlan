<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ---- 여기까지 모든 jsp 일단 복사 ---- -->  
<div class="area_top">
</div>

<c:if test="${!empty sessionScope.loginInfo.email}">
<div style="height: 100px; width: 900px; border: 1px solid; margin-left:20%; margin-top:2%; float: left; overflow: hidden;">
	
	<div style="width: 600px; border: 1px solid; float: left; overflow: hidden;" >
		<div style="width: 120px;  border: 1px solid;">
			<img src="/tourPlan/resources/profile.jpg" style="width: 65px; height: 65px; border-radius:50px;">
		</div>
		<div style="width: 480px; height:20px; border: 1px solid;">
			${name}			
		</div>
		
		<div style="width: 2%; border: 1px solid;"></div>
		
		<a href="#" style="width: 120px; height:80px; border: 1px solid;" >
			<b>클립보드</b>
			<span>${clipCount}</span>
		</a>
		
		<!-- <div style="width: 2%; border: 1px solid;">&nbsp;</div> -->
		
		<a href="#" style="width: 120px; height:80px; border: 1px solid;">
			<b>여행일정</b>
			<span>${planCount}</span>
		</a>
		
	<!-- 	<div style="width: 2%; border: 1px solid;">&nbsp;</div> -->
		
		<a href="#" style="width: 120px; height:80px; border: 1px solid;">
			<b>리뷰</b>
			<span>${reviewCount}</span>
		</a>
		
		<!-- <div style="border: 1px solid;">&nbsp;</div> --><!-- 라인 -->
		
		<a href="#"  style="border: 1px solid;">
			<b>Q&A</b>
			<span>0</span>
		</a>
		
		<div style="border: 1px solid;"></div>
	</div>
	
	<a href="#" style="border: 1px solid;">
	<div style="width: 100px; border: 1px solid;">
		<div style="border: 1px solid;">
			<img src="" alt=""/>
		</div>
		질문하기			
	</div>
	</a>
	
	<a href="#" style="width: 100px; border: 1px solid;">
	<div style="border: 1px solid;">
		<div style="border: 1px solid;">
			<img src="" alt=""/>
		</div>
		리뷰쓰기			
	</div>
	</a>
	<a href="#" style="width: 100px; border: 1px solid;">
	<div style="border: 1px solid;">
		<div style="border: 1px solid;">
			<img src="" alt=""/>
		</div>
		일정만들기			
	</div>
	</a>
	
</div>
</c:if>
<div class="container">

<!--   <h3> 혜란언니 : footer에 Copyright ⓒ 2015 TourPlan, All Rights Reserved. , 구글 공공데이터 써주기
  색상 : #006583 <br>
  래경언니 : travelMain 디자인  <br>
  태훈오빠 : Main - session 체크해서 메인이랑, 로그인하고나서 디자인 & header<br>
  상훈오빠 : 일정 세부목록 select <br>
  종우오빠 : 기능먼저 하고 상훈오빠랑 select <br>
  </h3> -->
</div>

