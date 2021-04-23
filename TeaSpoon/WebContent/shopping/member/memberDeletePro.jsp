<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 처리</title>
</head>
<body>
<%
// 1. 사용자 정보 추출
String id = (String)session.getAttribute("id");
String passwd = request.getParameter("passwd");

// 2. DB 연동 처리
MemberDBBean memberPro = MemberDBBean.getInstance();
int check = memberPro.userCheck(id, passwd);
System.out.print(check);
if(check != 1) {
	%>
	<script>
		alert('비밀번호가 일치하지 않습니다.');
		history.back();
	</script>
	<%
} else {memberPro.deleteMember(id, passwd);

// 3. 아이디 세션 삭제
session.removeAttribute("id");}
%>
	<script>
		alert('탈퇴되었습니다.');
		location="../shop/shopMain.jsp";
	</script>
</body>
</html>