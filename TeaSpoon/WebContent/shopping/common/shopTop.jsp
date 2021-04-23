<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<link href="../etc/shopTop.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String id = (String)session.getAttribute("id");
%>
    <header>
        <div class="top1">
            <ul>
            	<%if(id == null) { %>
                <li><a href="../member/memberLoginForm.jsp">로그인</a></li>
                <li><a href="../member/memberJoinForm.jsp">회원가입</a></li>
            	<%} else{%>
            	<li><a href="../member/memberUpdateForm.jsp"><span><%=id %></span>님 환영 합니다.</a></li>
                <li><a href="../member/memberLogout.jsp">로그아웃</a></li>
                <li><a href="../member/myPage.jsp">마이페이지</a></li>
            	<%} %>
                <li><a href="../cart/cartList.jsp">장바구니</a></li>
                <li><a href="../buy/buyList.jsp">주문조회</a></li>
            </ul>
        </div>
        <div class="top2">
           <a href="../shop/shopMain.jsp"><img src="../etc/teaspoon.png" alt=""></a> 
        </div>
        <div class="top3">
            <ul>
                <li><a href="../shop/shopAll.jsp?product_category=all">전체보기</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1">Tea</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=101">블랜딩차</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=102">홍차</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=103">허브티</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=104">꽃차</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=105">전통차</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=106">백차/발효차</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=2">다구</a></li>
                <li><a href="../shop/shopAll.jsp?product_category=3">기타</a></li>
            </ul>
            <div class="searchBox">
            <form action="../shop/searchProduct.jsp">
            <input type="text" name="search" class="search" placeholder="검색">
            <input type="submit" value="">
            </form>
            </div>
        </div>
		<div class="topmenu">
			<div class="submenu"><a href="../shop/shopAll.jsp?product_category=1">Tea</a>
			<ul>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=101">블랜딩차</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=102">홍차</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=103">허브티</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=104">꽃차</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=105">전통차</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=1&product_kind=106">백차/발효차</a></li>
			</ul>
			</div>
			<div class="submenu">&nbsp;
			<ul>
				<li><a href="../shop/shopAll.jsp?product_type=티백">티백</a></li>
				<li><a href="../shop/shopAll.jsp?product_type=잎차">잎차</a></li>
				<li><a href="../shop/shopAll.jsp?product_type=파우더">파우더</a></li>
				<li><a href="../shop/shopAll.jsp?product_type=기타">기타</a></li>
			</ul>
			</div>
			<div class="submenu"><a href="../shop/shopAll.jsp?product_category=2">다구</a>
			<ul>
				<li><a href="../shop/shopAll.jsp?product_category=2&product_kind=201">티컵/티팟</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=2&product_kind=202">티백주머니</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=2&product_kind=203">인퓨저</a></li>
	            <li><a href="../shop/shopAll.jsp?product_category=2&product_kind=204">보틀/텀블러</a></li>
			</ul></div>
			<div class="submenu"><a href="../shop/shopAll.jsp?product_category=3">기타</a>
				<ul>
					<li><a href="../shop/shopAll.jsp?product_category=3&product_kind=301">선물 꽃</a></li>
					<li><a href="../shop/shopAll.jsp?product_category=3&product_kind=302">쿠키 / 디저트</a></li>
					<li><a href="../shop/shopAll.jsp?product_category=3&product_kind=303">기타</a></li>
				</ul>
			<div>
				공지사항
				<ul>
					<li><a href="../board_qna/listBoardQna.jsp">QnA</a></li>
				</ul>
			</div>
			</div>
		</div>
    </header>
</body>
</html>