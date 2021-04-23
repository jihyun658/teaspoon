<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

MemberDBBean memberPro = MemberDBBean.getInstance();
memberPro.userCheck(id, passwd);
int check = memberPro.userCheck(id, passwd);

// 아이디가 있고, 비밀번호 일치하면, x=1
// 아이디가 있고 비밀번호 일치하지 않으면 x=0
// 아이디가 없다면, x=-1

if(check == 1){ // 아이디와 비밀번호 모두 일치
	session.setAttribute("id", id);// 장바구니, 주문에서 활용
	response.sendRedirect("../shop/shopMain.jsp");
} else if(check == 0){ // 아이디 일치, 비밀번호 불일치
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
} else if(check == -1){ // 아이디 불일치
	out.print("<script>alert('아이디가 일치하지 않습니다.'); history.back();</script>");
}
%>
</body>
</html>