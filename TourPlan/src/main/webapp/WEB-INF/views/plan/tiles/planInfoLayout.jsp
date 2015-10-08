<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>

<div class="container">
	<div style="border:1px solid; float:left">
		<tiles:insertAttribute name="dayAdd"></tiles:insertAttribute>
	</div>
	<div style="border:1px solid; float:left">
		<tiles:insertAttribute name="plan"></tiles:insertAttribute>
	</div>

	<div style="border:1px solid; float:left">		
		<tiles:insertAttribute name="mapView"></tiles:insertAttribute>
	</div>

</div>
