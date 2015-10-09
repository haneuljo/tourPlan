<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

  
  <script type="text/javascript">
	function register(){
		
		var f = document.planForm;
		
		f.action = "<%=cp%>/register";
		f.submit();
	}
	</script>
	
<div class="container">

	<div style="border:1px solid; float:left">
		
		day1<br>
		${startDate}
	</div>
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
	<div style="border:1px solid; float:left">
	
		<div id="map"></div>	
	
	</div>
</div>