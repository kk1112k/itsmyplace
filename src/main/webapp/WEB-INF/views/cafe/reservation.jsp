<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"><!-- 아이콘요소 -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Construction Html5 Template">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
  <meta name="author" content="Themefisher">
  <meta name="generator" content="Themefisher Constra HTML Template v1.0">
  
  <!-- timepicker css-->
  <link type="text/css" rel="stylesheet" href="/resources/plugins/jquery/dist/jquery.timepicker.css" media=""/>
</head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

.seatStructure{
   margin: 0px 140px;
}

#seatsBlock {
	padding-top: 60px;
	padding-left: 60px;
}

/* 수정 */
.seat {
    display: inline-block;
}

.seat > img {
	 width : 53px;
	 height: 53px;
	 background: bottom;
}

.noemptySeat {
    margin: 0px 11px -1px 9px;
}

.table2 , .table1 , .table3, .table4, .table5{
    display: inline-block;
    margin
}

.table2 , .table3 ,.table4, .table5{
	padding-left: 140px;
}

.table4, .table5{
    padding-top: 80px;
}

</style>

<script type="text/javascript">

function selectTimeSeat(){
	
	$(":checkbox").prop('disabled', false);	
	$("input[type=checkbox]").prop("checked",false);
	
	for(var i=0; i<20; i++){	//좌석 초기화
		$("#img"+i).attr("src", "/resources/images/reservation/chairs.png");
		$("#seatsNum"+i).show();
		$("#img"+i).removeClass("noemptySeat");
	}
	

	var timeA = $("#timeSel option:selected").val();
	var cafeNumA = $("#cafeNum").val();
   
	$.ajax({
	   type: "POST",
	   url: "/cafe/selectSeatTime",
	   data: {
	      time: timeA,
	      cafeNum: cafeNumA
	   },
	   dataType: "JSON",
	   success: function(response){
	      if(response.code==0){
	         var seatNumList = response.data;
	         for(var i=0; i<seatNumList.length; i++){
	           var SeatNum = seatNumList[i]-1;
	           if(SeatNum == -1)	//선택좌석이 없을시
	           {
	        	   leftSeatA(0);
	         	   break;
	           }
	           $("#seatsNum"+SeatNum).hide();	//선택좌석이 있을시 이미지, 클래스추가
	           $("#img"+SeatNum).attr("src", "/resources/images/reservation/noemptyseat1.png");
	           $("#img"+SeatNum).addClass("noemptySeat");
	         }
	      }
	      leftSeatA(seatNumList.length);
	      tableCheck();	//예약된 테이블 잔여좌석 막기
	   },
	   error: function(error){
	      icia.common.error(error);
	   }
	});
	
	showSelectNum();
}

/* 카페마다 시간표현 함수 */
function timeSelSelect(cafeNumber) {
	
	//현재시간 구하기
	var now = new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var nowTime = (hours+1) + '00';
	
	//nowTime이랑 같은 인덱스 가져오기
	//nowTime이랑 select value값이 서로 같은 것의 index 값을 가져온다
	var index = $('select option[value='+nowTime+']').index();
	var timeSelSize = $("#timeSel option").length;
	
	for(var i=0; i<index; i++)
	{
		$('#timeSel option:eq('+i+')').attr('disabled', 'true');
	}
	
	// 운영시간에 따른 selectbox 표현
	if(cafeNumber == "A0000001")
	{
		$("#timeSel option[value='0900']").remove();
		$("#timeSel option[value='2200']").remove();
	}
	else if(cafeNumber == "A0000002")
	{
		$("#timeSel option[value='0900']").remove();
		$("#timeSel option[value='2200']").remove();
	}
	else if(cafeNumber == "A0000003")
	{
		$("#timeSel option[value='0900']").remove();
	}
	else if(cafeNumber == "A0000004")
	{
		$("#timeSel option[value='0900']").remove();
	}
}

/* 당일시간표현 함수*/
function printTime() {
	var clock = document.getElementById("clock");
	var now = new Date();
	clock.innerHTML = (now.getMonth()+1) + "월 " + now.getDate() + "일 " ;
}

function leftSeat() {
	var noEmptyleng = $("#seatsBlock").find('img.noEmpty').length;
	
	leftSeats.innerHTML =  (20-noEmptyleng) + "/20";
}

function leftSeatA(count) {
	var leftSeats = document.getElementById("leftSeats");
	if(count == 1)
	{
		leftSeats.innerHTML =  "20/20";
	}
	else
	{
		var leftSeats = document.getElementById("leftSeats");
		leftSeats.innerHTML =  (20-count) + "/20";
	}
}


//테이블별로 예약이되있다면 체크못하게 하는함수
function tableCheck() {

	if($("#table1").find('img.noemptySeat').length)
	{
		$('input#seatsNum0:checkbox').prop('disabled', true);
		$('input#seatsNum1:checkbox').prop('disabled', true);
		$('input#seatsNum2:checkbox').prop('disabled', true);
		$('input#seatsNum3:checkbox').prop('disabled', true);
	}
	if($("#table2").find('img.noemptySeat').length)
	{
		$('input#seatsNum4:checkbox').prop('disabled', true);
		$('input#seatsNum5:checkbox').prop('disabled', true);
		$('input#seatsNum6:checkbox').prop('disabled', true);
		$('input#seatsNum7:checkbox').prop('disabled', true);
	}
	if($("#table3").find('img.noemptySeat').length)
	{
		$('input#seatsNum8:checkbox').prop('disabled', true);
		$('input#seatsNum9:checkbox').prop('disabled', true);
		$('input#seatsNum10:checkbox').prop('disabled', true);
		$('input#seatsNum11:checkbox').prop('disabled', true);
	}
	if($("#table4").find('img.noemptySeat').length)
	{
		$('input#seatsNum12:checkbox').prop('disabled', true);
		$('input#seatsNum13:checkbox').prop('disabled', true);
		$('input#seatsNum14:checkbox').prop('disabled', true);
		$('input#seatsNum15:checkbox').prop('disabled', true);
	}
	if($("#table5").find('img.noemptySeat').length)
	{
		$('input#seatsNum16:checkbox').prop('disabled', true);
		$('input#seatsNum17:checkbox').prop('disabled', true);
		$('input#seatsNum18:checkbox').prop('disabled', true);
		$('input#seatsNum19:checkbox').prop('disabled', true);
	}
	
}

function getCheckboxValue(chairIndex)  {
	 
	//체크했을시
	 if($("input:checkbox[id='seatsNum"+chairIndex+"']").is(":checked"))
    {
       $("#img"+chairIndex).attr("src", "/resources/images/reservation/checkseat.png");
    }
    else
    {
       $("#img"+chairIndex).attr("src", "/resources/images/reservation/chairs.png");
    }


	
	//$("#seatsNum"+chairIndex).show();
	
	$('#table1').click(function(){
		$(":checkbox").prop('disabled', true);
		if ($('input[name="seats"]:checked').length == ($("#Numseats").val()))  //체크박스와 인원수가 같다면, 체크를못하게한다
		{
			 $(":checkbox").prop('disabled', true);
		}
		else
		{
			$('input#seatsNum0:checkbox').prop('disabled', false);
			$('input#seatsNum1:checkbox').prop('disabled', false);
			$('input#seatsNum2:checkbox').prop('disabled', false);
			$('input#seatsNum3:checkbox').prop('disabled', false);
		}
	});
	$('#table2').click(function(){
		$(":checkbox").prop('disabled', true);
		if ($('input[name="seats"]:checked').length == ($("#Numseats").val()))  //체크박스와 인원수가 같다면, 체크를못하게한다
		{
			$(":checkbox").prop('disabled', true);
		}
		else
		{
			$('input#seatsNum4:checkbox').prop('disabled', false);
			$('input#seatsNum5:checkbox').prop('disabled', false);
			$('input#seatsNum6:checkbox').prop('disabled', false);
			$('input#seatsNum7:checkbox').prop('disabled', false);
		}
	});
	$('#table3').click(function(){
		$(":checkbox").prop('disabled', true);
		if ($('input[name="seats"]:checked').length == ($("#Numseats").val()))  //체크박스와 인원수가 같다면, 체크를못하게한다
		{
			$(":checkbox").prop('disabled', true);
		}
		else
		{
			$('input#seatsNum8:checkbox').prop('disabled', false);
			$('input#seatsNum9:checkbox').prop('disabled', false);
			$('input#seatsNum10:checkbox').prop('disabled', false);
			$('input#seatsNum11:checkbox').prop('disabled', false);
		}
	});
	$('#table4').click(function(){
		$(":checkbox").prop('disabled', true);
		if ($('input[name="seats"]:checked').length == ($("#Numseats").val()))  //체크박스와 인원수가 같다면, 체크를못하게한다
		{
			$(":checkbox").prop('disabled', true);
		}
		else
		{
			$('input#seatsNum12:checkbox').prop('disabled', false);
			$('input#seatsNum13:checkbox').prop('disabled', false);
			$('input#seatsNum14:checkbox').prop('disabled', false);
			$('input#seatsNum15:checkbox').prop('disabled', false);
		}
	});
	$('#table5').click(function(){
		$(":checkbox").prop('disabled', true);
		if ($('input[name="seats"]:checked').length == ($("#Numseats").val()))  //체크박스와 인원수가 같다면, 체크를못하게한다
		{
			$(":checkbox").prop('disabled', true);
		}
		 //반복문돌린다 사람수만큼?
		else
		{
			$('input#seatsNum16:checkbox').prop('disabled', false);
			$('input#seatsNum17:checkbox').prop('disabled', false);
			$('input#seatsNum18:checkbox').prop('disabled', false);
			$('input#seatsNum19:checkbox').prop('disabled', false);
		}
	});
	showSelectNum();
	tableCheck();	
	
}

//화면 출력
function showSelectNum()
{
   
   var query = 'input[name="seats"]:checked';
   var selectedEls = document.querySelectorAll(query);
   var arrr = new Array();
   selectedEls.forEach((el) => {
      arrr.push(el.value);
   });
   
   if(arrr.length == 0)
   {
      document.getElementById('result').innerText = arrr + ""; 
   }
   else
   {
      document.getElementById('result').innerText = arrr + "입니다"; 
   }

}


function changePplSelect(){
	
	selectTimeSeat();	
		
	$(":checkbox").prop('disabled', false);	//체크박스 초기화
	if($("input:checkbox[name=seats]").is(":checked") == true) { //체크박스를 선택했었다면
		alert("인원수를 다시체크해주세요");
		$("input[type=checkbox]").prop("checked",false);	//체크박스 선택초기화
	}
	showSelectNum();
	tableCheck();
}
	
$(document).ready(function() {
	
	for(var i=0; i<20; i++){
		$("#img"+i).attr("src", "/resources/images/reservation/chairs.png");
		$("#seatsNum"+i).show();
	}
	
	//현재시간 구하기
	var now = new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var nowTime = (hours+1) + '00';
	
	//nowTime이랑 같은 인덱스 가져오기
	//nowTime이랑 select value값이 서로 같은 것의 index 값을 가져온다
	var index = $('select option[value='+nowTime+']').index();
    var timeA = $('#timeSel option:eq('+index+')').val();
    var cafeNumA = $("#cafeNum").val();
	
	$.ajax({
		type: "POST",
		url: "/cafe/selectSeatTime",
		data: {
		   time: timeA,
		   cafeNum: cafeNumA
		},
		dataType: "JSON",
		success: function(response){
		   if(response.code==0){
		      var seatNumList = response.data;
		      console.log(seatNumList);
		      for(var i=0; i<seatNumList.length; i++){
		        var SeatNum = seatNumList[i]-1;
		        if(SeatNum == -1)
		        {
		        	leftSeatA(0);
		      	  	break;
		        }
		        $("#seatsNum"+SeatNum).hide();
		        $("#img"+SeatNum).removeAttr("src");
		        $("#img"+SeatNum).attr("src", "/resources/images/reservation/noemptyseat1.png");
		        $("#img"+SeatNum).addClass("noemptySeat");
		      }
		   }
		   leftSeatA(seatNumList.length);
		   tableCheck();
		},
		error: function(error){
		   icia.common.error(error);
		}
	});
	
	$("#btnReserve").on("click", function() {
		var pplCnt = $("#Numseats option:selected").val();
		var now = new Date();
		var clockstring = (now.getMonth()+1) + "월 " + now.getDate() + "일 " ;
		var year = now.getFullYear();
		var month = now.getMonth()+1;
		var day = now.getDate();
		var clockServer = year+(("00"+month.toString()).slice(-2))+(("00"+day.toString()).slice(-2));
		var timeSel = $("#timeSel option:selected").val();
		var arr = "";   //new Array();
		
		$("input[name=seats]:checked").each(function(){
			//arr.push($(this).val());
			if(arr == "")
			{
				arr = $(this).val();
			}
			else
			{
				arr = arr + "," + $(this).val();
			}
		});

		$("#pplCnt").val(pplCnt);
		$("#clockServer").val(clockServer);
		$("#timeSelA").val(timeSel);
		$("#arr").val(arr);
		
		if($("input:checkbox[name=seats]").is(":checked") == false)
		{
			alert("자리를 선택해주세요");
		}
		else if($('input[name="seats"]:checked').length != ($("#Numseats").val()))
		{
			alert("인원수에 맞게 자리를 선택해주세요");
		}
		else
		{
			document.insertForm.action = "/cafe/reservationNext";
			document.insertForm.submit();
		}
	});
	
	//체크박스 선택초기화
	$("#btnResetTb").on("click", function() {
		
		for(var i=0; i<20; i++){
			$("#img"+i).attr("src", "/resources/images/reservation/chairs.png");
			$("#seatsNum"+i).show();
		}
		
		selectTimeSeat();
		
		$(":checkbox").prop('disabled', false);	
		$("input[type=checkbox]").prop("checked",false);
		tableCheck();
	});
	
	
	leftSeat();
	printTime();
	timeSelSelect('${cafe.cafeNum}');
});

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
	<div class="resevtable">
		<font size="4">
		<table class="table">
		  <thead>
		    <tr style="background-color: #4397cf;">
				<th colspan=12 style="text-align: center;color: aliceblue;">자리예약 / 인원 / 시간</th>
		    </tr>
		  </thead>
		  <tbody>
			<tr style="height: 80px; padding-top: 30px;">
				<th style="padding-top: 30px;">선택한 카페 </th>
				<th  style="padding-top: 30px;">${cafe.cafeName}</th>
				<td  style="padding-top: 30px;">카페주소</td>
				<td  style="padding-top: 30px;">${cafe.cafeAddr}</td>
		    </tr>
		    <tr>
				<th scope="row">성함</th>
				<td id="name">${user.userName}</td>
				<td>남은좌석수</td>
				<td style="color: red;"><span id="leftSeats" ></span></td>
		    </tr>
		    <tr>
				<th scope="row">인원수</th>
				<td>
					<select class="selectpicker" id="Numseats" style="width: 160px;"  onchange="changePplSelect()">
						 <option value="1">1명</option>
						 <option value="2">2명</option>
						 <option value="3">3명</option>
						 <option value="4">4명</option>
					</select>
				</td>
				<th scope="row">예약시간</th>
			  	<td>
				  	<select class="selectpicker" id="timeSel" style="width: 160px;" onchange="selectTimeSeat()">
						 <option value="0900">9:00</option>
						 <option value="1000">10:00</option>
						 <option value="1100">11:00</option>
						 <option value="1200">12:00</option>
						 <option value="1300">13:00</option>
						 <option value="1400">14:00</option>
						 <option value="1500">15:00</option>
						 <option value="1600">16:00</option>
						 <option value="1700">17:00</option>
						 <option value="1800">18:00</option>
						 <option value="1900">19:00</option>
						 <option value="2000">20:00</option>
						 <option value="2100" disabled>21:00 --사전예약종료--</option>
						 <option value="2200" disabled>22:00 --사전예약종료--</option>
					</select>
			 	</td>
		    </tr>
		    <tr>
		      	<td colspan="2" style="text-align: center; background-color: #f0ff0129;">예약일자</td>
		      	<th colspan="2" style="text-align: center; background-color: #f0ff0129;">선택하신 좌석번호
		      	</th>
		    </tr>
		    <tr>
				<td colspan="2"  style="text-align: center; background-color: #f0ff0129;"><span id="clock" ></span><div id="selectTime"  style="display:inline-block;"></div></td>
				<td colspan="2" id="result" style="text-align: center; background-color: #f0ff0129;"></td>
		    </tr>
		  </tbody>
		</table>
		</font>
	</div>
	<p><font size="3">※ 당일예약, 테이블단위로 예약가능합니다</font><p>
    <div class="seatStructure">
    	<div class="" style="text-align: right;">
    		<img src="/resources/images/reservation/noemptyseat1.png" width="40" height="40">사용중
    		<img src="/resources/images/reservation/chairs.png" width="40" height="40">빈좌석
    	</div>
		<div id="seatsBlock">
			<div class="row">
			<div class="table1" id="table1">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="0" end="1" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 140px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="2" end="3" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table2" id="table2">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="4" end="5" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 140px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="6" end="7" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table3"  id="table3">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="8" end="9" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 140px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="10" end="11" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table4" id="table4">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="12" end="13" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 140px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="14" end="15" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table5"  id="table5">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="16" end="17" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 140px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="18" end="19" varStatus="Numid">
					<input type="checkbox" name="seats" id="seatsNum${Numid.index}" value="${seat.seatNum}" onclick='getCheckboxValue(${Numid.index})'/>
					<img id="img${Numid.index}"></img>	
				</c:forEach>
				</div>
			</div>
		</div>
   	 </div>
   	 <div style="text-align: right; padding-bottom: 10px;">
	   	 <button class="btn btn-main" id="btnResetTb" style="width: 153px;background: #;background: #ececec;color: dodgerblue;">좌석 초기화</button>
   	 </div>
   	 
   	 <div style="text-align: right; padding-bottom: 100px;">
   	 	<button class="btn btn-main" id="btnReserve">예약 하러가기</button>
   	 </div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
    <form id="insertForm" name="insertForm" method="post">
    	<input type="hidden" id="cafeNum" name="cafeNum" value="${cafe.cafeNum}" />
    	<input type="hidden" id="pplCnt" name="pplCnt" value="" />
    	<input type="hidden" id="clockServer" name="clockServer" value="" />
    	<input type="hidden" id="timeSelA" name="timeSelA" value="" />
    	<input type="hidden" id="arr" name="arr" value="" />				
    </form>
    
    <!-- timepicker jquery-->
    <script type="text/javascript" src="/resources/plugins/jquery/dist/jquery.timepicker.min.js"></script><!-- 타이머js -->
</body>
</html>