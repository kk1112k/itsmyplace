<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
 	<meta charset="UTF-8">
<style>
@import url("https://fonts.googleapis.com/css?family=Montserrat:300,400,700");

#wrapper {
  margin: 5%;
  display: flex;
  justify-content: center;
  align-items: left;
}

/* Accordion Container */


/*
.container {
  width: 80%;
  max-width: 1050;
  min-width: 1050;
  position: relative;

}
*/


/* shadow */
.container:before {
  content: '';
  position: absolute;
  width: calc(100% - 30px);
  height: 100%;
  margin: 0;
  left: 15px;
  background-color: transparent;
  top: 0px;
  opacity: 0.2;
  z-index: -1;
  transition: ease-in-out 0.6s all;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
  border-radius: 3px;

}

.accordionTitle {
  padding: 20px;
  position: relative;
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  letter-spacing: 0.8px;
  color: #52616b;
  transition: ease-in-out 0.2s all;
  cursor: pointer;

}

.accordionTitle:hover {
  padding-left: 25px;
}

/* Accordion Item line */
.accordionTitle:before,
.accordionTitle:after {
  content: '';
  position: absolute;
  height: 2px;
  border-radius: 50px;
  transition: ease-in-out 0.6s all;
  bottom: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: bold;
}

.accordionTitle:before {
  width: 100%;
  background-color: #c9d6df;
}



.accordionTitle:hover::after {
  width: 100%;
}

/* Accordion Item line - Active */
.accordionTitleActive:after {
  content: '';
  position: absolute;
  height: 2px;
  border-radius: 50px;
  transition: ease-in-out 0.6s all;
  bottom: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
}

.accordionTitleActive:after {
  background-image: linear-gradient(90deg, #52616b, #c9d6df);
  width: 100%;
}

/* Accordion Item Icon  */
.accIcon {
  float: right;
  width: 30px;
  height: 30px;
  display: flex;
  margin-top: -3px;
  align-items: center;
  justify-content: center;
  
}

.accIcon:before,
.accIcon:after {
  content: '';
  position: absolute;
  border-radius: 50px;
  background-color: #c9d6df;
  transition: ease 0.3s all;
}

.accIcon:before {
  width: 2px;
  height: 20px;
}

.accIcon:after {
  width: 20px;
  height: 2px;
}

.accordionTitle:hover .accIcon:before,
.accordionTitle:hover .accIcon:after {
  background-color: #52616b;
}

.accIcon.anime.accIcon:before {
  transform: rotate(90deg);
}

/* Text Content */
.accordion .item .text {
  opacity: 0;
  height: 0;
  padding: 0px 20px;
  position: relative;
  line-height: 24px;
  font-size: 18px;

  font-weight: 200;
  transition: all 0.6s cubic-bezier(0.42, 0.2, 0.08, 1);
  overflow: hidden;
  background-color: #f0f5f9;
  letter-spacing: 0.5px;
}

/* Text Content - Class for JS to hide and show */
.accordion .item .text.show {
  opacity: 1;
  height: auto;
  
  padding: 25px 20px;
  position: relative;
  z-index: 0;
  border-radius: 0px 0px 3px 3px;
}
</style>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- partial:index.partial.html -->

<div class="user-dashboard page-wrapper">
	<div class="container">
	   <div class="d-flex">
	   <div class="logo text-left">
					<a href="/cs/list"><img src="/resources/images/king/faq.png" alt="image" width="360" height="80" /></a>
					<br/>

				</div>
			</div>
		<div class="comm-custom2"></div>
        <div style="margin-left:13px;">
        	<ul class="list-inline dashboard-menu text-left">	
	          <li><a href="/cs/list">Q&A</a></li>
	          <li><a class="active" href="/cs/faq">FAQ</a></li>
	        </ul>
        </div>	
			
		<br/>
   <ul class="accordion">
      <li class="item">
         <h2 class="accordionTitle">1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"정지된 계정입니다" 라는 문구가 뜨면서 로그인이 되지 않습니다.<span class="accIcon"></span></h2>
         <div class="text"> 저희 내자리얌은 비방·욕설 글에 대하여 원 스트라이크 아웃제도를 운영하고 있으며 이에 해당하는 게시글은 관리자에 의해 삭제됨과 동시에 작성자는 회원 정지 처리됩니다.
					<br>
			      	 다른 이용자들을 위하여 더욱 깨끗한 네티즌 문화를 만들어갑시다.</div>
      </li>
      <li class="item">
         <h2 class="accordionTitle">2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제했어요! 포인트 적립은 상시 3%만 적립되는건가요? <span class="accIcon"></span></h2>
         <div class="text">예, 그렇습니다. 현재는 일괄적으로 결제금액의 3%를 포인트로 적립해드리고 있으며, 후기작성시 결제금액의 2%를 포인트로 적립해드립니다.  <br>추후 장기간 사이트를 이용해주시는 회원님들을 위해 포인트를 상향 적립하여 운영할 예정입니다.</div>
      </li>
      <li class="item">
         <h2 class="accordionTitle">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제 수단이 부족해요.<span class="accIcon"></span></h2>
         <div class="text">현재 저희 내자리얌은 카카오페이와의 제휴를 통해 서비스를 제공하고 있으며,<br>추후 기타 간편결제 및 계좌이체, 신용카드 등의 결제 시스템을 도입할 예정입니다. </div>
      </li>
      <li class="item">
         <h2 class="accordionTitle">4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;예약을 했는데 취소하고 싶어요. 환불은 어떻게 이루어지나요?<span class="accIcon"></span></h2>
         <div class="text">현재는 이용하신 결제 수단으로 직접적인 환불이 지원되지 않으며,
         <br> 환불된 금액은 다음번에 바로 이용하실 수 있게 사이트 적립금으로 지급됩니다. 이용에 불편을 드려 대단히 죄송합니다.</div>
      </li>
      <li class="item">
         <h2 class="accordionTitle">5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사업자로 카페입점 문의하고 싶어요.<span class="accIcon"></span></h2>
         <div class="text">카페 입점 문의는 itsmyplace1@naver.com 으로 별도 양식 없이 메일로 문의 주시면 빠르게 응대해드리고 있습니다.</div>
      </li>
   </ul>
</div>
</div>

<!-- partial -->
<script>
//variables
var accordionBtn = document.querySelectorAll('.accordionTitle');
var allTexts = document.querySelectorAll('.text');
var accIcon = document.querySelectorAll('.accIcon');

// event listener
accordionBtn.forEach(function (el) {
    el.addEventListener('click', toggleAccordion)
});

// function
function toggleAccordion(el) {
   var targetText = el.currentTarget.nextElementSibling.classList;
   var targetAccIcon = el.currentTarget.children[0];
   var target = el.currentTarget;
   
   if (targetText.contains('show')) {
       targetText.remove('show');
       targetAccIcon.classList.remove('anime');
       target.classList.remove('accordionTitleActive');
   } 
   else {
      accordionBtn.forEach(function (el) {
         el.classList.remove('accordionTitleActive');
         
         allTexts.forEach(function (el) {
            el.classList.remove('show');
         })
         
         accIcon.forEach(function (el) {
          el.classList.remove('anime');
         }) 
         
      })
      
         targetText.add('show');
         target.classList.add('accordionTitleActive');
         targetAccIcon.classList.add('anime');
   }  
}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>
</html>
