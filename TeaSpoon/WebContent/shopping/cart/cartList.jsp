<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<style>
	.container {margin: 0 auto; text-align: center; color:#333;}
	a {text-decoration: none; color: #333;}
	h3{margin:50px;}
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
	.selectSubmit input:hover,.delButton:hover {background-color: #888; color:#eee; cursor: pointer;}
	.buyButton {background-color: #E2AA87; border-radius: 5px; border: none; color: #fff;} 
	.delButton {background-color:white; border-radius: 5px; border: 1px solid #aaa; }
	.total { margin: 50px auto; line-height: 30px;}
	.total input{width: 200px; height: 40px; margin:20px 5px; background-color: #E2AA87; color:white; border:none; font-size: 1em}
	.total input:hover, .buyButton:hover {    
	color: #E2AA87;
    background-color: #FEF7E1;
    border: 2px solid #E2AA87; font-weight: bold}
</style>
<script>
function selectAll(selectAll)  {
	  var checkboxes 
	       = document.getElementsByName('cart');
	  
	 for(var i=0; i<=checkboxes.length; i++){
	    checkboxes[i].checked = selectAll.checked;		  
	  } 
	}

function updateCart(cart_id, buy_count){
	location="cartUpdatePro.jsp?cart_id=" + cart_id + "&buy_count=" + buy_count.value; 
}

function noEnter(e) { 
    if(e.keyCode==13 && e.srcElement.type != 'textarea') 
    return false; 
} 
</script>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
<h3>장바구니 목록</h3>
<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
CartDBBean cartPro = CartDBBean.getInstance();
int count = cartPro.getCartListCount(id); // 장바구니 목록 갯수
List<CartListDataBean> cartList = cartPro.getCartList(id); // 장바구니 목록
DecimalFormat df = new DecimalFormat("#,###");
int total_count = 0;
int total_price = 0;
%>
<form action="../buy/buyForm.jsp" method="post" name="cartListForm" onkeydown="return noEnter(event)">
<table>
	<tr>
		<th><input type="checkbox" name="cart" value="selectAll" onclick='selectAll(this)'></th>
		<th colspan="2">상품정보</th>
		<th>판매금액</th>
		<th>수량</th>
		<th>합계</th>
		<th></th>
	</tr>
	<%if(count == 0) {%>
	<tr><td class="noItems" colspan="7">장바구니에 담기 상품이 없습니다.</td></tr>
	<%} else {
		for(CartListDataBean cart : cartList) {
			int product_id = (int)cart.getProduct_id();
			String product_image = "../../image_tea/" + cart.getImage();
			String product_title = (String)cart.getTitle();
			int buy_price = (int)cart.getBuy_price();
			int buy_count = (int)cart.getBuy_count();
			int product_price = (int)cart.getBuy_price();
			total_count += buy_count;
			total_price += buy_price * buy_count;
		%>
		<tr>
			<td><input type="checkbox" name="cart" value="<%=cart.getProduct_id() %>"></td>
			<td><a href="../shop/productContent.jsp?product_id=<%=product_id %>"><img src="<%=product_image %>"></a></td>
			<td><a href="../shop/productContent.jsp?product_id=<%=product_id %>"><%=product_title %></a></td>
			<td><span><%=df.format(product_price) %></span><%=df.format(buy_price) %>원</td>
			<td>
				<input type="number" name="buy_count" value="<%=buy_count %>" min=1 onchange="updateCart(<%=cart.getCart_id()%>,this)">
			</td>
			<td><%=df.format(buy_price*buy_count) %>원</td>
			<td>
			<input type="button" value="주문하기" class="buyButton" onclick="location='../buy/buyForm.jsp?product_id=<%=cart.getProduct_id() %>&buy_count=<%=buy_count%>'">
			<input type="button" value="삭제" class="delButton" onclick="location='cartDeletePro.jsp?product_id=<%=cart.getProduct_id() %>'">
			</td>
		</tr>
	<%}}%>
	<tr>
		<th><input type="checkbox" name="cart" value="selectAll" onclick='selectAll(this)'></th>
		<th colspan="2" class="selectSubmit">
			<input type="submit" value="선택상품 삭제" formaction="cartDeletePro.jsp">
			<input type="button" value="전체 삭제" onclick="location='cartDeletePro.jsp?product_id=-1'">
		</th>
		<th colspan="4"></th>
	</tr>
</table>
	<div class="total">
		<p>총수량 : <%=count %>종 (<%=total_count %>개)
		총금액 : <%=df.format(total_price) %>원</p>
		<input type="submit" value="전체 구매하기" formaction="../buy/buyForm.jsp?product_id=-1">
		<input type="submit" value="선택 상품 구매하기" formaction="../buy/buyForm.jsp?product_id=0">
	</div>
</form>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>