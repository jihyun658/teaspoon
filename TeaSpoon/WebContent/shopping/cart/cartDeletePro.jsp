<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.CartDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제</title>
</head>
<body>
<%
String buyer = (String)session.getAttribute("id");
String[] product_ids = request.getParameterValues("cart");
int product_id=0;
String productId = request.getParameter("product_id");
CartDBBean dbPro = CartDBBean.getInstance();

if(product_ids == null){
	if(productId == null){
		response.sendRedirect("cartList.jsp");
	} else if(productId.equals("-1")){
		dbPro.deleteCart(buyer);	
	} else if(productId != null){
		product_id = Integer.parseInt(productId); 
		dbPro.deleteCart(product_id, buyer);
	}
} else {
	for (int i=0; i<product_ids.length; i++){
		product_id = Integer.parseInt(product_ids[i]);	
		dbPro.deleteCart(product_id, buyer);
	}
}


%>
<script>
	location="cartList.jsp"
</script>

</body>
</html>