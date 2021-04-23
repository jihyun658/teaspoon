<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*" %>                    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
// 아이디 세션 확인 - 아이디 세션이 없다면 로그인 기능부터 실행하도록 설정
if(id == null || id.equals("") ){
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}
%>
<jsp:useBean id="cart" scope="page" class="shop.cart.CartDataBean">
	<jsp:setProperty name="cart" property="*"/>
</jsp:useBean>
<%
cart.setBuyer(id);
int product_id = cart.getProduct_id();
CartDBBean cartPro = CartDBBean.getInstance();
CartDataBean check = cartPro.checkCart(product_id, id);
int count = 0;
// 장바구니에 해당 상품이 있을 때(중복이 있을 때)
if (check != null){
	count = cart.getBuy_count() + check.getBuy_count();
%>
<script>
	var result = confirm('이미 장바구니에 있는 상품입니다.\n추가 하시겠습니까?');
	if(result == true) {
		location = "cartUpdatePro.jsp?buy_count=<%=count%>&cart_id=<%=check.getCart_id()%>"
	}
</script>
<% count = 0;
// 장바구니에 해당 상품이 없을 때(중복이 없을 때)
} else {
	count = cartPro.insertCart(cart);
}

//화면 이동
if(count != 0) { // 장바구니 추가 성공 %>
	<script>
		var result = confirm('장바구니에 추가하였습니다.\n 장바구니로 이동 하시겠습니까?');
		if(result) location='cartList.jsp';
		else history.back();
	</script>
<%} else if(count == 0) { // 장바구니 추가 실패
	out.print("<script>alert('장바구니 추가에 실패하였습니다.'); history.back();</script>");
}
%>
</body>
</html>