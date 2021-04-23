<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.*, shop.manager.*" %>
<%@ page import="java.util.*, java.text.*, java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

// 변수 받아 오기
String payment_option = request.getParameter("payment_option"); // 결제 방법
String payment_com = request.getParameter("payment_com"); // 결제 은행, 카드사
String payment_no = request.getParameter("payment_no"); // 할부개월, 계좌
String buyer = (String)session.getAttribute("id"); // 회원 아이디
String delivery_name = request.getParameter("delivery_name"); // 수취인
String delivery_tel = request.getParameter("delivery_tel"); // 수취인 전화번호
String delivery_address = request.getParameter("address1") + request.getParameter("address2"); // 배송지
String[] product_ids = request.getParameterValues("product_id");
String[] buy_counts = request.getParameterValues("buy_count");
int total_price = Integer.parseInt(request.getParameter("total_price"));

// 구매 아이디 생성
// 자바로 중복되지 않는 고유한 키값 생성 -> buy_id(구매번호)로 사용
// buy_id : 날짜8자리 + 고유한 키값 12자리 -> 20자리의 값으로 생성
// uuid를 문자열로 생성(12자리)
UUID uuid = UUID.randomUUID();
String uuid2 = uuid.toString().replace("-", "").substring(0,6);

// 구매 날짜 8자리
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Calendar date = Calendar.getInstance();
String buy_id = sdf.format(date.getTime()) + uuid2;



// 구매 할 상품 - 구매 상세 buyInfo
ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = null;
List<BuyInfoDataBean> buyInfoList = new ArrayList<BuyInfoDataBean>();
BuyInfoDataBean buyInfo = new BuyInfoDataBean();
for(int i=0; i<product_ids.length; i++){
	buyInfo = new BuyInfoDataBean();
	product = productPro.getProduct(Integer.parseInt(product_ids[i])); // 구매할 상품 정보 가져 오기
	buyInfo.setBuy_id(buy_id);
	buyInfo.setProduct_id(Integer.parseInt(product_ids[i]));
	buyInfo.setProduct_title(product.getProduct_title());
	buyInfo.setProduct_image(product.getProduct_image1());
	buyInfo.setProduct_price(product.getProduct_price());
	int buy_price = product.getProduct_price() - (product.getProduct_price() * product.getDiscount_rate()/100);
	buyInfo.setBuy_price(buy_price);
	buyInfo.setBuy_count(Integer.parseInt(buy_counts[i]));
	buyInfoList.add(buyInfo);
}

// 구매 정보
BuyDataBean buy = new BuyDataBean();
buy.setBuy_id(buy_id);
buy.setBuyer(buyer);
buy.setBuy_date(new Timestamp(System.currentTimeMillis()));
buy.setPayment_option(payment_option);
buy.setPayment_com(payment_com);
buy.setPayment_no(payment_no);
buy.setTotal_price(total_price);
buy.setDelivery_name(delivery_name);
buy.setDelivery_tel(delivery_tel);
buy.setDelivery_address(delivery_address);
buy.setDelivery_state("상품준비중");

BuyDBBean buyPro = BuyDBBean.getInstance();
int x = buyPro.insertBuyList(buy, buyInfoList);

if(x != 0){%>
 <script>alert('구매완료 되었습니다.'); location = 'buyList.jsp';</script>
<%} else {%>
 <script>alert('구매에 실패 하였습니다.'); history.back();</script>

<%} %>
</body>
</html>