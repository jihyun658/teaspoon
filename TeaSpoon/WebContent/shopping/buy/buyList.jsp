<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<style>
	.container {margin: 0 auto; text-align: center; color:#333;}
	a {text-decoration: none; color: #333;}
	h3{margin:50px; text-align: center;}
	table {width: 1000px; margin: 0 auto; border-collapse: collapse;}
	tr:first-child {height: 40px;}
	th {border-top:1px solid #aaa;border-bottom: 1px solid #aaa; font-size: 0.8em;}
	.noItems {padding:50px;}
	td:first-child{width: 30px;}
	td {border-bottom: 1px dotted #ccc; padding: 20px 10px; vertical-align: middle;}
	td img {width:100px; height: 100px; object-fit: contain;}
	td span {margin:5px; font-size: 0.8em; text-decoration: line-through; color: #888}
	input[type="number"] {width:50px; height: 20px; text-align: right; border:1px solid #aaa; border-radius: 5px;}
	input[type="number"]::-webkit-inner-spin-button, 
	input[type="number"]::-webkit-outer-spin-button {opacity: 1;}
	td:last-child input[type="button"] {display: block; margin:5px; width: 80px; height: 30px;}
	td:nth-child(3) {text-align: left;}
	tr:last-child { height: 50px;}
	.selectSubmit {text-align: left;}
	.selectSubmit input[type="submit"], .selectSubmit input[type="button"]{margin-left:10px; height: 30px; width: 100px; 
		background-color: white; border-radius: 5px; border:1px solid #aaa;}
	.selectSubmit input:hover,.change:hover {background-color: #888; color:#eee; cursor: pointer;}
	.refund {background-color: #E2AA87; border-radius: 5px; border: none; color: #fff;} 
	.change {background-color:white; border-radius: 5px; border: 1px solid #aaa; }
	.total { margin: 50px auto; line-height: 30px;}
	.total input{width: 200px; height: 40px; margin:20px 5px; background-color: #E2AA87; color:white; border:none; font-size: 1em}
	.total input:hover, .refund:hover {    
	color: #E2AA87;
    background-color: #FEF7E1;
    border: 2px solid #E2AA87; font-weight: bold}
    .result {text-align: center; margin: 20px; line-height: 30px;}
    .result div {width: 100px; height: 100px; border-radius: 50px; background: #eee; display: inline-block; line-height: 100px; font-size: small; font-weight: bold}
</style>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
// 각 구매에 대한 상품 1건씩을 저장한 리스트
BuyDBBean buyPro = BuyDBBean.getInstance();
List<HashMap<String,String>> buyList = buyPro.getBuyList(id);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
DecimalFormat df = new DecimalFormat("#,###");

int readyCount = 0;
int deliveryCompleted =0;
int refund = 0;
for(HashMap<String,String> buy : buyList) { 
Date buy_date = new SimpleDateFormat("yyyy-MM-dd").parse(buy.get("buy_date"));
if(buy.get("delivery_state").equals("상품준비중")) readyCount++;
if(buy.get("delivery_state").equals("배송완료")) deliveryCompleted++;
if(buy.get("delivery_state").equals("취소/반품")) refund++;
}
%>

<div id="container">
<h3>구매 내역</h3>
<div class="result">
<div>
	상품 준비중
	<span><%=readyCount %></span>		
</div>
<div>
	배송완료
	<span><%=deliveryCompleted %></span>		
</div>
<div>
	취소/반품
	<span><%=refund %></span>		
</div>
</div>
<table>
	<tr>
		<th colspan="2">상품정보</th>
		<th>주문금액</th>
		<th>주문일</th>
		<th>진행 상태</th>
		<th></th>
	</tr>
	<%for(HashMap<String,String> buy : buyList) { 
	Date buy_date = new SimpleDateFormat("yyyy-MM-dd").parse(buy.get("buy_date"));
	%>
	<tr>
		<td><a href="buyIdList.jsp?buy_id=<%=buy.get("buy_id")%>"><img src="../../image_tea/<%=buy.get("product_image") %>"></a></td>
		<td><a href="buyIdList.jsp?buy_id=<%=buy.get("buy_id")%>"><%=buy.get("buy_id") %><br><%=buy.get("product_title") %>외 <%=buy.get("et")%>건</a></td>
		<td><%=buy.get("total_price") %>원</td>
		<td><%=sdf.format(buy_date) %></td>
		<td><%=buy.get("delivery_state") %></td>
		<td><input type="button" class="refund" value="반품요청"><input type="button" class="change" value="배송지 변경"></td>
	</tr>
	<%} %>
</table>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>