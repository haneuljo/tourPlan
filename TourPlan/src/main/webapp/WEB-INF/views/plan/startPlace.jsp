<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>    
    
	<div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> 출발지선택</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" action="<%=cp%>/memberSign" method="post">
            <div class="form-group">
              <label for="startDate"><span class="glyphicon glyphicon-eye-open"></span> 출발시간</label>
              <select name="hour">
              <c:forEach var="i" begin="0" end="24" step="1">
              	<option value="${i}">${i}</option>
              </c:forEach>
              </select>시
                <select name="time">
              <c:forEach var="i" begin="0" end="60" step="10">
              	<option value="${i}">${i}</option>
              </c:forEach>
              </select>분
            </div>
            
            <div class="form-group">
              <label for="startPlace"><span class="glyphicon glyphicon-user"></span> 출발지</label>
              <input type="text" name="startPlace" class="form-control" id="startPlace" placeholder="강남역">
              <input id="address1" type="button" value="검색"/>
            </div>
            
            <div class="form-group">
              <label for="endPlace"><span class="glyphicon glyphicon-eye-open"></span> 도착지</label>
              <input type="text" name="endPlace" class="form-control" id="endPlace" placeholder="영등포">
              <input id="address1" type="button" value="검색"/>
            </div>
            
            <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> 찾기</button>
          </form>
          
          <div id="rootList"></div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
        </div>
      </div>
      
    </div>