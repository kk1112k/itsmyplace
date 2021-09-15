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
  
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="/resources/images/favicon.png" />
  
  <!-- Themefisher Icon font -->
  <link rel="stylesheet" href="/resources/plugins/themefisher-font/style.css">
  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="/resources/plugins/bootstrap/css/bootstrap.min.css">
  
  <!-- Animate css -->
  <link rel="stylesheet" href="/resources/plugins/animate/animate.css">
  <!-- Slick Carousel -->
  <link rel="stylesheet" href="/resources/plugins/slick/slick.css">
  <link rel="stylesheet" href="/resources/plugins/slick/slick-theme.css">
  
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="/resources/css/style.css">
  
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
	 width : 60px;
	 height: 45px;
	 background: bottom;
}

.table2 , .table1 , .table3, .table4, .table5{
    display: inline-block;
}

.table2 , .table3 ,.table4, .table5{
	padding-left: 140px;
}

.table4, .table5{
    padding-top: 80px;
}

.seat input[type=checkbox]+ img {
 	background-image: url("/resources/images/reservation/chairs.png"); 
  	background-size: cover;
  	width: 50px;
}

.seat input[type=checkbox]:checked + img {
 	background-image: url("/resources/images/reservation/checkseat.png"); 
 	background-size: cover;
}

</style>

<script type="text/javascript">
function getCheckboxValue(event)  {
	
		
	if ($('input[name="seats"]:checked').length == ($("#Numseats").val())) 
	{
		    $(":checkbox").prop('disabled', true);
		    $(':checked').prop('disabled', false);
	}
	else
    {
      $(":checkbox").prop('disabled', false);
    }
	
	const query = 'input[name="seats"]:checked';
	const selectedEls = document.querySelectorAll(query);
	// 선택된 목록에서 value 찾기
	var arrr = new Array();
	selectedEls.forEach((el) => {
		arrr.push(el.value);
	});
	// 출력
	document.getElementById('result').innerText = arrr + "입니다."; 
}

	
$(document).ready(function() {
	// INPUT 박스에 들어간 ID값을 적어준다.
    $("#START_TIME").timepicker({
        'minTime': '09:00am', // 조회하고자 할 시작 시간 ( 09시 부터 선택 가능하다. )
        'maxTime': '20:00pm', // 조회하고자 할 종료 시간 ( 20시 까지 선택 가능하다. )
        'timeFormat': 'H:i',
        'step': 30 // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
    });
	
    $('#START_TIME').on('changeTime', function() {
    	$('#selectTime').text($(this).val());
    });
    
	$("#btnReserve").on("click", function() {
		var arr = new Array();
		$("input[name=seats]:checked").each(function(){
			arr.push($(this).val());
		});
		alert("최종 선택하신 좌석은 " + arr + " 입니다.");
		for (var i = 0; i < arr.length; i++) { // arr
	        $("#" + arr[i]).prop("disabled", true); 
		}
	}); 
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
		    <tr style="background-color: silver;">
				<th  colspan="3" style="text-align: center;">인원/좌석</th>
				<th scope="col">다시하기 <i class="fa fa-refresh" aria-hidden="true"></i></th>
		    </tr>
		  </thead>
		  <tbody>
			<tr style="height: 80px; padding-top: 30px;">
				<th style="padding-top: 30px;">선택한 카페 </th>
				<th  style="padding-top: 30px;">${cafe.cafename}</th>
				<td  style="padding-top: 30px;">카페주소</td>
				<td  style="padding-top: 30px;">${cafe.cafeaddr}</td>
		    </tr>
		    <tr>
				<th scope="row">성함</th>
				<td id="name">${user.userName}</td>
				<td>남은좌석수</td>
				<td style="color: red;">16/20</td>
		    </tr>
		    <tr>
				<th scope="row">인원수</th>
				<td>
					<select class="selectpicker" id="Numseats" style="width: 160px;">
						 <option value="1">1명</option>
						 <option value="2">2명</option>
						 <option value="3">3명</option>
						 <option value="4">4명</option>
					</select>
				</td>
				<th scope="row">예약시간</th>
			  	<td>
					<input type="text" name="START_TIME" id="START_TIME" value="" maxlength="10"  class="setDatePicker" placeholder="시간을 선택해주세요.">
			 	</td>
		    </tr>
		    <tr>
		      	<td colspan="2" style="text-align: center; background-color: #f0ff0129;">예약일자와 시간</td>
		      	<th colspan="2" style="text-align: center; background-color: #f0ff0129;">선택하신 좌석번호
		      	</th>
		    </tr>
		    <tr>
				<td colspan="2"  style="text-align: center; background-color: #f0ff0129;">8.14(토) <div id="selectTime"  style="display:inline-block;"></div></td>
				<td colspan="2" id="result" style="text-align: center; background-color: #f0ff0129;"></td>
		    </tr>
		  </tbody>
		</table>
		</font>
	</div>
	
    <div class="seatStructure">
    	<div class="" style="text-align: right;">
    		<img src="/resources/images/reservation/noemptyseat1.png" width="40" height="40">사용중
    		<img src="/resources/images/reservation/chairs.png" width="40" height="40">빈좌석
    	</div>
		<div id="seatsBlock">
			<div class="row">
			<div class="table1">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="0" end="1">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 120px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="2" end="3">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table2">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="4" end="5">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 120px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="6" end="7">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table3">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="8" end="9">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>		
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 120px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="10" end="11">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
			</div>
			
			<div class="table4">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="12" end="13">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 120px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="14" end="15">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>		
				</c:forEach>
				</div>
			</div>
			
			<div class="table5">
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="16" end="17">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>		
				</c:forEach>
				</div>
				<div class="table">
					<img src="/resources/images/reservation/desk.png" style=" width: 120px ;"/>
				</div>
				<div class="seat">
				<c:forEach var="seat" items="${seat}" begin="18" end="19">
					<c:choose>
						<c:when test="${seat.vacancy eq 'N'}">
							<img src="/resources/images/reservation/noemptyseat1.png" alt="" style="width: 60px;" />
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="seats" value="${seat.seatnum}" onclick='getCheckboxValue()'/>
							<img></img>	
						</c:otherwise>
					</c:choose>	
				</c:forEach>
				</div>
			</div>
		</div>
   	 </div>
   	 <div style="text-align: right;padding-bottom: 100px;">
   	 <a href="/cafe/reservationNext?cafenum=${cafe.cafenum}" class="btn btn-main mt-20" id="btnReserve">예약 하러가기</a>
   	 </div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="/resources/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="/resources/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="/resources/plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="/resources/plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="/resources/plugins/syo-timer/build/jquery.syotimer.min.js"></script>
	
    <!-- slick Carousel -->
    <script src="/resources/plugins/slick/slick.min.js"></script>
    <script src="/resources/plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="/resources/plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="/resources/js/script.js"></script>
    
    <!-- timepicker jquery-->
    <script type="text/javascript" src="/resources/plugins/jquery/dist/jquery.timepicker.min.js"></script><!-- 타이머js -->
</body>
</html>