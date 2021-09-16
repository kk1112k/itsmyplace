<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>

function fn_detail(cafeNum){
		
	location.href = "/cafe/detail?cafeNum=" + cafeNum;

}

function fn_rsrv(cafeNum){
	
		location.href = "/cafe/reservation?cafeNum=" + cafeNum;
	
}

</script>

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
    font-size:12px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
    margin-bottom: 3px;
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
<section class="product-category section" style="padding:20px;">
	<div class="container">
		<div class="row">
			<div class="logo text-left">
				<img src="/resources/images/logo6.png" alt="image" width="250" height="60" style="margin-left:50px;"/>
				<div class=index-info-text style="display:inline-block; margin-left:200px;">내자리얌의 입점카페를 확인하세요!</div>
			</div>
			
			<br><br><br>
					
			<c:if test="${!empty cafeList}">
				<c:forEach var="cafeList" items="${cafeList}" varStatus="status">
			
				<div class="col-md-6" align="center">
						<div class="content" style="border:4px solid #4397cf; width:510PX; height:530PX;">
						<div class="intro-cafeName">${cafeList.cafeName}</div>
						<div class="intro-areaName">${cafeList.areaName}&nbsp;${cafeList.subAreaName}</div>
						<c:if test="${!empty cafeList.cafePhtList}">
							<c:forEach var="cafePhtList" items="${cafeList.cafePhtList}" varStatus="s">
								<img class="intro-cafeImg" src="/resources/upload/cafe/${cafePhtList.phtName}" alt="카페이미지" width="500" height="400"/>
							</c:forEach>
						</c:if>
			 			<c:if test="${!empty cafeList.reviewList}">
							<div class="intro-review">
								<table class="table">
				                  	<tbody>
										<tr class="media-list comments-list m-bot-50 clearlist">
											<td width="80px" height="100px">
						                      	<div>
						                      	<c:if test="${cafeList.reviewList[0].userGender eq 'M'}">
						                      	<img width=70; height=80; class="media-object comment-avatar" src="/resources/images/blog/review/damda/man.png" alt="" />
						                        </c:if>	
						                       	<c:if test="${cafeList.reviewList[0].userGender eq 'F'}">
						                      	<img width=70; height=80; class="media-object comment-avatar" src="/resources/images/blog/review/damda/woman.png" alt="" />
						                        </c:if>
						                        </div>
						                        <div style="font-size:small; text-align:center"><c:out value="${cafeList.reviewList[0].userId}" /></div>
					                      	</td>
					                      	<td>
						                      	<div style="font-size:medium; margin-bottom: 5px; color:#4397cf;"><c:out value="${cafeList.reviewList[0].bbsTitle}" /></div>
						                      	<div style="font-size:x-small; margin-bottom: 5px; color:black;"><c:out value="${cafeList.reviewList[0].regDate}" /></div>
						                        <div>
						                        	<c:if test="${cafeList.reviewList[0].bbsStar == 1.0}">
													<div class="star_rating">
														<a href="#" class="on">★</a>
													    <a href="#" >★</a>
													    <a href="#" >★</a>
													    <a href="#">★</a>
													    <a href="#">★</a>
													</div>
													</c:if>
													<c:if test="${cafeList.reviewList[0].bbsStar == 2.0}">
													<div class="star_rating">
														<a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" >★</a>
													    <a href="#">★</a>
													    <a href="#">★</a>
													</div>
													</c:if>
													<c:if test="${cafeList.reviewList[0].bbsStar == 3.0}">
													<div class="star_rating">
														<a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#">★</a>
													    <a href="#">★</a>
													</div>
													</c:if>
													<c:if test="${cafeList.reviewList[0].bbsStar == 4.0}">
													<div class="star_rating">
														<a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#">★</a>
													</div>
													</c:if>
													<c:if test="${cafeList.reviewList[0].bbsStar == 5.0}">
													<div class="star_rating">
														<a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													    <a href="#" class="on">★</a>
													</div>
													</c:if>
						                        </div>
						                      	<div class="ellipsis2"><c:out value="${cafeList.reviewList[0].bbsContent}" /></div>
					                      	</td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:if>
						</div>
						<div class="text-center" style="width:510PX; height:130PX;">
							<br/>
							<button type="button" id="btnDetail${cafeList.cafeNum}" class="btn btn-main text-center" onClick="fn_detail('${cafeList.cafeNum}')">자세히 보기</button>
							<c:if test="${user.userClass eq 'N'}">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" id="btnReg${cafeList.cafeNum}" class="btn btn-main text-center" onClick="fn_rsrv('${cafeList.cafeNum}')">예약하기</button>
							</c:if>
						</div>
					</div>
					
				</c:forEach>
			</c:if>
					
<%-- <c:if test="${!empty reviewList}">
	<c:forEach var="cafe" items="${reviewList}" varStatus="status">
		<!-- 카페 한잔 -->
		<div class="col-md-6" align="center">
			<div class="content" style="border:4px solid #4397cf; width:510PX; height:530PX;">
			
			
				<c:if test="${cafe.cafeNum eq 'A0000001'}">
				<img src="/resources/images/shop/category/hanzan/hanzan.png" width="500" height="400" alt="" />
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000002'}">
				<img src="/resources/images/shop/category/donut/donut.png" width="500" height="400" alt="" />
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000003'}">
				<img src="/resources/images/shop/category/noname/noname.png" width="500" height="400" alt="" />
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000004'}">
				<img src="/resources/images/shop/category/damda/damda.png" width="500" height="400" alt="" />
				</c:if>
				<div>
				<table class="table">
                  	<tbody>
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
		                      	<div style="font-size:medium; margin-bottom: 5px; color:#4397cf;"><c:out value="${cafe.bbsTitle}" /></div>
		                      	<div style="font-size:x-small; margin-bottom: 5px; color:black;"><c:out value="${cafe.regDate}" /></div>
		                        <div>
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
		                      	<div class="ellipsis2"><c:out value="${cafe.bbsContent}" /></div>
	                      	</td>
						</tr>
					</tbody>
				</table>
			</div>	
			</div>	    
			<div class="text-center" style="width:510PX; height:50PX;">
				<br/>
				<c:if test="${cafe.cafeNum eq 'A0000001'}">
					<button type="button" id="btnDetailHanzan" class="btn btn-main text-center">자세히 보기</button>
					<c:if test="${user.userClass eq 'N'}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="btnRegHanzan" class="btn btn-main text-center">예약하기</button>
					</c:if>
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000002'}">
					<button type="button" id="btnDetailDonut" class="btn btn-main text-center">자세히 보기</button>
					<c:if test="${user.userClass eq 'N'}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="btnRegDonut" class="btn btn-main text-center">예약하기</button>
					</c:if>
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000003'}">
					<button type="button" id="btnDetailNoname" class="btn btn-main text-center">자세히 보기</button>
					<c:if test="${user.userClass eq 'N'}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="btnRegNoname" class="btn btn-main text-center">예약하기</button>
					</c:if>	
				</c:if>
				<c:if test="${cafe.cafeNum eq 'A0000004'}">
					<button type="button" id="btnDetailDamda" class="btn btn-main text-center">자세히 보기</button>
					<c:if test="${user.userClass eq 'N'}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="btnRegDamda" class="btn btn-main text-center">예약하기</button>
					</c:if>
				</c:if>
				
			</div>
			<br/><br/><br/><br/>
		</div>
	</c:forEach>
</c:if>	 --%>

		
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>