<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.CartDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 수량 변경</title>
</head>
<body>
<%
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int cart_id = Integer.parseInt(request.getParameter("cart_id"));

CartDBBean dbPro = CartDBBean.getInstance();
dbPro.updateCart(cart_id, buy_count);
%>
<script>
	location='cartList.jsp';
</script>
</body>
</html>