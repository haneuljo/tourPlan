<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	String cp = request.getContextPath(); %>    
    
	<div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Login</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" action="<%=cp%>/memberLogin" method="post">
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> Email</label>
              <input type="text" name="email" class="form-control" id="email" placeholder="Enter email">
            </div>
            
            <div class="form-group">
              <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
              <input type="text" name="pwd" class="form-control" id="psw" placeholder="Enter password">
            </div>
            
              <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button>
          </form>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
        </div>
      </div>
      
    </div>