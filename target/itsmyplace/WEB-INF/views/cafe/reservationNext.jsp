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

.basketdiv{
	
}
</style>

<script>




/* 이미지보기 스크립트 */
function imageselect(event)
{
	
	const productObj = event.target.parentNode;
	console.log(productObj.childNodes);
	
	let basket1 = "";
	let basket2 = "";
	
	let menuName = productObj.childNodes[3].textContent;
	let menuNum = productObj.childNodes[11].value;
	let menuPrice = productObj.childNodes[7].textContent;
	
	alert(productObj);
	
	$.ajax({
        type: "POST",
        url: "/cafe/menuSelect",
        data: {
           //menuName : $("#productname").val(),
           menuNum : menuNum
        },
        datatype: "JSON",
        beforeSend : function (xhr){
           xhr.setRequestHeader("AJAX","true");
        },
        success:function(response){
           if(response.code == 0)
           {
			alert("선택성공");
			
			
basket1 += "			   <div class='check'><input type='checkbox' name='buy' value='260' checked='' onclick='javascript:basket.checkItem();'>&nbsp;</div>";
basket1 += "               <div class='img'><img src='./img/basket1.jpg' width='60'></div>";
basket1 += "               <div class='pname'>";
basket1 += "                   <input type='text' id='productname' value='"+menuName+"' size='9'>";
basket1 += "               </div>";

basket2 += "               <div class='basketprice'><input type='hidden' name='p_price' id='p_price1' class='p_price' value='"+ menuPrice +"'>"+menuPrice+"</div>";
basket2 += "               <div class='num'>";
basket2 += "                   <div class='updown'>";
basket2 += "                     <span onclick='javascript:basket.changePNum(1);'><i class='fas fa-arrow-alt-circle-down down'></i></span>";
basket2 += "                      <input type='text' name='p_num1' id='p_num1' size='2' maxlength='4' class='p_num' value='2' onkeyup='javascript:basket.changePNum(1);'>";
basket2 += "                      <span onclick='javascript:basket.changePNum(1);'><i class='fas fa-arrow-alt-circle-up up'></i></span>";
basket2 += "                  </div>";
basket2 += "              </div>";
/*
basket += "              <div class='sum'>"+menuPrice+"</div>";
<div class="basketcmd"><a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delItem();">삭제</a></div>
*/

$(".subdiv_basket1").append(basket1);
$(".subdiv_basket2").append(basket2);

           }
           else if(response.code == 100)
           {
        	   alert("에러100");
           }
           else if(response.code == 400)
           {
        	   alert("에러400");
           }
           else
           {
        	   alert("에러");
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



$(document).ready(function(){
	
	/* 카테고리설정 스크립트 */
	$('ul.tabs li').on("click", function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
});



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
	    updateUI: function () {
	        document.querySelector('#sum_p_num').textContent = '상품갯수: ' + this.totalCount.formatNumber() + '개';
	        document.querySelector('#sum_p_price').textContent = '합계금액: ' + this.totalPrice.formatNumber() + '원';
	    },
	    //개별 수량 변경
	    changePNum: function (pos) {
	        var item = document.querySelector('input[name=p_num'+pos+']');
	        var p_num = parseInt(item.getAttribute('value'));
	        var newval = event.target.classList.contains('up') ? p_num+1 : event.target.classList.contains('down') ? p_num-1 : event.target.value;
	        
	        if (parseInt(newval) < 1 || parseInt(newval) > 99) { return false; }

	        item.setAttribute('value', newval);
	        item.value = newval;

	        var price = item.parentElement.parentElement.previousElementSibling.firstElementChild.getAttribute('value');
	        item.parentElement.parentElement.nextElementSibling.textContent = (newval * price).formatNumber()+"원";
	        //AJAX 업데이트 전송

	        //전송 처리 결과가 성공이면    
	        this.reCalc();
	        this.updateUI();
	    },
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
	Number.prototype.formatNumber = function(){
	    if(this==0) return 0;
	    let regex = /(^[+-]?\d+)(\d{3})/;
	    let nstr = (this + '');
	    while (regex.test(nstr)) nstr = nstr.replace(regex, '$1' + ',' + '$2');
	    return nstr;
	};
	
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
								<c:forEach var="menupht" items="${menupht}">
									<c:if test="{i%j == 0}">
									<tr>
									</c:if>
										<td>
											<%-- <input type="hidden" id="menunum" value="${menupht.menunum}" /> --%>
											
											<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/ice/${menupht.phtnum}.png"  />
											<span id="menuName">${menupht.menuname}</span>
											<p></p>
											<span id="menuPrice">${menupht.menuprice} 원</span>
											<p></p>
											<input type="hidden" id="menuName" value="${menupht.menunum}" />
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
				</div> 
			</div>
					
			<!-- 두번째 -->
			<div class="col-md-9">
				<div class="row">
					<div id="tab-2" class="tab-content"  style="overflow:auto; width:870px; height:600px;">
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/1.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">4500원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/2.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">4500원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/3.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">5000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/4.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/5.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/6.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
						<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/7.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
						<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/8.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
						<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/drink/hot/9.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
				</div>
			</div> 
		</div>
			
		<!-- 세번째 -->
			<div class="col-md-9">
				<div class="row">
					<div id="tab-3" class="tab-content" style="overflow:auto; width:870px; height:600px;">
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/1.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">9000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/2.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">10000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/3.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">10000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/4.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">6000원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/5.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">5500원</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/images/shop/reservation/hanzan/dessert/6.png" alt="product-img" />
							</div>
							<div class="product-content">
								<br><p class="price">4500원</p>
							</div>
						</div>
					</div>
					</div>
				</div> 
			</div>		
				
		</div><!--row-->
	</div><!--container-->
</section>


<!-- 하단 장바구니 -->
<!-- 하단 장바구니 -->
<form name="orderform" id="orderform" method="post" class="orderform" action="/Page" onsubmit="return false;" style="margin:0 auto; padding:0; max-width:1170px;">
	<!-- style="width: 1840px; padding-left: 700px;" -->    
     <input type="hidden" name="cmd" value="order">
<!--  basketdiv-->
       <div class="basketdiv" id="basket" style="margin:0; padding:0; max-width:1170px;">
           <div class="row head" style="margin:0; padding:0; max-width:1170px;">
           			<div class="subdiv" style="margin:0; padding:0; max-width:1170px;">
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
           <div class="row data" style="margin:0; padding:0; max-width:1170px;">
           
               <div class="subdiv_basket1"></div>
               <div class="subdiv_basket2"></div>`
               <div class="subdiv_basket3"></div>             
           </div>
	   </div>
           
       
        
            <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
        <!-- <div class="right-align basketrowcmd">
            <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delCheckedItem();">선택상품삭제</a>
            <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delAllItem();">장바구니비우기</a>
        </div>

        <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: 4개</div>
        <div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액: 74,200원</div>

        <div id="goorder" class="">
            <div class="clear"></div>
            <div class="buttongroup center-align cmd">
                <a href="javascript:void(0);">선택한 상품 주문</a>
            </div>
        </div>-->
</form>        
</body>
</html>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>