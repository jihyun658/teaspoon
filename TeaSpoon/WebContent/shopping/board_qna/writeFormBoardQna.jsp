<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 폼</title>
<link href="css/writeForm.css" rel="stylesheet" type="text/css">
<script src="js/write.js"></script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<div id="container">
<%
//아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

//아이디 세션이 있을 때 (로그인을 했을 때)
String buy_id = request.getParameter("buy_id");

int num = 0, ref = 1, re_step = 0, re_level = 0;
String strV = "";

if(request.getParameter("num") != null) {
	num = Integer.parseInt(request.getParameter("num"));
	ref = Integer.parseInt(request.getParameter("ref"));
	re_step = Integer.parseInt(request.getParameter("re_step"));
	re_level = Integer.parseInt(request.getParameter("re_level"));
}
%>
<h3>글쓰기</h3>
<form action="writeProBoardQna.jsp" method="post" name="writeForm" onsubmit="return writeSave()">
<input type="hidden" name="num" value=<%=num %>>
<input type="hidden" name="member_id" value=<%=id %>>
<input type="hidden" name="ref" value=<%=ref %>>
<input type="hidden" name="re_step" value=<%=re_step %>>
<input type="hidden" name="re_level" value=<%=re_level %>>
<table>
	<tr>
		<th width="20%" align="center">이름</th>
		<td width="80%">
		<input type="text" size="10" maxlength="10" name="writer" id="writer" value="<%=id %>" readonly>
		</td>
	</tr>
	<tr>
		<th align="center">QnA 분류</th>
		<td>
		<select name="q_kind">
			<option value="상품">상품</option>
			<option value="배송">배송</option>
			<option value="결제">결제</option>
			<option value="반송">반송</option>
			<option value="서비스">서비스</option>
			<option value="기타">기타</option>
		</select>
		</td>
	</tr>
	<tr>
		<th align="center">제목</th>
		<td>
		<%
		if(request.getParameter("num") == null) strV = "";
		else strV="[답변] ";
		%>
		<input type="text" size="40" maxlength="50" name="subject" value="<%=strV %>">
		</td>
	</tr>
	<tr>
		<th align="center">내용</th>
		<td><textarea name="content" rows="13" cols="40"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="글쓰기" id="btn">
			<input type="reset" value="다시작성" id="btn">
			<input type="button" value="목록보기" id="btn" onclick="location='listBoardQna.jsp'">
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>