<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>GodShop</title>
  </head>

  <body>
    <div id="container">
    <div><tiles:insertAttribute name="header"></tiles:insertAttribute></div>
    <div style="width: 200px;"><tiles:insertAttribute name="leftMenu"></tiles:insertAttribute></div>
    <div><tiles:insertAttribute name="content"></tiles:insertAttribute></div>
    <div><tiles:insertAttribute name="footer"></tiles:insertAttribute></div>
    </div>
  </body>
</html>