<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	String cp = request.getContextPath(); %>

 <link rel="stylesheet" href="<%=cp%>/resources/css/travelMain.css" type="text/css"/>
<div class="travelMainimage"></div>
<div class="container">

	<div id="areaContainer">
		<div id="seoul" class ="area area0">서울</div>
		<div id="incheon" class ="area area1">인천</div>
		<div id="daejeon" class ="area area2">대전</div>
		<div id="daogu" class ="area area3">대구</div>
		<div id="gwangju" class ="area area4">광주</div>
		<div id="busan" class ="area area5">부산</div>
		<div id="ulsan" class ="area area6">울산</div>
		<div id="sejong" class ="area area7">세종</div>
		<div id="gyeonggi" class ="area area8">경기도<span class="caret"></span></div>
		<div id="gangwon" class ="area area9">강원도<span class="caret"></span></div>
		<div id="chungbuk" class ="area area10">충청북도<span class="caret"></span></div>
		<div id="chungnam" class ="area area11">충청남도<span class="caret"></span></div>
		<div id="sigungu1" class="sigungu"></div>
		<div id="gyeongbuk" class ="area area12">경상북도<span class="caret"></span></div>
		<div id="gyeongnam" class ="area area13">경상남도<span class="caret"></span></div>
		<div id="jeonnam" class ="area area14">전라북도<span class="caret"></span></div>
		<div id="jeonbuk" class ="area area15">전라남도<span class="caret"></span></div>
		<div id="jeju" class ="area area16">제주도</div>
		<div id="sigungu2" class="sigungu"></div>
	</div>
	<form name="clip" method="post">
	<div>
		<ul class="nav nav-tabs">
		    <li class="active"><a href="#">관광</a></li>
		    <li><a href="#">숙박</a></li>
		    <li><a href="#">음식점</a></li>
		    <li><a href="#">쇼핑</a></li>
		</ul>
		
	
	</div>
	<div id="clipResult"></div> 

	</form>
	
	<script>
		var areaCode;
		var sigunguCode=0;
		$.ajax({
	 		type:"GET",
			url:"<%=cp%>/areaCodeAPI",
			dataType:"json",		
			success:function(data){
				var count=0;
				for(i=0;i<data.response.body.items.item.length;i++){	
					$(".area"+i).attr("data", data.response.body.items.item[i].code);
					$(".area"+i).attr("index", count);

					if((i+1)%6==0 || i==data.response.body.items.item.length-1){
						count++;
					}
				}

			},
				error:function(e){
					//alert("1111111111"+e.responseText);
				}
		});
		
		$(".area").click(function(){
			areaCode=$(this).attr('data');
			if($(this).children("span").length==1){
				var index=$(this).attr('index');
				//alert(index);
				$(".sigugun").hide();
				$.ajax({
					type:"GET",
					url:"<%=cp%>/sigunguCodeAPI?areaCode="+areaCode,
					dataType:"json",		
					success:function(data){
						$("#sigungu"+index).empty();
						//alert(data);
						for(i=0;i<data.response.body.items.item.length;i++){
							$("#sigungu"+index).append('<div class="sigungu_info" data="'+data.response.body.items.item[i].code+'">'+data.response.body.items.item[i].name+'</div>');
															
						}  
						
						$("#sigungu"+index).show();
						$("#sigungu"+index+" div").bind("click", function(){
							
							sigunguCode = $(this).attr('data');
							//alert(sigunguCode);
							clipCount(1);
						});
							
					},	error:function(e){alert("1111111111"+e.responseText);}
				});		
			}else{
				$(".nav-tabs").show();
				clipCount(1);
			}
			
		});
		
		
		function clipCount(page){
			$.ajax({
				type:"GET",
				url:"<%=cp%>/travelMain?areaCode="+areaCode+"&sigunguCode="+sigunguCode+"&page="+page,
				dataType:"json",		
				success:function(data){
					
					$("#clipResult").empty();
					//alert(data);
					
					$.each(data, function(index, value) {
						$("#clipResult").append('<div class="travel_info" onclick="article('+value.contentid+');"><div class="imageBox"><img style="width: 238px; height: 150px;" src="'+value.firstimage+'"/></div><div class="titleBox" align="left"><font style="font-size: 13pt; font-weight:bold; margin-left: 5px;"> '+value.title+'</font><br/><span style="font-size: 12pt; color : #A6A6A6; margin-left: 5px; margin-top: 8px;" class="glyphicon glyphicon-send"> '+value.clipCount+'</span></div>');
					});  
					 
					
					if(page==1){
						$(".pagination").empty();
						//alert('${sessionScope.clipJSON.totalPage}');
						
						for(var i=1; i<=10; i++){
/* 						for(var i=1; i<='${sessionScope.clipJSON.totalPage}'; i++){ */
							
							$(".pagination").append('<li><a href="javascript:clipCount('+i+')">'+i+'</a></li>');
							
						}
						
						
					}
	
				},
				error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }			
			
			});
			
		}
		

		function article(cd) {
	 		
	 		var f=document.clip;
			
	 		f.action = '<%=cp%>/clipArticle?contentid=' +cd;
	 		f.submit();
	 		
		} 	
	
	</script> 
  
  	<div id="page">
  		<ul class="pagination">
  		</ul>
  	</div>
 
  
</div>