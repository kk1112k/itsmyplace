<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

input[type="checkbox"] {
    width:0px;
    margin-right:18px;
}

input[type="checkbox"]:before {
    content: "";
    width: 15px;
    height: 15px;
    display: inline-block;
    vertical-align:middle;
    text-align: center;
    box-shadow: inset 0px 2px 3px 0px rgba(0, 0, 0, .3), 0px 1px 0px 0px rgba(255, 255, 255, .8);
    background-color:#ccc;
}

input[type="checkbox"]:checked:before {
    background-color:Green;
    font-size: 15px;
}

input[type="checkbox"]:disabled:before {
	background-color: Red;
	font-size: 15px;
}


</style>

<script type="text/javascript">
function getCheckboxValue(event)  {
	const query = 'input[name="seats"]:checked';
	const selectedEls = document.querySelectorAll(query);
	  // 선택된 목록에서 value 찾기
	  var arrr = new Array();
	  selectedEls.forEach((el) => {
	  	arrr.push(el.value);
	  });
	  
	  // 출력
	  document.getElementById('result').innerText = "실시간으로 선택되는 좌석 : " + arrr;
	}
	
$(document).ready(function() {
	
	$("#btnReserve").on("click", function() {
		var arr = new Array();
		$("input:checkbox[name=seats]:checked").each(function(){
			arr.push($(this).val());
			document.getElementById('sss').innerText = "선택한 좌석 alert : " + arr;
		});
		alert("선택하신 좌석은 " + arr + " 입니다.");
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
   
   <div class="d-flex">
      <div style="width:50%;">
         <h2>게시판</h2>
      </div>
    </div>
    <div class="seatStructure">
	    <table id="seatsBlock">
			    <tr>
				    <td><input type="checkbox" name = "seats" id = "1" class="seats" value="1" onclick='getCheckboxValue()' /></td>
				    <td><input type="checkbox" name = "seats" id = "2" class="seats" value="2" onclick='getCheckboxValue()' /></td>
				    <td><input type="checkbox" name = "seats" id = "3" class="seats" value="3" onclick='getCheckboxValue()' /></td>
				    <td><input type="checkbox" name = "seats" id = "4" class="seats" value="4" onclick='getCheckboxValue()' /></td>
				    <td><input type="checkbox" name = "seats" id = "5" class="seats" value="5" onclick='getCheckboxValue()' /></td>
			  	</tr>
	  	 </table>
   	 </div>
   	 <br/><br/>
   <button type="button" id="btnReserve" class="btn btn-secondary mb-3">좌석체크하기</button>
   <br/>
   <h2 id="sss"></h2>
   <br/>
   <h2 id="result"></h2>
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="hiBbsSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
</div>
</body>
</html>