<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ---- 여기까지 모든 jsp 일단 복사 ---- -->  
<div class="area_top">
</div>
<div class="container">

<c:if test="${!empty sessionScope.loginInfo.email}">
<div class="">
	<div class="">
		<img class="" src="" onError="">
		<div class="">
			<div class="">
				${name}			
			</div>
			<div class=""></div>
			<a href="#" class="">
				<b>클립보드</b>
				<span>${clipCount}</span>
			</a>
			<div class="">&nbsp;</div>
			<a href="#" class="">
				<b>여행일정</b>
				<span>${planCount}</span>
			</a>
			<div class="">&nbsp;</div>
			<a href="#" class="">
				<b>리뷰</b>
				<span>${reviewCount}</span>
			</a>
			<div class="">&nbsp;</div><!-- 라인 -->
			<a href="#" class="#">
				<b>Q&A</b>
				<span>0</span>
			</a>
			<div class=""></div>
		</div>
		
		<a href="#" class="">
		<div class="">
			<div class="">
				<img src="" alt=""/>
			</div>
			질문하기			
		</div>
		</a>
		<a href="#" class="">
			<div class="">
				<div class="">
					<img src="" alt=""/>
				</div>
				리뷰쓰기			
			</div>
		</a>
		<a href="#" class="">
			<div class="">
				<div class="">
					<img src="" alt=""/>
				</div>
				일정만들기			
			</div>
		</a>
		<div class="clear"></div>
	</div>
</div>
</c:if>

  <h3> 혜란언니 : footer에 Copyright ⓒ 2015 TourPlan, All Rights Reserved. , 구글 공공데이터 써주기
  색상 : #006583 <br>
  래경언니 : travelMain 디자인  <br>
  태훈오빠 : Main - session 체크해서 메인이랑, 로그인하고나서 디자인 & header<br>
  상훈오빠 : 일정 세부목록 select <br>
  종우오빠 : 기능먼저 하고 상훈오빠랑 select <br>
  </h3>
</div>

