<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<tiles:insertAttribute name="header"></tiles:insertAttribute>
<tiles:insertAttribute name="content"></tiles:insertAttribute>
<tiles:insertAttribute name="footer"></tiles:insertAttribute>
