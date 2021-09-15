<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}

.product-item td {
	text-align: center;
}

</style>

<script>


var num = 1;
var bsMenuName = "";
var menuNumList = "";

/* 이미지보기 스크립트 */
function imageselect(phtNum, menuNums)
{
	
	const productObj = event.target.parentNode;
	//alert(productObj);
	//console.log(productObj.childNodes);
	var cnt = 0;
	var flag = 0;
	let basket1 = "";
	let basket2 = "";
	let basket3 = "";
	
	let menuName = productObj.childNodes[3].textContent;
	let menuNum = productObj.childNodes[11].value;
	let menuPrice = productObj.childNodes[7].textContent;
	
	let menuNameCut = menuNums.substr(0,3);
	//alert(menuNumCut);
	let menuNameList= menuNameCut.toLowerCase(); // ICE -> ice
	//alert(menuNumdut);
	
	basket1 += "            <div class='img' id='bavimg" + num + "'><img src='/resources/images/shop/reservation/${cafe.userId}/menu/"+menuNameList+"/"+phtNum+".png' width='60'></div>";
	basket1 += "            <div class='pname' id='pnamePn" + num + "'>";
	basket1 += "                <input type='hidden' id='menuName" + num + "' value='" + menuName + "' size='9'><div class='basketName'>"+menuName+"</span></div>";
	basket1 += "				<input type='hidden' id='menuNum" + num + "' value='"+menuNum+"'>";		
	basket1 += "            </div>";
	
	basket2 += "               <div class='basketprice' id='basketprice" + num + "'><input type='hidden' name='p_price" + num + "' id='p_price" + num + "' class='p_price' value='"+ menuPrice +"'>"+menuPrice+"</div>";
	basket2 += "               <div class='num' id='number" + num + "'>";
	basket2 += "                   <div class='updown'>";
	basket2 += "                     <span id='changeNum" + num + "' onclick='changePNum(" + num + ");'><i class='fas fa-arrow-alt-circle-down down'></i></span>";
	basket2 += "                      <input type='text' name='p_num" + num + "' id='p_num" + num + "' size='2' maxlength='4' class='p_num' value='1'>";
	basket2 += "                      <span onclick='changePNum(" + num + ");'><i class='fas fa-arrow-alt-circle-up up'></i></span>";
	basket2 += "                  </div>";
	basket2 += "              </div>";
	basket2 += "              <div class='sum' id='summerize"+ num +"'><input type='text' name='p_sum" + num + "' id='p_sum" + num + "' value='"+menuPrice+"' readonly/></div>";
	
	basket3 += "			<div class='basketcmd' id='basketcmd" + num + "'><button type='button' class='btn btn-main btn-small' id='p_abutton" + num + "' onclick='delItem(" + num + ");'>삭제</button></div>"
	
	
	$("input:checkbox[id='chk_use']").prop("checked", false);	//적립금 체크박스해제
	$("#use_Point").val(0); 
	
	for(cnt=1; cnt<=num; cnt++){ 
		if(menuName == $("#menuName"+cnt).val()){
			$("#p_num"+cnt).val(parseInt($("#p_num"+cnt).val()) + 1);
			$("#totalCount").val(parseInt($("#totalCount").val()) +1);
			$("#totalCount_s").text($("#totalCount").val());
			$("#p_sum"+cnt).val(parseInt($("#p_num"+cnt).val()) * $("#p_price"+cnt).val());
			
				bsMenuName += menuName + " ";
				menuNumList += menuNum + " ";
				
			$("#origin_Price").val(parseInt($("#origin_Price").val()) + parseInt(menuPrice));
			$("#result_Price_s").text($("#origin_Price").val());
			$("#origin_Price_s").text($("#origin_Price").val());
			flag = 1;
			break;
		}
	}
	
	if(flag == 0){
		$(".subdiv_basket").append(basket1);
		$(".subdiv_basket2").append(basket2);
		$(".subdiv_basket3").append(basket3);
		
		bsMenuName += menuName + " ";
		menuNumList += menuNum + " ";
			
		$("#totalCount").val(parseInt($("#totalCount").val()) +1);
		$("#totalCount_s").text($("#totalCount").val());
		$("#totalListNum").val(parseInt($("#totalListNum").val()) +1);
		$("#origin_Price").val(parseInt($("#origin_Price").val()) + parseInt(menuPrice));
		$("#result_Price_s").text($("#origin_Price").val());
		$("#origin_Price_s").text($("#origin_Price").val());
		num++;
	}
	else{
		flag = 0;
	}
	//alert($("#result_Price").val());
	//alert($("#result_Price_s").text($("#origin_Price").val()));
	

}


function changePNum(pos){
	//수량변경 스크립트
	
	//적립금 체크박스해제, 사용가능 마일리지 초기화
	$("input:checkbox[id='chk_use']").prop("checked", false);	
	$("#use_Point").val(0); 
	var v_left = document.getElementsByName("left_pnt"); 
	for (var i = 0; i < v_left.length; i++) {
	   v_left[i].innerHTML = ${user.totalPoint};
	}
	
	//수량에대한정보
    var p_num = parseInt($("#p_num"+pos).val());
	
	//alert("p_num pos번호 : "+pos + "     p_num의 값 : " +p_num);
 
    //음료 1잔 가격
    var p_orgpce = parseInt($("#p_price"+pos).val());

    //음료 n잔 가격
    var p_pce = parseInt($("#p_sum"+pos).val());

    //수량 업다운
    var newval = event.target.classList.contains('up') ? parseInt($("#p_num"+pos).val())+1 : event.target.classList.contains('down') ? parseInt($("#p_num"+pos).val())-1 : event.target.value;
    if (parseInt(newval) < 1 || parseInt(newval) > 99 || newval === undefined ) { return false; }
	
    //alert("증가된 수량 : "+newval);
    
    //업다운된 수량으로 음료의 n잔 가격을 구한다
    var newprice = p_orgpce * newval;
    
    //페이지에 수량정보 업데이트
    $("#p_num"+pos).val(newval);
    $("#p_sum"+pos).val(newprice);
    
    //페이지에 n잔가격 업데이트
   	totalCount();
	totalSum();
	$("#result_Price_s").text($("#origin_Price").val());
	$("#origin_Price_s").text($("#origin_Price").val());
}


function totalCount(){
	var sum = 0;
	for(i = 1; i <=$("#totalListNum").val(); i++){
		//alert("for i : " + i + ", totalListNum : " + $("#totalListNum").val());
		if($("#p_num"+i).val() === undefined || $("#p_num"+i).val() == null || $("#p_num"+i).val() === 0)
		{
			continue;
		}
		
		// alert("if문 후의 i값: " +i);
		var pnum = parseInt($("#p_num"+i).val());
		sum = sum + pnum;	
	    $("#totalCount").val(sum);
	    $("#totalCount_s").text($("#totalCount").val());
	}
}

function totalSum(){
	var sum = 0;
	for(i = 1; i <=$("#totalListNum").val(); i++){
		if($("#p_sum"+i).val() === undefined || $("#p_num"+i).val() === 0)
		{
			continue;
		}
		
		var psum = parseInt($("#p_sum"+i).val());
	    sum = sum + psum;	
	}
    $("#origin_Price").val(sum);
    $("#origin_Price_s").text($("#origin_Price").val());
}

function delItem(pos){ // 장바구니 목록 중 1개 목록만 지우기

	$("input:checkbox[id='chk_use']").prop("checked", false);	//적립금 체크박스해제
	$("#use_Point").val(0);
	var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지 초기화
	for (var i = 0; i < v_left.length; i++) {
	   v_left[i].innerHTML = ${user.totalPoint};
	}
	
	var p_num = $("#p_num"+pos).val();	//(1) 삭제 수량확인후
	$("#totalCount").val(parseInt($("#totalCount").val()) - p_num);
	$("#totalCount_s").text($("#totalCount").val());
	
	$("#checksel" + pos).remove();	//(2) 상품을지운다
	$("#bavimg" + pos).remove();
	$("#pnamePn" + pos).remove();
	$("#basketprice" + pos).remove();
	$("#number" + pos).remove();
	$("#summerize" + pos).remove();
	$("#basketcmd" + pos).remove(); 
	$("#p_abutton" + pos).remove();
	
	totalSum();
	
	$("#result_Price_s").text($("#origin_Price").val());
	$("#origin_Price_s").text($("#origin_Price").val());
} 

function delAllItem(){ // 전부 다 지우기(장바구니 비우기)

	$("input:checkbox[id='chk_use']").prop("checked", false);	//적립금 체크박스해제
	$("#use_Point").val(0); 
	$("#result_Price_s").val($("#origin_Price_s").val());
	$("#result_Price").text($("#origin_Price").val());
	var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지 초기화
	for (var i = 0; i < v_left.length; i++) {
	   v_left[i].innerHTML = ${user.totalPoint};
	}
	
	
	for(i = 1; i <=$("#totalListNum").val(); i++){
		$("#checksel" + i).remove();	
		$("#bavimg" + i).remove();
		$("#pnamePn" + i).remove();
		$("#basketprice" + i).remove();
		$("#number" + i).remove();
		$("#summerize" + i).remove();
		$("#basketcmd" + i).remove(); 
		$("#p_abutton" + i).remove();
	}
	$("#totalCount").val(0);
	$("#totalCount_s").text($("#totalCount").val());
	$("#origin_Price").val(0);
	$("#origin_Price_s").text($("#origin_Price").val());
	$("#result_Price_s").text($("#origin_Price").val());
	
} 
// 숫자 3자리 콤마찍기
/*
Number.prototype.formatNumber = function(){
    if(this==0) return 0;
    let regex = /(^[+-]?\d+)(\d{3})/;
    let nstr = (this + '');
    while (regex.test(nstr)) nstr = nstr.replace(regex, '$1' + ',' + '$2');
    return nstr;
};
*/

//order
function javascript(){
    
    document.getElementById("pay").style.border = "3px solid #4397cf"; 
    
}

function chkPoint(amt,pnt,min,unit) {
    //input값을 전체 마일리지로 설정 > minusPoint 
    //amt : 최초 결제 금액 / pnt : 사용가능,남은 포인트 / min : 사용 가능 최소 포인트 / unit : 사용단위
    var v_point = 0; //사용할 포인트 (input 입력값)
 
    if (document.getElementById("chk_use").checked)  
    {
       if (pnt < min)  //최소 사용 단위보다 작을 때
       {
          v_point = 0; 
       }else {
          v_point = pnt - pnt%unit; //사용할 포인트 = 전체 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
       }

       if(pnt > amt ){ //결제금액보다 포인트가 더 클 때
          v_point = amt; //사용할 포인트는 결제금액과 동일하게 설정
       }
       
    }
	document.getElementById("use_Point").value = v_point;
    changePoint(amt,pnt,min,unit);
 }
 
 // 포인트 적용하기
 function changePoint(amt,pnt,min,unit){
    //input값을 불러옴 > left_pnt 변경 > 최종결제 변경
    //amt : 최초 결제 금액 / pnt : 사용가능,남은 포인트 / min : 사용 가능 최소 포인트 / unit : 사용단위
    var v_point = parseInt(document.getElementById("use_Point").value); //사용할 포인트 (input 입력값)
    if (v_point > pnt) //입력값이 사용가능 포인트보다 클때
    {
       v_point = pnt;
       document.getElementById("use_Point").value = v_point; //input 값 재설정
    }

    if(v_point > amt ){ //결제금액보다 포인트가 더 클 때
       v_point = amt; //사용할 포인트는 결제금액과 동일하게 설정
       document.getElementById("use_Point").value = v_point; //input 값 재설정
    }

    if (v_point < min)  //최소 사용 단위보다 작을 때
    {
       v_point = 0; 
       document.getElementById("use_Point").value = v_point; //input 값 재설정
    }else {
       v_point = v_point - v_point%unit; //사용할 포인트 = 사용할 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
       document.getElementById("use_Point").value = v_point; //input 값 재설정
    }

    var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지, 남은 포인트 값 설정
    for (var i = 0; i < v_left.length; i++) {

       v_left[i].innerHTML = pnt - v_point; //= 전체 포인트 중에 사용할 포인트빼고 남은 포인트

    }
    document.getElementById("result_Price_s").innerHTML = amt - v_point; //최종 결제금액 = 결제금액 - 사용할 포인트
 }
function payment(){
	var menuCountList = "";
	var menuNumList = "";
	var orderMenuList = "";
	for(i = 1; i <=$("#totalListNum").val(); i++){
		var count = $("#p_num"+i).val();
		var menuNum = $("#menuNum"+i).val();
		var orderMenu = $("#menuName"+i).val();

	    if(count !== undefined)
		{
			menuCountList = menuCountList + count + " ";
		}
	    
	    if(menuNum !== undefined)
	    {
	    	menuNumList = menuNumList + menuNum + " ";
	    }
	    
	    if(orderMenu !== undefined)
	    {
	    	orderMenuList = orderMenuList + orderMenu + " ";
	    }
	}
	
	
	$("#rsrv_PplCnt").val(parseInt($("#rsrv_PplCnt").val()));
	$("#totalCount").val(parseInt($("#totalCount").val()));
	
	$("#result_Price").val(parseInt($("#result_Price_s").text()));
	
	if($("#rsrv_PplCnt").val() > $("#totalCount").val()){
		alert("예약인원보다 주문된 음료 수가 적습니다. 음료를 추가해주세요.");
		return;
	}
	
	if(confirm("결제하시겠습니까?")){
		alert("결제를 진행합니다.");
		//ajax
		icia.ajax.post({
	        type: "POST",
	        url: "/kakao/payReady",
	        data: {
	           rsrvCafe: $("#rsrv_Cafe").val(), 		//예약카페이름 -- 카카오페이 itemName
	           rsrvSeat: $("#rsrv_Seat").val(),			//예약자리
	           rsrvTime: $("#rsrv_Time").val(),			//예약시간
	           rsrvDate: $("#rsrv_Date").val(),			//결제날짜
	           originPrice: $("#origin_Price").val(),	//결제금액
	           payPoint: $("#use_Point").val(),			//사용한포인트
	           resultPrice: $("#result_Price").val(),	//최종결제금액 - 포인트할인 적용 -- 카카오페이 totalAmount 
	           rsrvPplCnt: $("#rsrv_PplCnt").val(),		//예약인원
	           cafeNum: $("#cafeNum").val(),			//예약한 카페의 번호 -- 카카오페이 itemCode
	           menuNum: menuNumList,					//예약한 메뉴의 번호값
	           orderMenu: orderMenuList,
	           menuCount: menuCountList,
	           rsrvSeq: $("#ArsrvSeq").val(),
	           
	           quantity:$("#totalCount").val() 		//수량(메뉴 선택 갯수) -- 카카오페이 quantity
	        },
	        success:function(response){
	        	icia.common.log(response);
	        	
	           if(response.code == 0)
	           {
 	              var orderId = response.data.orderId;
        		  var tId = response.data.tId;
        		  var pcUrl = response.data.pcUrl; 
        		  //var rsrvSeq = response.data.rsrvSeq;
        		  
        		  $("#orderId").val(orderId);
        		  $("#tId").val(tId);
        		  $("#pcUrl").val(pcUrl);
        		  
        		  var frm = document.getElementById('kakaoForm');	
        		  
        		  var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
                
        		  frm.submit();
	           }
	           else if(response.code == 404)
	           {
	        	   alert("주문정보 적용 중 오류가 발생했습니다.");
	           }
	           else if(response.code == 403)
	           {
	        	   alert("결제정보 적용 중 오류가 발생했습니다.");
	           }
	           else if(response.code == 402)
	           {
	        	   alert("예약정보 적용 중 오류가 발생했습니다.");
	           }
	           else if(response.code == 530){
	        	   alert("사용포인트 적용 중 오류가 발생했습니다.");
	           }
	           else if(response.code == 540){
	        	   alert("결제할 금액이 없습니다. 포인트 전액결제를 이용해 주세요.");
	           }
	           else{
	        	   alert("오류가 발생했습니다. 다시 시도해 주세요.");
	           }
	           
	        },
	        error: function(error)
	        {
	           icia.common.error(error);
	        }
	     
	     });
	}
	else{
		alert("취소되었습니다.");
		return;
	}

}

function onlyPointPay(){
	var menuCountList = "";
	var menuNumList = "";
	var orderMenuList = "";
	for(i = 1; i <=$("#totalListNum").val(); i++){
		var count = $("#p_num"+i).val();
		var menuNum = $("#menuNum"+i).val();
		var orderMenu = $("#menuName"+i).val();
		
		if(count !== undefined)
		{
			menuCountList = menuCountList + count + " ";
		}
	    
	    if(menuNum !== undefined)
	    {
	    	menuNumList = menuNumList + menuNum + " ";
	    }
	    
	    if(orderMenu !== undefined)
	    {
	    	orderMenuList = orderMenuList + orderMenu + " ";
	    }
	}
	
	$("#rsrv_PplCnt").val(parseInt($("#rsrv_PplCnt").val()));
	$("#totalCount").val(parseInt($("#totalCount").val()));
	
	$("#result_Price").val(parseInt($("#result_Price_s").text()));
	
	if($("#rsrv_PplCnt").val() > $("#totalCount").val()){
		alert("예약인원보다 주문된 음료 수가 적습니다. 음료를 추가해주세요.");
		return;
	}
	
	if($("#origin_Price").val() != $("#use_Point").val() || $("#result_Price").val() != 0){
		alert("포인트가 부족하여 결제를 취소합니다.");
		return;
	}
	
	if(confirm("(포인트)확인누르면 동작 취소누르면 취소")){
		alert("결제를 진행합니다.");
		//ajax
		icia.ajax.post({
	        type: "POST",
	        url: "/kakao/pointPayAll",
	        data: {
	           rsrvCafe: $("#rsrv_Cafe").val(), 		//예약카페이름 -- 카카오페이 itemName
	           rsrvSeat: $("#rsrv_Seat").val(),			//예약자리
	           rsrvTime: $("#rsrv_Time").val(),			//예약시간
	           rsrvDate: $("#rsrv_Date").val(),			//결제날짜
	           originPrice: $("#origin_Price").val(),	//결제금액
	           payPoint: $("#use_Point").val(),			//사용한포인트
	           resultPrice: $("#result_Price").val(),	//최종결제금액 - 포인트할인 적용 -- 카카오페이 totalAmount 
	           rsrvPplCnt: $("#rsrv_PplCnt").val(),		//예약인원
	           cafeNum: $("#cafeNum").val(),			//예약한 카페의 번호 -- 카카오페이 itemCode
	           menuNum: menuNumList,					//예약한 메뉴의 번호값
	           orderMenu: orderMenuList,
	           menuCount: menuCountList,
	           rsrvSeq: $("#ArsrvSeq").val(),
	        },
	        success:function(response){
	        	icia.common.log(response);
	        	
	           if(response.code == 0)
	           {
	              alert("결제시작");
        		  alert("Next ArsrvSeq = " + $("#ArsrvSeq").val());
	              alert("전액 포인트 결제가 완료되었습니다.");
	              location.href = "/mypage/userPayment";
	           }
	           else{
	        	   alert("포인트 사용 에러");
	           }
	           
	        },
	        error: function(error)
	        {
	           icia.common.error(error);
	        }
	     
	     });
	}
	else{
		alert("취소되었습니다.");
		return;
	}
}

$(document).ready(function(){
	
	/* 카테고리설정 스크립트 */
	$('ul.tabs li').on("click", function(){
		var category = $(this).attr('value');
		var tab_id = $(this).attr('data-tab');

		
		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');
		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
});

function movePage()
{	
	document.insertForm.action = "/kakao/insertTest";
	document.insertForm.submit();
}

</script>
</head>
<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- 카페명 자리 -->
<section class="products section">
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<div id="cafeImage">
					<c:choose>
					    <c:when test="${cafe.cafeNum eq 'A0000001'}">
					    	<img src='/resources/images/shop/single-products/hanzan/product-1.png' />
					    </c:when>
					    <c:when test="${cafe.cafeNum eq 'A0000002'}">
					        <img src='/resources/images/shop/single-products/donut/product-1.png' />
					    </c:when>
					    <c:when test="${cafe.cafeNum eq 'A0000003'}">
					        <img src='/resources/images/shop/single-products/noname/product-1.png' />
					    </c:when>
					    <c:otherwise>
					        <img src='/resources/images/shop/single-products/damda/product-1.png' />
					    </c:otherwise>
					</c:choose>
				</div>
				<h1 style="text-align: center;">${cafe.cafeName}</h1><br><br>
				<div class="section-text">
					<h4>음료는 예약인원수만큼</h4>
					<h4>주문해주세요</h4>
				</div>			
				<br><br>
				<!-- 카테고리 커피 -->
				<div class="widget product-category">
					<div class="widget-title">카테고리</div>
					<div class="panel-group commonAccordion" id="accordion" role="tablist" aria-multiselectable="true">
					  	<div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingOne">
						      	<h4 class="panel-title">
						        	<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          	음료
						        	</a>
						      	</h4>
						    </div>
					    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body">
								<ul class="tabs">
									<li class="tab-link current" data-tab="tab-1">ice</li>
									<li class="tab-link" data-tab="tab-2">hot</li>
								</ul>
							</div>
					    </div>
					 </div>
	
					<!-- 카테고리 디저트 -->
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">
					        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					         	디저트
					        </a>
					      </h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					    	<div class="panel-body">
					     		<ul class="tabs">
									<li class="tab-link" data-tab="tab-3">디저트</a></li>
								<ul class="tabs">
					    	</div>
					    </div>
					  </div>
					</div>					
				</div>
			</div> 
			<!-- end 카테고리 커피 -->
			
			<!-- 메뉴사진 들어갈 곳 -->
			<div class="col-md-9">
				<div class="row">
					<div id="tab-1" class="tab-content current" style="overflow:auto; width:870px; height:600px;">
					<div class="col-md-4">
						<div class="product-item">
							<table style="width: 800px;">
								<c:set var="i" value="0"/>
								<c:set var="j" value="4"/>
								<c:forEach var="menuPht" items="${menuPht}">
									<c:if test= "${fn:contains(menuPht.menuNum, 'ICE')}">
										<c:if test="{i%j == 0}">
										<tr>
										</c:if>
											<td>
												<%-- <input type="hidden" id="menunum" value="${menupht.menunum}" /> --%>
												
												<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/menu/ice/${menuPht.phtNum}.png"  />
												<span id="menuName">${menuPht.menuName}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuPrice}</span>
												<p></p>
												<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
											    <input type="button" onclick="imageselect(${menuPht.phtNum}, '${menuPht.menuNum}')" value="장바구니담기" />
											</td>
										<c:if test="${i%j == j-1}">
										</tr>
										</c:if>
										<c:set var="i" value="${i+1}"/>
									</c:if>
								</c:forEach>
							</table>	
						</div>
					</div>
					</div>
					<div id="tab-2" class="tab-content" style="overflow:auto; width:870px; height:600px;">
					<div class="col-md-4">
						<div class="product-item">
							<table style="width: 800px;">
								<c:set var="i" value="0"/>
								<c:set var="j" value="4"/>
								<c:forEach var="menuPht" items="${menuPht}">
									<c:if test= "${fn:contains(menuPht.menuNum, 'HOT')}">
										<c:if test="{i%j == 0}">
										<tr>
										</c:if>
											<td>
												<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/menu/hot/${menuPht.phtNum}.png"  />
												<span id="menuName">${menuPht.menuName}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuPrice}</span>
												<p></p>
												<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
											    <input type="button" onclick="imageselect(${menuPht.phtNum}, '${menuPht.menuNum}')" value="장바구니담기">
											</td>
										<c:if test="${i%j == j-1}">
										</tr>
										</c:if>
										<c:set var="i" value="${i+1}"/>
									</c:if>
								</c:forEach>
							</table>	
						</div>
					</div>
					</div>
					<div id="tab-3" class="tab-content" style="overflow:auto; width:870px; height:600px;">
					<div class="col-md-4">
						<div class="product-item">
							<table style="width: 800px;">
								<c:set var="i" value="0"/>
								<c:set var="j" value="4"/>
								<c:forEach var="menuPht" items="${menuPht}">
									<c:if test= "${fn:contains(menuPht.menuNum, 'ETC')}">
										<c:if test="{i%j == 0}">
										<tr>
										</c:if>
											<td>
												<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/menu/etc/${menuPht.phtNum}.png"  />
												<span id="menuName">${menuPht.menuName}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuPrice}</span>
												<p></p>
												<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
											    <input type="button" onclick="imageselect(${menuPht.phtNum}, '${menuPht.menuNum}')" value="장바구니담기">
											</td>
										<c:if test="${i%j == j-1}">
										</tr>
										</c:if>
										<c:set var="i" value="${i+1}"/>
									</c:if>
								</c:forEach>
							</table>	
						</div>
					</div>
					</div>
				</div> 
			</div>
		</div><!--row-->
	</div><!--container-->
</section>



<!-- 하단 장바구니 -->
<form name="orderform" id="orderform" method="post" class="orderform" action="/Page" onsubmit="return false;" style="margin:0 auto; padding:0; max-width:1170px;">    
	<input type="hidden" name="cmd" value="order">
	<div class="basketdiv" id="basket" style="margin:0 auto; padding:0;">
	    <div class="row head" style="margin:0 auto; padding:0;">
	        <div class="subdiv">
	            <div class="img" style="font-size:18px">이미지</div>
	            <div class="pname" style="font-size:18px">상품명</div>
	        </div>
	        <div class="subdiv">
	            <div class="basketprice" style="font-size:18px">가격</div>
	            <div class="num" style="font-size:18px">수량</div>
	            <div class="sum" style="font-size:18px">합계</div>
	        </div>
	        <div class="subdiv">
	            <div class="basketcmd" style="font-size:18px">삭제</div>
	        </div>
	        <div class="split"></div>
	    </div>
	    <div class="row data" style="margin:0 auto; padding:0;">
	        <div class="subdiv_basket">
	        </div>
	        <div class="subdiv_basket2">
	        </div>
	        <div class="subdiv_basket3">
	        </div>
	    </div>
		<div class="row" style="margin: 25px 0px 67px -19px; text-align: right;">
			<h4 style="display: inline; padding-right: 20px;">총 주문개수 : <span class="bold" id="totalCount_s">0</span> 개</h4>
		    <button type="button" class="btn btn-dark" onclick="delAllItem();">장바구니 비우기</button>
		</div>
		<div class="bigtext right-align sumcount" id="sum_p_num">
			<input type="hidden" name="totalCount" id="totalCount" value="0"/>
			<input type="hidden" name="totalListNum" id="totalListNum" value="0"/>
		</div>
	 	<br/><br/>
	 </div>
</form>         

<br/><br/><br/><br/><br/><br/><br/>
 <!-- 주문자 정보 -->	
<div class="checkout shopping">
	<div class="container">
	   <div class="row" style="padding-top: 82px;">
	    <div class="col-md-8">
	       <div class="shopping-img">
	          <img src="/resources/images/logo21.png" alt="image" width="427" height="80" style="margin: 0 0 0 231px;"/>
	       </div>
	    </div>
	     <div class="col-md-4">
	       <div class="shopping-img">
	          <img src="/resources/images/logo23.png" width="300" height="80" style="margin: 0px 33px;"/>
	       </div>
	    </div>
	    <div class="col-md-8">
	       <div class="block billing-details">
	          <div class="widget-title">주문자 정보</div>
	          <form class="checkout-form">
	             <div class="form-group">
	                <label for="full_name">예약자명</label>
	                <input type="text" class="form-control" id="rsrv_Name" placeholder="" value="${rsRv.userName}" readonly>
	             </div>
	             <div class="form-group">
	                <label for="user_address">예약 카페</label>
	
	                <input type="hidden" id="cafeNum" name="cafeNum" value="${cafe.cafeNum}">
	                <input type="text" class="form-control" id="rsrv_Cafe" placeholder="" value="${cafe.cafeName}" readonly>
	             </div>
	             <div class="checkout-country-code clearfix">
	                <div class="form-group">
	                   <label for="user_post_code">예약자리</label>
	                   <input type="text" class="form-control" id="rsrv_Seat" name="zipcode" value="${rsRv.seatList}" readonly>
	                </div>
	                <div class="form-group" >
	                   <label for="user_city">예약 시간</label>
	                   <input type="text" class="form-control" id="rsrv_Time" name="city" value="${rsRv.rsrvTime}" readonly>
	                </div>
	             </div>
	             <div class="form-group">
	             	<label>예약 인원</label>
	             	<input type="text" class="form-control" id="rsrv_PplCnt" name="rsrv_PplCnt" value="${rsRv.rsrvPplCnt}명" readonly>
	             </div>
	             <div class="form-group">
	                <label for="user_country">예약 날짜</label>
	                <input type="text" class="form-control" id="rsrv_Date" placeholder="" value="${rsRv.rsrvDate}" readonly />
	             </div>
	          </form>
	       </div>
			<div class="block">
			<div class="widget-title">결제 방법</div>
			<div class="checkout-product-details">
				<div class="payment">
					<div class="card-details">
						<form  class="checkout-form">                                                      
							<img src="/resources/images/kakao.png" alt="image" width="150" height="150" onclick='payment();'name="pay" id="pay"/>
							<img src="/resources/images/pointPayAll.png" alt="image" width="150" height="150" onclick='onlyPointPay();'/>
						</form>
					</div>
				</div>
			</div>
			</div>
	    </div>
		<div class="col-md-4">
			<div class="block product-checkout-details">
				<div class="">
					<h4 class="widget-title">결제</h4>
				</div>
					<div>결제금액</div>
					<div><h3><span class="bold" id="origin_Price_s"></span>원</h3> </div>
					<input type="hidden" name="origin_Price" id="origin_Price" value="0"/>
					
				<div class="details-point">
					<div style="padding-bottom: 10px;">포 인 트</div>
					<input type="text" name="use_Point" id="use_Point" value="0" min="100" max="${user.totalPoint}" onchange="changePoint($('#origin_Price').val(),${user.totalPoint},100,100)"> p <br> 
					<input type="checkbox" id="chk_use" onclick="chkPoint($('#origin_Price').val(),${user.totalPoint},100,100)">포인트 전체 사용
				</div>
				<div>
					포인트는 100p 단위로 사용 가능합니다.
					<br/>
					사용가능 포인트 :<span class="bold" name="left_pnt">${user.totalPoint} </span><div style="display: inline;">p </div>
				</div>
				
			</div>
			<div>
				<div class="block" style="padding-top: 1px;">
					<h4 class="widget-title">최종 결제 금액</h4>
				</div>
				<div>
					<input type="hidden" id="result_Price" value="0" />
					<h2 style="text-align: center;"><span class="bold" id="result_Price_s">0</span> 원</h2>
				</div>
			</div>
	    </div>
	</div>
</div>
</div>
<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
	<input type="hidden" name="orderId" id="orderId" value="" />
	<input type="hidden" name="tId" id="tId" value="" />
	<input type="hidden" name="pcUrl" id="pcUrl" value="" />
</form>

<form name="insertForm" id="insertForm" method="post">
	<input type="hidden" name="ArsrvSeq" id="ArsrvSeq" value="${rsRv.rsrvSeq}" /> 
</form>
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>