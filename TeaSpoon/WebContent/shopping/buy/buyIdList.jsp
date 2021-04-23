<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 상세 내역</title>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
String buy_id = request.getParameter("buy_id");

// Buy DB 연동
BuyDBBean buyPro = BuyDBBean.getInstance();
List<BuyInfoDataBean> buyInfoList = buyPro.getBuyInfo(buy_id);
int count = 0;
DecimalFormat df = new DecimalFormat("#,###");
%>
<div id="container">
<h2>구매 상세 내역</h2>
<table>
	<tr>
		<th colspan="2">상품정보</th>
		<th>구매금액</th>
		<th>구매 수량</th>
		<th></th>
	</tr>
	<%for(BuyInfoDataBean buy : buyInfoList) { 
		String path = "../../image_tea/" + buy.getProduct_image();
	%>
	<tr>
		<td align="center"><img src="<%=path %>" height="100px"></td>
		<td class="title"><%=buy_id%><br><%=buy.getProduct_title() %></td>
		<td class="price" align="right"><%=df.format(buy.getBuy_price()) %></td>
		<td align="center"><%=buy.getBuy_count() %></td>
		<td> <input type="button" value="리뷰쓰기" onclick="location='../shop/productContent.jsp?product_id=<%=buy.getProduct_id() %>#review'"></td>
	</tr>
	<%} %>
</table>
<%
BuyDataBean buy = buyPro.getBuy(buy_id);
%>
<div class="pay">
	<h4>결제 정보</h4>
	<p>결제금액 : <span><%=df.format(buy.getTotal_price()) %></span>원</p>
	<p>결제방법 : <span><%=buy.getPayment_option() %></span></p>
	<p><%=buy.getPayment_com() %>(<%=buy.getPayment_no() %>)</p>
</div>
<div class="">
	<h4>배송 정보</h4>
	<p>
	<%=buy.getDelivery_name() %></p>
	<p><%=buy.getDelivery_tel() %></p>
	<p><%=buy.getDelivery_address() %></p>
</div>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>