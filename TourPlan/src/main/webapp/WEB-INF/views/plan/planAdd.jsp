<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	String cp = request.getContextPath(); %>    
    <script>
	$(function() {

		  $( "#startDate" ).datepicker({
			  dateFormat: "yy-mm-dd",
			  monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
		  });

	});
    </script>
	<div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> sign</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" action="<%=cp%>/planOk" method="post">
            <div class="form-group">
              <label for="title"><span class="glyphicon glyphicon-user"></span> Title</label>
              <input type="text" name="title" class="form-control" id="title" placeholder="Enter title">
            </div>
            
            <div class="form-group">
              <label for="startDate"><span class="glyphicon glyphicon-eye-open"></span>시작날짜</label>
              <input type="text" name="startDate" class="form-control" id="startDate" placeholder="Enter startDate">
            </div>
            
            
             <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> 등록</button>
          </form>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소</button>
        </div>
      </div>
      
    </div>