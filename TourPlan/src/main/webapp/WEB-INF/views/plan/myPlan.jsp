<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

  
<div class="container">
<c:forEach var="dto" items="${lists}">
${dto.planNum } //${dto.groupNum }//${dto.contentid }//${dto.contenttypeid }//${dto.content }//${dto.startDate }//${dto.endDate }<br/>
</c:forEach>
  
</div>
