<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*" %>
<%@ page import="shop.manager.*, shop.member.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매</title>
<style>
	.container {margin: 0 auto; text-align: center; color:#333; width: 1000px;}
	a {text-decoration: none; color: #333;}
	h3{margin:50px;}
	
	/* 상품  */
	.product{margin: 30px auto;}
	.product table {width: 1000px; margin: 0 auto; border-collapse: collapse;}
	.product tr:first-child {height: 40px;}
	.product th {border-top:1px solid #aaa;border-bottom: 1px solid #aaa; font-size: 0.8em;}
	.noItems {padding:50px;}
	.product td:first-child{width: 30px;}
	.product td {border-bottom: 1px dotted #ccc; padding: 20px 10px; vertical-align: middle;}
	.product td img {width:100px; height: 100px;  object-fit: contain;}
	.product td span {margin:5px; font-size: 0.8em; text-decoration: line-through; color: #888}
	.product input[type="number"] {width:50px; height: 20px; text-align: right; border:1px solid #aaa; border-radius: 5px;}
	.product input[type="number"]::-webkit-inner-spin-button, 
	.product input[type="number"]::-webkit-outer-spin-button {opacity: 1;}
	.product td:last-child input[type="button"] {display: block; margin:5px; width: 80px; height: 30px;}
	.product td:nth-child(2) {text-align: left;}
	.product tr:last-child { height: 50px;}
	.total {margin: 50px;}
    
    /* 주문자, 배송지 */
    .destination {width:600px; margin : 50px;}
    .destination th{font-size: 0.8em; width: 100px;}
    .destination th, .destination td{}
    .destination table {width: 500px; margin:30px auto;text-align: left}
    .destination td{padding: 10px;}
    .destination input[type=text], textarea{border: none; border-bottom: 1px solid #ccc; height: 25px; width: 400px}
    #address1 { width:330px; margin-bottom:20px;}
    input[type="button"] {background: white; height: 30px; border: 1px solid #aaa; font-size: 0.7em;
	border-radius:5px; cursor: pointer; color:#333}
	input[type="text"]::placeholder { color: #ccc;} 
	input[type="button"]:hover {background-color: #888; color:#fff;}
	
	/* 결제창 */
    .pay{float: right; width: 250px; height: 500px; padding: 30px 20px; background: #eee;}
    .pay h4{margin-top:60px;}
    .pay p{margin: 50px auto;}
    .pay span {font-size: 1.5em; font-weight: bold; color:darkblue}
    .pay select {height: 30px; margin:20px 0px; border:none; outline:none; background: #eee}
    .pay input[type="text"] {height: 30px; width: 200px; margin-bottom: 50px}
    .pay input[type="submit"]{width: 200px; height: 40px; margin:20px 5px; background-color: #E2AA87; color:white; border:none; font-size: 1em}
	.pay input[type="submit"]:hover{    
	color: #E2AA87;
    background-color: #FEF7E1;
    border: 2px solid #E2AA87; font-weight: bold}
    label{font-size:0.8em;}
    
    .bottom {clear: both; margin: 0 auto; width: 1000px; height:30px;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>

//주소 찾기 기능 - 다음 라이브러리 활용
function searchAddress() {
	var form = document.buyForm;
	
	new daum.Postcode({
		oncomplete:function(data) {
			form.address1.value = data.address;
		}
	}).open();
}

// 주문자 정보 복사
function copyInfo(){
	var check = document.getElementById("check");
	var getName = document.getElementById("getName").innerHTML;
	var getTel = document.getElementById("getTel").innerHTML;
	var getAddress = document.getElementById("getAddress").value;
	if(check.checked){
		document.getElementById("delivery_name").value = getName;
		document.getElementById("delivery_tel").value = getTel;
		document.getElementById("address").value = getAddress;
	} else {
		document.getElementById("delivery_name").value = "";
		document.getElementById("delivery_tel").value = "";
		document.getElementById("address").value = "";
	}
}

// 결제 정보 변경

function category_change(option){
    var com;
    var com1 = ["KB국민카드", "신한카드", "하나카드", "롯데카드", "BC카드", "NH농협카드", "삼성카드", "현대카드"];
    var com2 = ["네이버페이", "삼성페이", "카카오페이", "휴대폰 결제"];
    var com3 = ["산업은행", "기업은행", "국민은행", "KEB하나은행", "수협", "농협", "신한은행", "우리은행", "SC제일은행", "한국씨티은행", "부산은행",  "경남은행", "대구은행", "광주은행", "전북은행", "제주은행"];
    var payment_com = document.getElementById("payment_com");

    var payment;
    var pay1 = ["일시불", "1개월(무)", "2개월(무)", "3개월(무)", "6개월", "12개월"];
    var pay2 = ["351-1080-2690-88", "061700-04-235005"];
    var payment_no = document.getElementById("payment_no");
    
    payment_com.options.length = 0;
    payment_no.options.length = 0;
    
    if(option.value == "card") {
    	com = com1;
    	payment = pay1;
    } else if(option.value == "smartPay") {
    	com = com2;
    	payment = "-";
    } else if(option.value == "bank") {
    	com = com3;
    	payment = pay2;
    }
    
    for (var i=0; i<com.length; i++) {
           var option = document.createElement("option");
           option.value = com[i] ;
           option.innerHTML = com[i];
           payment_com.appendChild(option);
    }
    for (var i=0; i<payment.length; i++) {
        var option = document.createElement("option");
        option.value = payment[i];
        option.innerHTML = payment[i];
        payment_no.appendChild(option);
    }
}

// 결제 확인
function checkForm(){
	var payment_option = document.getElementById("payment_option").value;
	var payment_com = document.getElementById("payment_com").value;
	var payment_no = document.getElementById("payment_no").value;
	var total_price = document.getElementById("total_price").value;
	var check = confirm(payment_option + ' : ' + payment_com + "("+ payment_no +")\n" + total_price + "원 결제 하시겠습니까?");
	if(check){
		return true;
	} else {return false}
}

</script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<%
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
} else {


//아이디 세션이 있을 때 (로그인을 했을 때)
int product_id = Integer.parseInt(request.getParameter("product_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int count = 1;

//회원 DB 처리
MemberDBBean memberPro = MemberDBBean.getInstance();
MemberDataBean member = memberPro.getMember(id);

// 장바구니 DB처리
CartDBBean cartPro = CartDBBean.getInstance();
List<CartListDataBean> cartList = null; // 장바구니 목록

if(product_id == -1){ // 장바구니 전체 구매
	cartList = cartPro.getCartList(id);
	count = cartPro.getCartListCount(id);
} else if(product_id == 0){ // 선택 상품 구매
	cartList = new ArrayList<CartListDataBean>();
	String[] product_ids = request.getParameterValues("cart");
	if(product_ids == null) { // 선택된 상품이 없을 때 %>
		<script>alert('상품을 선택해 주세요.'); history.back();</script>
	<%} else { // 선택된 상품이 있을 때
	for (int i=0; i<product_ids.length; i++){
		product_id = Integer.parseInt(product_ids[i]);	
		cartList.add(cartPro.getCart(product_id, id));
	}}
} else { // 바로구매, 상품 하나 구매
	cartList = new ArrayList<CartListDataBean>();
	CartListDataBean cart = cartPro.getCart(product_id, id);
	cart.setBuy_count(buy_count);
	cartList.add(cart);
}
DecimalFormat df = new DecimalFormat("#,###");
int total_count = 0;
int total_price = 0;
%>
<div class="container">
<form action="buyPro.jsp" method="post" name="buyForm" onsubmit="return checkForm()">
<div class="product">
	<h3>주문 / 결제</h3>
	<table>
		<tr>
			<th colspan="2">상품정보</th>
			<th>판매금액</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
		<%
			for(CartListDataBean cart : cartList) {
				int p_id = (int)cart.getProduct_id();
				String product_image = "../../image_tea/" + cart.getImage();
				String product_title = (String)cart.getTitle();
				int buy_price = (int)cart.getBuy_price();
				buy_count = (int)cart.getBuy_count();
				int product_price = (int)cart.getBuy_price();
				total_count += buy_count;
				total_price += buy_price * buy_count;
			%>
			<tr>
				<td><a href="../shop/productContent.jsp?product_id=<%=p_id %>"><img src="<%=product_image %>"></a></td>
				<td>
				<input type="hidden" name="product_id" value="<%=p_id %>">			
				<input type="hidden" name="buy_count" value="<%=buy_count %>">			
				<a href="../shop/productContent.jsp?product_id=<%=p_id %>"><%=product_title %></a>
				</td>
				<td><span><%=df.format(product_price) %></span><%=df.format(buy_price) %>원</td>
				<td><%=buy_count %></td>
				<td><%=df.format(buy_price*buy_count) %>원</td>
			</tr>
		<%}%>
	</table>
		<div class="total">
			<p>총 수량 : <%=count %>종 (<%=total_count %>개)
			결제 금액 : <%=df.format(total_price) %>원</p>
		</div>
<hr color=#eee width=10px>
</div>
<div class="pay">
	<h4>결제 정보</h4>
	<p>결제금액 : <span><%=df.format(total_price) %></span>원</p>
	<input type="hidden" name="total_price" id="total_price" value="<%=total_price%>">
	<label><input type="radio" name="payment_option" id="payment_option" value="card" onclick="category_change(this)" checked>카드결제</label>
	<label><input type="radio" name="payment_option" value="smartPay" onclick="category_change(this)">간편결제</label>
	<label><input type="radio" name="payment_option" value="bank" onclick="category_change(this)">무통장 입금</label><br>
	<select name="payment_com" id="payment_com">
		<option value="KB국민카드">KB국민카드</option>
		<option value="신한카드">신한카드</option>
		<option value="하나카드">하나카드</option>
		<option value="롯데카드">롯데카드</option>
		<option value="BC카드">BC카드</option>
		<option value="NH농협카드">NH농협카드</option>
		<option value="삼성카드">삼성카드</option>
		<option value="현대카드">현대카드</option>
	</select>
	<select name="payment_no" id="payment_no">
		<option value="일시불">일시불</option>
		<option value="1개월(무)">1개월(무)</option>
		<option value="2개월(무)">2개월(무)</option>
		<option value="3개월(무)">3개월(무)</option>
		<option value="6개월">6개월</option>
		<option value="12개월">12개월</option>
	</select><br>
	<input type="submit" value="결제하기">
</div>
<div class="destination">
	<h4>주문자 정보</h4>
	<input type="hidden" value="<%=member.getAddress() %>" id="getAddress">
	<table>
		<tr>
			<th>이름</th>
			<td id="getName"><%=member.getName() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td id="getTel"><%=member.getTel() %></td>
		</tr>
	</table>
	<h4>배송지 정보</h4>
	<input type="hidden" name="buyer" value="<%=id %>">
	<label><input type="radio" id="check" checked name="check" onclick="copyInfo()">주문자와 같음</label>
	<label><input type="radio" name="check" onclick="copyInfo()">신규 배송지</label>
	<table>
		<tr>
			<th>받는사람</th>
			<td><input type="text" name="delivery_name" id="delivery_name" value="<%=member.getName()%>"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="delivery_tel" id="delivery_tel" value="<%=member.getTel()%>"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" id="address1" name="address1" maxlength="100" size="20" readonly>
			<input type="button" value="주소 찾기" class="btnAddress" onclick="searchAddress()" >
			<input type="text" name="address2" maxlength="100" size="30" placeholder="상세주소" id="address" value="<%=member.getAddress()%>" required >
			</td>
		</tr>
		<tr>
			<th>배송 메세지</th>
			<td><textarea></textarea></td>
		</tr>
	</table>
</div>
</form>
</div>
<div class="bottom">
</div> <%} %>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>