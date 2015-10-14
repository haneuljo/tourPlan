<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>    
    
	<div class="modal-dialog" style="width: 400px; height: 500pxl">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px; background-color: #000042;" >
          <button type="button" class="close" data-dismiss="modal" style="margin-top: -10;">&times;</button>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form name="myForm" action="" id="myForm" method="post">
            <div>
              <div style="float: left;">
	              <label for="startDate" style="
    margin-bottom: 0px;
    margin-right: 10px;
    margin-top: 5px;
	              "><span class="glyphicon glyphicon-time"></span> 출발시간</label>
              </div>
              <div style="float: left;width: 200px;">
              	  <div style="float: left; width: 100px;">

		              <span style="float:left;margin-left: 5px;margin-top: 5px;">시</span>
	              </div>
	              <div style="float: left; width: 100px;">

		              <span style="float:left;margin-left: 5px;margin-top: 5px;">분</span>
	              </div>
	              
              </div>
            </div>
            
            <div class="form-group">
              <label for="address1" style="width: 300px;"><span class="glyphicon glyphicon-home"></span> 출발지</label>
              	<div style="float:left;">
	              <input type="text" name="address1" class="form-control" id="address1" placeholder="강남역" style=" width: 220px;">
              	</div>
              	<div style="float:left; margin-left: 10px;">
	              <input id="submit1" type="button" value="검색" class="btn" style="background-color: #FF7012; color:#fff;" >
              	</div>
            </div>
            
            <div class="form-group">
              <label for="address2"  style="width: 300px;"><span class="glyphicon glyphicon-flag"></span> 도착지</label>
              	<div style="float:left;">
              	  <input type="text" name="address2" class="form-control" id="address2" placeholder="영등포" style=" width: 220px;">
              	</div>
              	<div style="float:left;margin-left: 10px;">
	              <input id="submit2" type="button"  value="검색" class="btn" style="background-color: #FF7012; color:#fff;" >
              	</div>
            </div>
            
            <input id="Gdirection" type="button" value="길찾기"  class="btn" style="width: 286px;margin-top: 10px; background-color: #FF7012; color:#fff;"/>
           
            <!-- <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> 찾기</button> -->
          <div id="rootList" align="center" style="margin-top:20px; margin-left:0px; border:1px solid #ccc;"></div>
          
          <input type="hidden" name="durTime" id="durTime">
          <input type="hidden" name="startDate" id="startDate">
          <input type="hidden" name="mapx" id="mapx">
          <input type="hidden" name="mapy" id="mapy">
          
          
          
          </form>
        </div>
        <div class="modal-footer">
          <input type="button" value=" 등 록 " onclick="startPut();" class="btn btn-default pull-right" style="background-color: #000042; color:#fff;"/>
        </div>
      </div>
      
    </div>