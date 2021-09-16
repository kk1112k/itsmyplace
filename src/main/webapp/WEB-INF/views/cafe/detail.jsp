<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>
.ellipsis2
{
   overflow: hidden;
   text-overflow: ellipsis;
   display: -webkit-box;
   -webkit-line-clamp: 2; 
   -webkit-box-orient: vertical;
} 
  
.star_rating
{
   font-size:0;
   letter-spacing:-4px;
}

.star_rating a
{
    font-size:15px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
}

.star_rating a:first-child
{
   margin-left:0;
}
.star_rating a.on
{
   color:#CC0000;
}
</style>

</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- 카페 상세페이지 상단바 -->
<section class="single-product">
   <div class="container">
      <div class="row">
         <div class="col-md-6">
            <ol class="breadcrumb">
               <li style="font-size:15px;"><a href="/index">메인페이지 </a></li>
               <li style="font-size:15px;"><a href="/cafe/intro">카페</a></li>
               <li class="/index" style="font-size:15px;">상세 페이지</li>
            </ol>
         </div>
         <div class="col-md-6">
            <ol class="product-pagination text-right">
               <c:set var="cafeNumber" value="${cafe.cafeNum}"/>
               <c:set var="minusSub" value="${(fn:substring(cafeNumber,1,8))-1}"/>
               <c:set var="plusSub" value="${(fn:substring(cafeNumber,1,8))+1}"/>
               <c:if test="${minusSub > 0}">
                  <li style="font-size:15px;"><a href="/cafe/detail?cafeNum=A000000${(fn:substring(cafeNumber,1,8))-1}"><i class="tf-ion-ios-arrow-left"></i> 이전 카페 </a></li>
               </c:if>
               <c:if test="${plusSub < 5}">
                  <li style="font-size:15px;"><a href="/cafe/detail?cafeNum=A000000${(fn:substring(cafeNumber,1,8))+1}">다음 카페 <i class="tf-ion-ios-arrow-right"></i></a></li>
               </c:if>
            </ol>
         </div>
      </div>
<!-- 카페 상세페이지 상단바 끝 -->

<!-- 카페 소개 메인 시작 -->   
      <div class="row mt-20">
         <div class="col-md-5">
            <div class="single-product-slider">
               <div id='carousel-custom' class='carousel slide' data-ride='carousel'>
                  <div class='carousel-outer'>
                  
                     <!-- 카페 소개 사진 슬라이드 시작 -->
                     <div class='carousel-inner '>                     
                        <c:forEach var="cafePhtList" begin="2" end="8" items="${cafe.cafePhtList}" varStatus="status">
                           <c:choose>
                              <c:when test="${status.index == 2}">
                                 <div class='item active'>
                                    <img src='/resources/upload/cafe/${cafePhtList.phtName}' alt='슬라이드 ${status.count}번 이미지' data-zoom-image="/resources/upload/cafe/${cafePhtList.phtName}" style="width:550px; height:540px;"/>
                                 </div>
                              </c:when>
                              <c:otherwise>
                                 <div class='item'>
                                    <img src='/resources/upload/cafe/${cafePhtList.phtName}' alt='슬라이드 ${status.count}번 이미지' data-zoom-image="/resources/upload/cafe/${cafePhtList.phtName}" style="width:550px; height:540px;"/>
                                 </div>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                        
                        <%-- <div class='item active'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-1.png' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-1.png" style="width:550px; height:540px;"/>
                        </div>
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-0.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-0.jpg" style="width:550px; height:540px;"/>
                        </div>
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-2.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-2.jpg" style="width:550px; height:540px;"/>
                        </div>
                        
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-3.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-3.jpg" style="width:550px; height:540px;"/>
                        </div>
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-4.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-4.jpg" style="width:550px; height:540px;"/>
                        </div>
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-5.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-5.jpg" style="width:550px; height:540px;"/>
                        </div>
                        <div class='item'>
                           <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-6.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/${cafe.cafeNum}/product-6.jpg" style="width:550px; height:540px;"/>
                        </div> --%>
                        
                     </div>
                     <!-- 슬라이더 -->
                     <a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
                        <i class="tf-ion-ios-arrow-left"></i>
                     </a>
                     <a class='right carousel-control' href='#carousel-custom' data-slide='next'>
                        <i class="tf-ion-ios-arrow-right"></i>
                     </a>
                  </div>
                  
                  <!-- 썸네일 -->
                  <ol class='carousel-indicators mCustomScrollbar meartlab'>
                    <c:forEach var="cafePhtList" begin="2" end="8" items="${cafe.cafePhtList}" varStatus="status">
                     <c:choose>
                        <c:when test="${status.index == 2}">
                           <li data-target='#carousel-custom' data-slide-to='${status.count-1}' class='active'>
                           <img src='/resources/upload/cafe/${cafePhtList.phtName}' alt='썸네일 ${status.count}번 이미지' />
                           </li>
                        </c:when>
                        <c:otherwise>
                           <li data-target='#carousel-custom' data-slide-to='${status.count-1}'>
                           <img src='/resources/upload/cafe/${cafePhtList.phtName}' alt='썸네일 ${status.count}번 이미지' />
                           </li>
                        </c:otherwise>
                     </c:choose>
                  </c:forEach>
                  
                  
<%--                        <li data-target='#carousel-custom' data-slide-to='0' class='active'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-1.png' alt='' />
                     </li>
                     <li data-target='#carousel-custom' data-slide-to='0' class='active'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-0.jpg' alt='' />
                     </li>
                      <li data-target='#carousel-custom' data-slide-to='1'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-2.jpg' alt='' />
                     </li>
                     <li data-target='#carousel-custom' data-slide-to='2'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-3.jpg' alt='' />
                     </li>
                     <li data-target='#carousel-custom' data-slide-to='3'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-4.jpg' alt='' />
                     </li>
                     <li data-target='#carousel-custom' data-slide-to='4'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-5.jpg' alt='' />
                     </li>
                     <li data-target='#carousel-custom' data-slide-to='5'>
                        <img src='/resources/images/shop/single-products/${cafe.cafeNum}/product-6.jpg' alt='' />
                     </li>  --%>
      
                  </ol>
               </div>
            </div>
         </div>

<!-- 카페 설명 -->
         <div class="col-md-7">
            <div class="single-product-details">
               <div class="detail-cafeNameText">${cafe.cafeName}</div>
               <div class="detail-keyWordText">${cafe.cafeKeyword}</div>
               <c:set var="opnhrs" value="${cafe.cafeOpnHrs}"/>
               <c:set var="clshrs" value="${cafe.cafeClsHrs}"/>
               <div class="detail-keyWordText">영업시간 : 매일 ${fn:substring(opnhrs,0,2)}:${fn:substring(opnhrs,2,4)}-${fn:substring(clshrs,0,2)}:${fn:substring(clshrs,2,4)}</div>
               
               <p class="product-description mt-20"></p>
      
               <pre class="detail-contentText">${cafe.cafeContent}</pre>
               
               <c:if test="${user.userClass eq 'N'}">
                  <a href="/cafe/reservation?cafeNum=${cafe.cafeNum}" class="btn btn-main mt-20">예약 하러가기</a>
               </c:if>
            </div>
         </div>
      </div>

<br/>
<div class="detail-cafeNameText" style="text-align:center; padding-top:30px;">판매량 TOP3 메뉴</div>
<div class="container" style="padding:30px;">
   <div class="row" style="margin-left:20%; margin-right:20%;">
      <c:forEach var="phtList" items="${menuPhtList}" varStatus="status">
         <div class="col-md-4" style="text-align:center;">
            <c:set var="category" value="${phtList.menuNum}"/>
            <c:set var="cafeNumber" value="${cafe.cafeNum}"/>
			<img style="width:70%" src="/resources/images/shop/reservation/${cafe.userId}/menu/${fn:toLowerCase(fn:substring(category,0,3))}/${phtList.phtNum}.png" alt="메뉴이미지"/>
            <c:set var="menuName" value="${phtList.phtOrgName}"/>
            <c:set var="NameLength" value="${fn:length(menuName)}"/>
            <div class="detail-subNameText">${fn:substring(menuName,0,NameLength-4)}</div>
         </div>

      </c:forEach>
   </div>
</div>

<!-- 지도와 리뷰 시작 -->
      <div class="row">
         <div class="col-xs-12">
            <div class="tabCommon mt-20">
            <!-- 지도 시작 -->
               <ul class="nav nav-tabs">
                  <li class="active"><a data-toggle="tab" href="#details" aria-expanded="true">위치 보기</a></li>
                  <li class=""><a data-toggle="tab" href="#reviews" aria-expanded="false">리뷰</a></li>
               </ul>
               <div class="tab-content patternbg">
                  <div id="details" class="tab-pane fade active in">
                     <input type="hidden" id="mapCafeNum" name="mapCafeNum" value="${cafe.cafeNum}"/>
                     <div id="map" style="width:803px;height:400px; display: inline-block;"></div>
                      <c:choose>
                      <c:when test="${cafe.cafeNum == 'A0000001' or cafe.cafeNum == 'A0000003' }">
                        <input type="image" src="/resources/upload/cafe/${cafe.cafePhtList[11].phtName}" name="mapImg" alt="지도이미지">
                     </c:when>
                     <c:otherwise>
                        <input type="image" src="/resources/upload/cafe/${cafe.cafePhtList[10].phtName}" name="mapImg" alt="지도이미지">
                     </c:otherwise>
                     </c:choose>
                  </div>
            <!-- 지도 종료 -->
            
            <!-- 리뷰 시작 -->
                  <div id="reviews" class="tab-pane fade">
                    <c:if test="${!empty list}">
                     <c:forEach var="cafe" items="${list}" varStatus="status">     
                        <table class="table">
                           <tr class="media-list comments-list m-bot-50 clearlist">
                              <td width="80px" height="100px">
                                        <div>
                                        <c:if test="${cafe.userGender eq 'M'}">
                                        <img width=70; height=80; class="media-object comment-avatar" src="/resources/images/blog/review/damda/man.png" alt="" />
                                       </c:if>   
                                         <c:if test="${cafe.userGender eq 'F'}">
                                        <img width=70; height=80; class="media-object comment-avatar" src="/resources/images/blog/review/damda/woman.png" alt="" />
                                       </c:if>
                                       </div>
                                       <div style="font-size:small; text-align:center"><c:out value="${cafe.userId}" /></div>
                                     </td>
                                     <td>
                                        <div style="font-size:large; margin-bottom: 7px; color:#4397cf;"><c:out value="${cafe.bbsTitle}" /></div>
                                        <div style="font-size:x-small; margin-bottom: 7px;"><c:out value="${cafe.regDate}" /></div>
                                       <div style="margin-bottom: 5px;">
                                          <c:if test="${cafe.bbsStar == 1.0}">
                                    <div class="star_rating">
                                       <a href="#" class="on">★</a>
                                        <a href="#" >★</a>
                                        <a href="#" >★</a>
                                        <a href="#">★</a>
                                        <a href="#">★</a>
                                    </div>
                                    </c:if>
                                    <c:if test="${cafe.bbsStar == 2.0}">
                                    <div class="star_rating">
                                       <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" >★</a>
                                        <a href="#">★</a>
                                        <a href="#">★</a>
                                    </div>
                                    </c:if>
                                    <c:if test="${cafe.bbsStar == 3.0}">
                                    <div class="star_rating">
                                       <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#">★</a>
                                        <a href="#">★</a>
                                    </div>
                                    </c:if>
                                    <c:if test="${cafe.bbsStar == 4.0}">
                                    <div class="star_rating">
                                       <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#">★</a>
                                    </div>
                                    </c:if>
                                    <c:if test="${cafe.bbsStar == 5.0}">
                                    <div class="star_rating">
                                       <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                        <a href="#" class="on">★</a>
                                    </div>
                                    </c:if>
                                       </div>
                                        <div class="ellipsis2" style="font-size:medium;"><c:out value="${cafe.bbsContent}" /></div>
                                     </td>
                           </tr>
                        </table>
                         </c:forEach>
                       </c:if>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</section>

<!--  지도와 리뷰 종료  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d4e88f15e593c8d82ac492b1c60bc96"></script>
<script>
   var cafeNum = document.getElementById('mapCafeNum').value
   
   if(cafeNum == 'A0000001')
   {
      var mapOption = {
            
            center: new kakao.maps.LatLng(37.472439182020885, 126.62437583685791),
            level: 5   
      };
      
      // 마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(37.472439182020885, 126.62437583685791); 
      
      var iwContent = '<div style="padding:5px;">카페한잔<br><a href="https://map.kakao.com/link/map/카페한잔,37.472439182020885, 126.62437583685791" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/카페한잔,37.472439182020885, 126.62437583685791" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwPosition = new kakao.maps.LatLng(37.472439182020885, 126.62437583685791); //인포윈도우 표시 위치입니다
   }
   
   else if(cafeNum == 'A0000002')
   {
      var mapOption = {
            center: new kakao.maps.LatLng(37.40085366153824, 126.63876339102846),
            level: 5
      };
      
      var markerPosition  = new kakao.maps.LatLng(37.40085366153824, 126.63876339102846);
      
      var iwContent = '<div style="padding:5px;">커피도넛<br><a href="https://map.kakao.com/link/map/커피도넛,37.40085366153824,126.63876339102846" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/커피도넛,37.40085366153824,126.63876339102846" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwPosition = new kakao.maps.LatLng(37.40085366153824, 126.63876339102846); //인포윈도우 표시 위치입니다
   }
   
   else if(cafeNum == 'A0000003')
   {
      var mapOption = {
            center: new kakao.maps.LatLng(37.49533599224087, 126.72308364003173),
            level: 5
         };
      
      var markerPosition  = new kakao.maps.LatLng(37.49533599224087, 126.72308364003173); 
      
      var iwContent = '<div style="padding:5px;">카페노네임<br><a href="https://map.kakao.com/link/map/카페노네임,37.49533599224087, 126.72308364003173" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/카페노네임,37.49533599224087, 126.72308364003173" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwPosition = new kakao.maps.LatLng(37.49533599224087, 126.72308364003173); //인포윈도우 표시 위치입니다
   }
   
   else if(cafeNum == 'A0000004')
   {
      var mapOption = {
            center: new kakao.maps.LatLng(37.4486647463582, 126.6959746887932),
            level: 5
         };
      
      var markerPosition  = new kakao.maps.LatLng(37.4486647463582, 126.6959746887932); 
      
      var iwContent = '<div style="padding:5px;">카페담다<br><a href="https://map.kakao.com/link/map/카페담다,37.4486647463582, 126.6959746887932" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/카페담다,37.4486647463582, 126.6959746887932" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwPosition = new kakao.maps.LatLng(37.4486647463582, 126.6959746887932); //인포윈도우 표시 위치입니다
   }

   var mapContainer = document.getElementById('map');
   var map = new kakao.maps.Map(mapContainer, mapOption);

   // 마커를 생성합니다
   var marker = new kakao.maps.Marker({
       position: markerPosition
   });

   // 마커가 지도 위에 표시되도록 설정합니다
   marker.setMap(map);

   // 인포윈도우를 생성합니다
   var infowindow = new kakao.maps.InfoWindow({
       position : iwPosition, 
       content : iwContent 
   });
     
   // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
   infowindow.open(map, marker); 
</script>

<!-- 카페 둘러보기 -->
<section class="products related-products section">
   <div class="container">
      <div class="row">
         <div class="title text-center">
            <img src="/resources/images/king/anothercafeview.png" alt="image" width="250" height="60" />
         </div>
      </div>
         
      
      <c:forEach var="modalIndex" items="${cafeForAllList}" varStatus="status">    
      <c:set var="aa" value="${cafe.cafeNum}"/>
      <c:if test="${modalIndex.cafeNum ne aa}">
         <div class="col-md-4">
            <div class="product-item">
               <div class="product-thumb">
               <c:choose>
               <c:when test="${status.index == 0 or status.index == 2}">
                  <img class="img-responsive" src="/resources/upload/cafe/${modalIndex.cafePhtList[10].phtName}" alt="product-img" />
               </c:when>
               <c:otherwise>
                  <img class="img-responsive" src="/resources/upload/cafe/${modalIndex.cafePhtList[9].phtName}" alt="product-img" />
               </c:otherwise>
               </c:choose>
                  <div class="preview-meta">
                     <ul>
                        <li>
                           <span  data-toggle="modal" data-target="#product-modal${status.index}">
                              <i class="tf-ion-ios-search"></i>
                           </span>
                        </li>
                     </ul>
                         </div>
               </div>
               <div class="product-content">
                  <br/>
                  <p class="price">${modalIndex.cafeName}</p>
               </div>
            </div>
         </div>
         </c:if>
      </c:forEach>
<!-- 카페 담다 -->
<%--          <div class="col-md-4">
            <div class="product-item">
               <div class="product-thumb">
                  <img class="img-responsive" src="/resources/upload/cafe/${cafeForAllList[3].cafePhtList[9].phtName}" alt="product-img" />
                  <div class="preview-meta">
                     <ul>
                        <li>
                           <span  data-toggle="modal" data-target="#product-modal1">
                              <i class="tf-ion-ios-search"></i>
                           </span>
                        </li>
                     </ul>
                         </div>
               </div>
               <div class="product-content">
                  <br/>
                  <p class="price">카페담다</p>
               </div>
            </div>
         </div>
         
<!-- 카페 도넛 -->
         <div class="col-md-4">
            <div class="product-item">
               <div class="product-thumb">
                  <img class="img-responsive" src="/resources/upload/cafe/${cafeForAllList[1].cafePhtList[9].phtName}" alt="product-img" />
                  <div class="preview-meta">
                     <ul>
                        <li>
                           <span  data-toggle="modal" data-target="#product-modal2">
                              <i class="tf-ion-ios-search"></i>
                           </span>
                        </li>
                     </ul>
                         </div>
               </div>
               <div class="product-content">
                  <br/>
                  <p class="price">카페도넛</p>
               </div>
            </div>
         </div>
         
<!-- 노네임 -->
      <div class="row">
         <div class="col-md-4">
            <div class="product-item">
               <div class="product-thumb">
                  <img class="img-responsive" src="/resources/upload/cafe/${cafeForAllList[2].cafePhtList[10].phtName}" alt="product-img" />
                  <div class="preview-meta">
                     <ul>
                        <li>
                           <span  data-toggle="modal" data-target="#product-modal3">
                              <i class="tf-ion-ios-search"></i>
                           </span>
                        </li>
                     </ul>
                         </div>
               </div>
               <div class="product-content">
                  <br/>
                  <p class="price">카페노네임</p>
               </div>
            </div>
         </div>
      </div> --%>
   </div>
</section>

<!-- 다른카페 둘러보기 버튼 누르면 나오는 화면-->
<c:forEach var="modalIndex" items="${cafeForAllList}" varStatus="status">
   <c:set var="aa" value="${cafe.cafeNum}"/>
   <c:if test="${modalIndex.cafeNum ne aa}">
   <div class="modal product-modal fade" id="product-modal${status.index}">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <i class="tf-ion-close"></i>
         </button>
           <div class="modal-dialog " role="document">
             <div class="modal-content">
                  <div class="modal-body">
                    <div class="row">
                       <div class="col-md-8">
                          <div class="modal-image">
                             <img class="img-responsive" src="/resources/upload/cafe/${modalIndex.cafePhtList[3].phtName}" alt="메뉴판이미지" />
                          </div>
                       </div>
                       <div class="col-md-3">
                          <div class="product-short-details">
                             <h5 class="product-title" style="width:140%;">${modalIndex.cafeAddr}</h5>
                             <p class="product-price">${modalIndex.cafeName}</p>
                             <p class="product-short-description">                                
                                <div>
                                   <c:set var="opnhrs" value="${modalIndex.cafeOpnHrs}"/>
                                 <c:set var="clshrs" value="${modalIndex.cafeClsHrs}"/>
                                 <p>영업시간<br>매일 ${fn:substring(opnhrs,0,2)}:${fn:substring(opnhrs,2,4)}-${fn:substring(clshrs,0,2)}:${fn:substring(clshrs,2,4)}</p>
                                </div>
                             <a href="/cafe/detail?cafeNum=${modalIndex.cafeNum}" class="btn btn-main">자세히 보기</a>
                          </div>
                       </div>
                    </div>
                 </div>
             </div>
           </div>
      </div>
   </c:if>
 </c:forEach>
<%--
<!-- 2번째 카페 시작 -->
   <div class="modal product-modal fade" id="product-modal3">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <i class="tf-ion-close"></i>
      </button>
        <div class="modal-dialog " role="document">
          <div class="modal-content">
               <div class="modal-body">
                 <div class="row">
                    <div class="col-md-8">
                       <div class="modal-image">
                          <img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modaldamda.png  />
                       </div>
                    </div>
                    <div class="col-md-3">
                       <div class="product-short-details">
                          <h5 class="product-title">인천 남동구 인주대로604 49-14 1층</h5>
                          <p class="product-price">카페담다</p>
                          <p class="product-short-description">
                             <p>영업시간 : 10:00 ~ 22:00</p><br>
                          <a href="/cafe/A0000004" class="btn btn-main">자세히 보기</a>
                       </div>
                    </div>
                 </div>
              </div>
          </div>
        </div>
   </div>
<!-- 2번째 카페 끝 -->

<!-- 3번째 카페 시작 -->
   <div class="modal product-modal fade" id="product-modal1">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <i class="tf-ion-close"></i>
      </button>
        <div class="modal-dialog " role="document">
          <div class="modal-content">
               <div class="modal-body">
                 <div class="row">
                    <div class="col-md-8">
                       <div class="modal-image">
                          <img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modaldonut.jpg  />
                       </div>
                    </div>
                    <div class="col-md-3">
                       <div class="product-short-details">
                          <h5 class="product-title">인천 연수구 아트센터대로 107 302동 168호 3층</h5>
                          <p class="product-price">카페 도넛</p>
                          <p class="product-short-description">
                             <p>영업시간 : am10 ~ pm21, 매주 수요일 휴무</p><br>
                           <p>   BEST 심슨도넛<br>
                              BEST 티라미수<br>
                              BEST 까망 라떼<br>
                           </p>
                          <a href="/cafe/A0000002" class="btn btn-main">자세히 보기</a>
                       </div>
                    </div>
                 </div>
              </div>
          </div>
        </div>
   </div>   
      
<!-- 3번째 카페 끝 -->

<!-- 4번째 카페 시작 -->
<div class="modal product-modal fade" id="product-modal2">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <i class="tf-ion-close"></i>
      </button>
        <div class="modal-dialog " role="document">
          <div class="modal-content">
               <div class="modal-body">
                 <div class="row">
                    <div class="col-md-8">
                       <div class="modal-image">
                          <img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modalnoname.jpg  />
                       </div>
                    </div>
                    <div class="col-md-3">
                       <div class="product-short-details">
                          <h5 class="product-title">인천 부평구 부평대로38번길 1,2층</h5>
                          <p class="product-price">노네임</p>
                          <p class="product-short-description">
                             <p>영업시간 : am10 ~ pm22, 연중무휴</p><br>
                           <p>   BEST 자두스무디<br>
                              BEST 비엔나 커피<br>
                              BEST 망고에이드<br>
                           </p>
                          </p>
                          <a href="/cafe/A0000003" class="btn btn-main">자세히 보기</a>
                       </div>
                    </div>
                 </div>
              </div>
          </div>
        </div>
   </div>
<!-- 4번째 카페 끝 -->
 --%>
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
 
 
  </body>
  </html>