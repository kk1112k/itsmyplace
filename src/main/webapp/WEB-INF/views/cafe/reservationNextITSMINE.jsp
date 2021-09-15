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
var bsMenuName = [];
var menuNumList = "";

/* 이미지보기 스크립트 */
function imageselect(event)
{
	
	const productObj = event.target.parentNode;
	//console.log(productObj.childNodes);
	
	let basket1 = "";
	let basket2 = "";
	let basket3 = "";
	
	let menuName = productObj.childNodes[3].textContent;
	let menuNum = productObj.childNodes[11].value;
	let menuPrice = productObj.childNodes[7].textContent;

	//alert(productObj);
	
	
			
basket1 += "			   <div class='check'><input type='checkbox' name='buy' value='260' checked='' onclick='javascript:basket.checkItem();'>&nbsp;</div>";
basket1 += "            <div class='img'><img src='/resources/images/shop/reservation/basket1.jpg' width='60'></div>";
basket1 += "            <div class='pname'>";
basket1 += "                <input type='text' id='menuName" + num + "' value='"+menuName+"' size='9'>";
basket1 += "				<input type='hidden' id='menuNum" + num + "' value='"+menuNum+"'>";		
basket1 += "            </div>";

basket2 += "               <div class='basketprice'><input type='hidden' name='p_price" + num + "' id='p_price" + num + "' class='p_price' value='"+ menuPrice +"'>"+menuPrice+"</div>";
basket2 += "               <div class='num'>";
basket2 += "                   <div class='updown'>";
basket2 += "                     <span onclick='changePNum(" + num + ");'><i class='fas fa-arrow-alt-circle-down down'></i></span>";
basket2 += "                      <input type='text' name='p_num" + num + "' id='p_num" + num + "' size='2' maxlength='4' class='p_num' value='1' onkeyup='javascript:basket.changePNum(" + num + ");'>";
basket2 += "                      <span onclick='changePNum(" + num + ");'><i class='fas fa-arrow-alt-circle-up up'></i></span>";
basket2 += "                  </div>";
basket2 += "              </div>";
basket2 += "              <div class='sum'><input type='text' name='p_sum" + num + "' id='p_sum" + num++ + "' value='"+menuPrice+"'/></div>";

basket3 += "			<div class='basketcmd'><a href='javascript:void(0)' class='abutton' onclick='javascript:basket.delItem();'>삭제</a></div>"

$(".subdiv_basket").append(basket1);
$(".subdiv_basket2").append(basket2);
$(".subdiv_basket3").append(basket3);
bsMenuName.push(menuName);
menuNumList += menuNum + " ";
$("#totalCount").val(parseInt($("#totalCount").val()) +1);
$("#totalListNum").val(parseInt($("#totalListNum").val()) +1);
$("#origin_Price").val(parseInt($("#origin_Price").val()) + parseInt(menuPrice));

$("#result_Price_s").text($("#origin_Price").val())

//alert($("#result_Price").val());
//alert($("#result_Price_s").text($("#origin_Price").val()));
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

function changePNum(pos){
	//수량변경 스크립트
	
	//수량에대한정보
	var item = document.querySelector('input[name=p_num'+pos+']');
    var p_num = parseInt(item.getAttribute('value'));
    
    //음료 1잔 가격
    var orgpce = document.querySelector('input[name=p_price'+pos+']');
    var p_orgpce = parseInt(orgpce.getAttribute('value'));
    
    //음료 n잔 가격
    var pce = document.querySelector('input[name=p_sum'+pos+']');
    var p_pce = parseInt(pce.getAttribute('value'));
    
    //수량 업다운
    var newval = event.target.classList.contains('up') ? p_num+1 : event.target.classList.contains('down') ? p_num-1 : event.target.value;
    if (parseInt(newval) < 1 || parseInt(newval) > 99) { return false; }
	
    //업다운된 수량으로 음료의 n잔 가격을 구한다
    var newprice = p_orgpce * newval;
    
    //페이지에 수량정보 업데이트
    item.setAttribute('value', newval);
    item.value = newval;
    
    //페이지에 n잔가격 업데이트
    pce.setAttribute('value', newprice);
   	pce.value = newprice;
	
   	totalCount();
	totalSum();
	$("#result_Price_s").text($("#origin_Price").val());
}


function totalCount(){
	var sum = 0;
	for(i = 1; i <=$("#totalListNum").val(); i++){
		var pval = document.querySelector('input[name=p_num' + i + ']');
	    var pnum = parseInt(pval.getAttribute('value'));
	    sum = sum + pnum;
	}
    $("#totalCount").val(sum);
}

function totalSum(){
	var sum = 0;
	for(i = 1; i <=$("#totalListNum").val(); i++){
		var pval = document.querySelector('input[name=p_sum' + i + ']');
	    var pnum = parseInt(pval.getAttribute('value'));
	    sum = sum + pnum;
	}
    $("#origin_Price").val(sum);
}


/* 장바구니수량변경 스크립트 */
var basket = {
	    totalCount: 0, 
	    totalPrice: 0,
	    //체크한 장바구니 상품 비우기
	    delCheckedItem: function(){
	        document.querySelectorAll("input[name=buy]:checked").forEach(function (item) {
	            item.parentElement.parentElement.parentElement.remove();
	        });
	        //AJAX 서버 업데이트 전송
	    
	        //전송 처리 결과가 성공이면
	        this.reCalc();
	        this.updateUI();
	    },
	    //장바구니 전체 비우기
	    delAllItem: function(){
	        document.querySelectorAll('.row.data').forEach(function (item) {
	            item.remove();
	          });
	          //AJAX 서버 업데이트 전송
	        
	          //전송 처리 결과가 성공이면
	          this.totalCount = 0;
	          this.totalPrice = 0;
	          this.reCalc();
	          this.updateUI();
	    },
	    //재계산
	    reCalc: function(){
	        this.totalCount = 0;
	        this.totalPrice = 0;
	        document.querySelectorAll(".p_num").forEach(function (item) {
	            if(item.parentElement.parentElement.parentElement.previousElementSibling.firstElementChild.firstElementChild.checked == true){
	                var count = parseInt(item.getAttribute('value'));
	                this.totalCount += count;
	                var price = item.parentElement.parentElement.previousElementSibling.firstElementChild.getAttribute('value');
	                this.totalPrice += count * price;
	            }
	        }, this); // forEach 2번째 파라메터로 객체를 넘겨서 this 가 객체리터럴을 가리키도록 함. - thisArg
	    },
	    //화면 업데이트
	    //updateUI: function () {
	    //    document.querySelector('#sum_p_num').textContent = '상품갯수: ' + this.totalCount.formatNumber() + '개';
	    //    document.querySelector('#sum_p_price').textContent = '합계금액: ' + this.totalPrice.formatNumber() + '원';
	    //},
	    //개별 수량 변경
	    //changePNum: function (pos) {
	       // var item = document.querySelector('input[name=p_num'+pos+']');
	       // var p_num = parseInt(item.getAttribute('value'));
	       // var newval = event.target.classList.contains('up') ? p_num+1 : event.target.classList.contains('down') ? p_num-1 : event.target.value;
	        
	       // if (parseInt(newval) < 1 || parseInt(newval) > 99) { return false; }

	       // item.setAttribute('value', newval);
	      //  item.value = newval;

	        //var price = item.parentElement.parentElement.previousElementSibling.firstElementChild.getAttribute('value');
	        //item.parentElement.parentElement.nextElementSibling.textContent = (newval * price).formatNumber()+"원";
	        //AJAX 업데이트 전송

	        //전송 처리 결과가 성공이면    
	        //this.reCalc();
	        //this.updateUI();
	    //},
	    checkItem: function () {
	        this.reCalc();
	        this.updateUI();
	    },
	    delItem: function () {
	        event.target.parentElement.parentElement.parentElement.remove();
	        this.reCalc();
	        this.updateUI();
	    }
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

function comm() {
	$("#rsrv_PplCnt").val(parseInt($("#rsrv_PplCnt").val()));
	$("#totalCount").val(parseInt($("#totalCount").val()));
	alert('준비되지 않은 서비스입니다.');
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
    document.getElementById("pay_Point").value = v_point; //input 값 설정
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
    	//if(v_point = 0) alert("100 point 단위로 사용 가능합니다.");
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
	
	$("#rsrv_PplCnt").val(parseInt($("#rsrv_PplCnt").val()));
	$("#totalCount").val(parseInt($("#totalCount").val()));
	
	$("#result_Price").val(parseInt($("#result_Price_s").text()));
	
	if($("#rsrv_PplCnt").val() > $("#totalCount").val()){
		alert("예약인원보다 주문된 음료 수가 적습니다. 음료를 추가해주세요.");
		return;
	}
	
	
	
	//ajax

	$.ajax({
        type: "POST",
        url: "/cafe/reservProc",
        data: {
           rsrvCafe: $("#rsrv_Cafe").val(), 		//예약카페이름
           rsrvSeat: $("#rsrv_Seat").val(),			//예약자리
           rsrvTime: $("#rsrv_Time").val(),			//예약시간
           rsrvDate: $("#rsrv_Date").val(),			//결제날짜
           originPrice: $("#origin_Price").val(),	//결제금액
           payPoint: $("#use_Point").val(),			//사용한포인트
           resultPrice: $("#result_Price").val(),	//최종결제금액 - 포인트할인 적용
           rsrvPplCnt: $("#rsrv_PplCnt").val(),		//예약인원
           cafeNum: $("#cafeNum").val(),			//예약한 카페의 번호
           menuNum: menuNumList						//예약한 메뉴의 번호값
        },
        datatype: "JSON",
        beforeSend : function (xhr){
           xhr.setRequestHeader("AJAX","true");
        },
        success:function(response){
           if(response.code == 0)
           {
              alert("결제시작");
              
              location.href = "/mypage/userPayment";
           }
           else if(response.code == 404)
           {
        	   alert("aa");
           }
           else if(response.code == 403)
           {
        	   alert("bb");
           }
           else if(response.code == 402)
           {
        	   alert("cc");
           }
           else if(response.code == 520){
        	   alert("dd");
           }
           else{
        	   alert("ee");
           }
           
        },
        complete: function(data)
        {
           //응답이 종료되면
           icia.common.log(data);
        },
        error: function(xhr, status, error)
        {
           icia.common.error(error);
        }
     
     });
	
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
				<div class="widget">
					<h1>카페 한잔</h1><br><br>
					<p><h4>음료는 예약인원수만큼</h4></p>
					<p><h4>주문해주세요</h4></p>				
	            </div>
	 
				<!-- 카테고리 커피 -->
				<div class="widget product-category">
					<h4 class="widget-title">카테고리</h4>
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
									<li class="tab-link current" data-tab="tab-1">ice</a></li>
									<li class="tab-link" data-tab="tab-2">hot</a></li>
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
									<c:if test="{i%j == 0}">
									<tr>
									</c:if>
										<td>
											<%-- <input type="hidden" id="menunum" value="${menupht.menunum}" /> --%>
											
											<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/drink/ice/${menuPht.phtNum}.png"  />
											<span id="menuName">${menuPht.menuName}</span>
											<p></p>
											<span id="menuPrice">${menuPht.menuPrice}</span>
											<p></p>
											<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
										    <input type="button" onclick="imageselect(event)" value="장바구니담기">
										</td>
									<c:if test="${i%j == j-1}">
									</tr>
								</c:if>
								<c:set var="i" value="${i+1}"/>
								</c:forEach>
							</table>	
								
							<!-- 		
							<div class="product-content">
								<br><p class="price">4500원</p>
							</div> -->
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
												<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/drink/hot/${menuPht.phtNum}.png"  />
												<span id="menuName">${menuPht.menuName}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuPrice}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuNum}</span>
												<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
											    <input type="button" onclick="imageselect(event)" value="장바구니담기">
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
												<img class="img-responsive" src="/resources/images/shop/reservation/${cafe.userId}/dessert/${menuPht.phtNum}.png"  />
												<span id="menuName">${menuPht.menuName}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuPrice}</span>
												<p></p>
												<span id="menuPrice">${menuPht.menuNum}</span>
												<input type="hidden" id="menuNum" value="${menuPht.menuNum}" />
											    <input type="button" onclick="imageselect(event)" value="장바구니담기">
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
                   <div class="check">선택</div>
                   <div class="img">이미지</div>
                   <div class="pname">상품명</div>
               </div>
               <div class="subdiv">
                   <div class="basketprice">가격</div>
                   <div class="num">수량</div>
                   <div class="sum">합계</div>
               </div>
               <div class="subdiv">
                   <div class="basketcmd">삭제</div>
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
           
       
        
            
        <div class="right-align basketrowcmd">
            <a href="javascript:void(0)" class="abutton" onclick="delCheckedItem();">선택상품삭제</a>
            <a href="javascript:void(0)" class="abutton" onclick="delAllItem();">장바구니비우기</a>
        </div>

        <div class="bigtext right-align sumcount" id="sum_p_num" name="totalCount">
        	<input type="text" name="totalCount" id="totalCount" value="0"/>
        	<input type="hidden" name="totalListNum" id="totalListNum" value="0"/>
        </div>
        <br/><br/>
        <!-- div class="bigtext right-align box blue summoney">합계금액:
        <input type="text" name="origin_Price" id="origin_Price" value="0" /></div> -->

        <div id="goorder" class="">
            <div class="clear"></div>
            <div class="buttongroup center-align cmd">
                <a href="javascript:void(0);">선택한 상품 주문</a>
            </div>
        </div>
    </form>        


    <br/><br/><br/><br/><br/><br/><br/>
    
   <div class="checkout shopping">
      <div class="container">
         <div class="row"><div class="col-md-12">
            <div class="content">
               <img src="/resources/images/logo21.png" alt="image" width="230" height="50" />
            </div>
         </div>
            <div class="col-md-8">
            
               <div class="block billing-details">
                  <h4 class="widget-title">주문자 정보</h4>
                  <form class="checkout-form">
                     <div class="form-group">
                        <label for="full_name">예약자 아이디</label>
                        
                        <input type="text" class="form-control" id="rsrv_Name" placeholder="" value="${rsRv.userName}">
                     </div>
                     <div class="form-group">
                        <label for="user_address">예약 카페</label>
  
                        <input type="hidden" id="cafeNum" name="cafeNum" value="${cafe.cafeNum}">
                        <input type="text" class="form-control" id="rsrv_Cafe" placeholder="" value="${cafe.cafeName}">
                     </div>
                     <div class="checkout-country-code clearfix">
                        <div class="form-group">
                           <label for="user_post_code">예약자리</label>
                           <input type="text" class="form-control" id="rsrv_Seat" name="zipcode" value="${rsRv.seatList}">
                        </div>
                        <div class="form-group" >
                           <label for="user_city">예약 시간</label>
                           <input type="text" class="form-control" id="rsrv_Time" name="city" value="${rsRv.rsrvTime}" readonly>
                        </div>
                     </div>
                     <div class="form-group">
                     	<label>예약 인원</label>
                     	<input type="text" class="form-control" id="rsrv_PplCnt" name="rsrv_PplCnt" value="${rsRv.rsrvPplCnt}" readonly>
                     </div>
                     <div class="form-group">
                        <label for="user_country">예약 날짜</label>
                        <input type="text" class="form-control" id="rsrv_Date" placeholder="" value="${rsRv.rsrvDate}" readonly />
                     </div>
                  </form>
               </div>
               <div class="block">
                  <h4 class="widget-title">결제 방법</h4>
                  <div class="checkout-product-details">
                     <div class="payment">
                        <div class="card-details">
                           <form  class="checkout-form">                                                      
                              <img src="/resources/images/kakao.png" alt="image" width="150" height="150" onclick='payment();'name="pay" id="pay"/>
                              <img src="/resources/images/comm.png" alt="image" width="150" height="150" onclick='javascript:comm()'/>
                              <img src="/resources/images/comm.png" alt="image" width="150" height="150" onclick='javascript:comm()'/>
                      </form>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            
            <div class="col-md-4">
               <div class="product-checkout-details">
                  <div class="block">
                     <h4 class="widget-title">총 금액</h4>
                    
                       <img src="/resources/images/logo23.png" width="300" height="80" alt="" />
                     </div>
                     <table class="tbl_edit01">
                 <colgroup>
                   <col width="90px"/>
                   <col width="*"   />
                 </colgroup>
                 
                 <tbody>
                   <tr>
                     <th>결제금액</th>
                     <td><input type="text" name="origin_Price" id="origin_Price" value="0" />
                     <!-- span class="bold txt_blue" id="origin_Price" name="origin_Price"-->원</span></td>
                   </tr>
                   <tr>
                     <th> 포 인 트 </th>
                     <td>
                     <input type="hidden" id="pay_Point" value="20300"> 
                       사용가능 포인트 : <span name="pay_Point3" id="pay_Point">${user.totalPoint}</span>p <span><input type="checkbox" id="chk_use" onclick="chkPoint($('#origin_Price').val(),${user.totalPoint},100,100)">포인트 전체 사용</span>
                       <span style="float:right">포인트는 100p단위로 사용 가능합니다.</span>
                     </td>
                   </tr>
                   <tr>
                     <td></td>
                     <td><!--  사용한포인트 -->
                       <span> <input type="number" name="use_Point" id="use_Point" value="0" min="100" max="${user.totalPoint}" onchange="changePoint($('#origin_Price').val(),${user.totalPoint},100,100)"></span> p 
                       <span> ( 남은포인트 : </span><span name="left_pnt" id="left_pnt">${user.totalPoint}</span>p ) <!-- //amt : 최초 결제 금액 / pnt : 사용가능,남은 포인트 / min : 사용 가능 최소 포인트 / unit : 사용단위-->
                     </td>
                   </tr>
                   <tr>
                     <td></td>
                     <td>
                        <p class="bold txt_red"> 최종 결제 금액 :
                        <span class="bold txt_red" id="result_Price_s">0</span> 원</p>
                     	<input type="hidden" id="result_Price" value="0" />
                     </td>
                   </tr>
                 </tbody>
               </table>
                                    <div class="verified-icon">
                        <img src="/resources/images/shop/verified.png">
                     </div>
                    
                  </div>
               </div>
               
            </div>
         </div>
      </div>
	<div id="goorder" class="">
            <div class="clear"></div>
            <div class="buttongroup center-align cmd">
           		<input type="button" onclick="btnaaa();" value="aaaa"/ >
                <a href="javascript:void(0);">선택한 상품 주문</a>
            </div>
        </div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>