<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메뉴</title>
<link href="etc/managerMain.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");

if(managerId == null || managerId == ""){
	response.sendRedirect("logon/managerL	oginForm.jsp");
}
%>
    <div class="container">
        <p><span><%=managerId %></span> 님이 상품관리 중입니다.</p>
        <div class="menu">
            <label for="mainMenu1"><span>상품관리</span></label>
            <input type="radio" id="mainMenu1" class="button" name="menu">
            
            <div class="submenu">
                <a href="productProcess/productRegisterForm.jsp">상품 등록</a>
                <a href="productProcess/productList.jsp?product_category=all">상품 전체 보기 <span class="update">(수정/삭제)</span></a>
            </div>
            <label for="mainMenu2"><span>주문관리</span></label>
            <input type="radio" id="mainMenu2" class="button" name="menu">
            <div class="submenu">
                <a href="#">전체 주문 조회</a>
            </div>
            <label for="mainMenu3"><span>회원관리</span></label>
            <input type="radio" id="mainMenu3" class="button" name="menu">
            <div class="submenu">
                <a href="#">전체 회원 조회</a>
            </div>
            <label><a href="logon/managerLogout.jsp">Logout</a></label>
        </div>
    </div>
</body>
</html>