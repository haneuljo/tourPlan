<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <script>
	$(document).ready(function(){
		$("#menu2").attr("class","active");
		
	    $("#btn").click(function(){
			// $(this).datepicker();
			// $(this).datepicker("show");
			$.ajax({
				type:"GET",
				url:"<%=cp%>/planAdd",
				dataType:"html",		
				success:function(data){
					$("#myModal").html(data);
					$("#myModal").modal();
				},
				error:function(e){
					alert("1111111111"+e.responseText);
				}
				
			});
	        
	    });
	});
	
  </script>
<div class="planInfo_top_img">
</div>
<div id="layer1">
  <input type="button" value="새로운일정" id="btn">&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div class="container">
	  
  <!-- <input type="button" value="나의일정"> -->
  
</div>

<style>
#layer1{background-color:#FFF; position:absolute; left:300px; top:100px;height:300px; z-index:1;}
</style>
 
