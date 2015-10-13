<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp = request.getContextPath();
%>



내일정 : ${listsSize}
 			<c:forEach var="dto" items="${lists}" varStatus="status">
 			
				<div class="plan"><a onclick="javascript:location.href='<%=cp%>/myPlanCompl?groupNum=${dto.groupNum}'">${dto.title }</a> </div>

			</c:forEach>
