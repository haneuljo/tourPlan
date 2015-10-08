<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

<div class="container">
	<div>
	  <c:if test="${myClipCount != 0 }">
	      <c:forEach var="dto" items="${clipList }">
	         <div>
	         <a style="text-decoration: none" href="<%=cp%>/article.action?contentid=${dto.contentid}" >      
	            <img alt="" src="${dto.firstimage}"></a>         
	         </div>
	         <div>
	         <a style="text-decoration: none" href="<%=cp%>/article.action?contentid=${dto.contentid}" >
	            ${dto.title}
	         </a>
	         </div>
	      
	      </c:forEach>
      </c:if>
	</div>

</div>
