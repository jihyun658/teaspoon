<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.ProductDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
ProductDBBean dbpro = ProductDBBean.getInstance();
int check = dbpro.managerCheck(id, passwd);

if (check == 1){
	session.setAttribute("managerId", id); // session 생성
	response.sendRedirect("../managerMain.jsp");
} else if(check == 0) {
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
} else if(check == -1) {
	out.print("<script>alert('입력하신 아이디는 존재하지 않습니다.'); history.go(-1);</script>");
}

%>
</body>
</html>