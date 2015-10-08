<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<div id="dayList">
		<div class="day" index="1">
			day1
		</div>
	  </div>
	<button id="dayAdd">추가</button>
	<button id="dayDelete">삭제</button>
	<script>
		var count=2;
		$("#dayAdd").click(function(){
			
			$("#dayList").append('<div class="day" index="'+count+'">day'+count+'</div>');
			count++;
		});
		$("#dayDelete").click(function(){
			
			
			if($(".day:last").attr("index")!=1){
				
				$(".day:last").remove();
				count--;
				
			}
			
		});
	</script>
	
	