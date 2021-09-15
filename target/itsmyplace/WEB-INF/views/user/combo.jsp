<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<script type="text/javascript">

$(document).ready(function() {

	$("#btnReg").on("click", function() {
		fn_Reg();
	}
});
	
	
function fn_Reg()
{	
	$.ajax({
	      type: "POST",
	      url: "/areaSelect",
	      data: {
	         areaNum: $("#areaNum").val(),
	         areaName: $("#areaName").val(),
	      },
	      datatype: "JSON",
	      beforeSend : function (xhr){
	         xhr.setRequestHeader("AJAX","true");
	      },
	      success:function(response){
	         if(response.code == 0)
	         {
	        	 alert(areaNum);
	        	 alert(areaName);

	         }
	         else if(response.code == 100)
	         {
	         }
	         else if(response.code == 400)
	         {
	         }
	         else if(response.code == 500)
	         {
	         }
	         else
	         {
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
	<button type="button" id="btnReg">버튼</button>
	<select name="areaNum" onchange="fn_Reg()" id="areaNum">
		<option value="전체">전체</option>
		<option value="002">서울</option>
		<option value="051">부산</option>
		<option value="053">대구</option>
		<option value="032">인천</option>
		<option value="062">광주</option>
		<option value="042">대전</option>
		<option value="052">울산</option>
		<option value="031">경기</option>
		<option value="033">강원</option>
		<option value="043">충북</option>
		<option value="041">충남</option>
		<option value="063">전북</option>
		<option value="061">전남</option>
		<option value="054">경북</option>
		<option value="055">경남</option>
		<option value="064">제주</option>
	</select>

</body>
</html>