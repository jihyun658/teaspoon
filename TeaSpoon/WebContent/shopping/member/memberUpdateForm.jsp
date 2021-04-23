<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link href="etc/memberJoin.css" rel="stylesheet" type="text/css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>

//주소 찾기 기능 - 다음 라이브러리 활용
function searchAddress() {
	var form = document.memberJoinForm;
	
	new daum.Postcode({
		oncomplete:function(data) {
			form.address1.value = data.address;
		}
	}).open();
}

//중복 아이디 체크
function checkId() {
	var id = document.querySelecter("#id").value;
}

// 비밀번호 일치확인
function checkPwd(){
    if(document.getElementById('pw1').value !='' && document.getElementById('pw2').value!=''){
        if(document.getElementById('pw1').value==document.getElementById('pw2').value){
            document.getElementById('checkPasswd').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('checkPasswd').style.color='blue';
        }
        else{
            document.getElementById('checkPasswd').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('checkPasswd').style.color='red';
        }
    }
}
</script>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
<section>
<%
//아이디 세션이 없을 때
if(id == null || id.equals("")) {
	response.sendRedirect("../shop/shopMain.jsp");
}
//아이디 세션이 있을 떼
MemberDBBean memberPro = MemberDBBean.getInstance();
MemberDataBean member = memberPro.getMember(id);
%>
<form action="memberUpdatePro.jsp" method="post" name="memberJoinForm">
<input type="hidden" name="id" id="id" value="<%=member.getId()%>">
        <p class="form_title">회원 정보 수정</p>
        <hr color="#EDD8BB" size="1px">
<table>
	<tr>
		<th width="25%">아이디</th>
		<td width="75%"><%=member.getId() %>
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="passwd" id="pw1" maxlength="16" size="30" required onchange="checkPwd()"></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" id="pw2" maxlength="16" size="30" required onchange="checkPwd()"><br>
		<div id="checkPasswd"></div>
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="name" maxlength="20" size="30" value="<%=member.getName() %>" required ></td>
	</tr>
	<tr>
		<th>주소</th>
		<td>
		<input type="text" name="address1" maxlength="100" size="20" readonly>
		<input type="button" value="주소 찾기" class="btnAddress" onclick="searchAddress()" >
		<input type="text" name="address2" maxlength="100" size="30" value="<%=member.getAddress() %>" placeholder="상세주소" required >
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><input type="text" name="tel" maxlength="20" size="30" value="<%=member.getTel() %>" required ></td>
	</tr>
</table>
  <hr color="#EDD8BB" size="1px">
	<div class="submit">
			<input type="submit" value="회원수정">	
	</div>
</form>
</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>