<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500" />


<style class="cp-pen-styles">* {
  box-sizing: border-box;
}
body {
  font-family: Roboto, sans-serif;
  font-weight: 400;
}
h1 {
  font-size: 50px;
  line-height: 40px;
  font-weight: 100;
}
p {
  margin-bottom: 1em;
}
a {
  color: #61c7b3;
  text-decoration: none;
  transition-duration: .3s;
}
a:hover {
  color: #338f7d;
  transition-duration: .05s;
  text-decoration: none;
}
li {
list-style-type: none; 
}
#sidebar {
  top: 0;
  left: 0;
  height: 100%;
  width: 200px;
  transition-duration: .3s;
}
#sidebar,
#sidebar a {
  color: #abb4be;
}
#sidebar .logo-container {
  font-weight: 100;
  font-size: 50px;
  line-height: 40px;
  text-align: center;
  margin: 50px 0;
  cursor: pointer;
}
#sidebar .logo-container .logo {
  position: relative;
  top: -6px;
  font-size: 25px;
  margin-right: 15px;
  padding: 10px;
  border: 2px solid #61c7b3;
  border-radius: 100px;
  text-indent: 1px;
  color: #61c7b3;
}
#sidebar .compose-button {
  border-radius: 100px;
  padding: 13px 20px;
  text-align: center;
  font-weight: 500;
  text-transform: uppercase;
  color: #61c7b3;
  border: 2px solid #61c7b3;
  display: block;
  margin: 0 50px 30px 50px;
  cursor: pointer;
}
#sidebar .compose-button:hover {
  color: #abb4be;
  border-color: #abb4be;
}
#sidebar .menu-segment {
  padding: 0 50px 0 70px;
}
#sidebar .menu-segment ul,
#sidebar .menu-segment li {
  margin: 0;
  padding: 0;
}
#sidebar .menu-segment li a {
  display: block;
  margin: 0 -50px 0 -70px;
  padding: 10px 50px 10px 70px;
}
#sidebar .menu-segment li a:hover {
  background: #21262d;
}
#sidebar .menu-segment li .italic-link {
  margin-left: -30px;
  font-style: italic;
  color: #465162;
}
#sidebar .menu-segment li .italic-link,
#sidebar .menu-segment li .italic-link:hover {
  background: transparent;
}
#sidebar .menu-segment li .italic-link:hover {
  color: #abb4be;
}
#sidebar .separator {
  margin: 30px 35px;
  height: 1px;
  background: #2D3138;
}
#sidebar .bottom-padding {
  height: 100px;
}
#sidebar > .nano-pane {
  background: transparent;
}
#sidebar > .nano-pane .nano-slider {
  background: rgba(255, 255, 255, 0.1);
}

</style></head><body>
<div id="sidebar" class="nano" style="float: left;">
  <div class="nano-content">
    <div class="logo-container"><span class="logo glyphicon glyphicon-envelope"></span></div><a href="<%=cp%>/group/updateGroup.action" class="compose-button">그룹참여</a>
    <div class="separator"></div>
    <menu class="menu-segment">
      <ul>
		<li class=""><a href="<%=cp%>/group/idea.action">그룹소개</a></li>
		<li class=""><a href="<%=cp%>/contributionInfo.action?gNo=${gNo}">${gNo}그룹통계</a></li>
      </ul>
    </menu>
        <div class="separator"></div>
    <menu class="menu-segment">
      <ul>
		<li class=""><a href="<%=cp%>/group/idea.action">아이디어</a></li>
		<li class=""><a href="<%=cp%>/group/sketch.action">스케치게시판</a></li>
		<li class=""><a href="<%=cp%>/group/3D.action">3D모델링</a></li>
      </ul>
    </menu>
    <div class="separator"></div>
    <div class="bottom-padding"></div>
  </div>
</div>

</body></html>