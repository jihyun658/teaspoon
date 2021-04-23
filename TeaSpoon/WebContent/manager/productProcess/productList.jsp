<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 확인</title>
<link href="etc/productList.css" rel="stylesheet" type="text/css">
<script src="etc/productList.js"></script>
</head>
<body onload="kind_change()">

<div class="container">
<%
// 페이징 처리를 위한 변수 지정
int pageSize = 5; // 한 페이지에서 보여줄 글수
String pageNum = request.getParameter("pageNum"); // 현재 페이지 번호
if(pageNum == null) pageNum = "1";
int currentPage = Integer.parseInt(pageNum); // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
int endRow = currentPage * pageSize;			 // 페이지의 마지막 글


String managerId = (String)session.getAttribute("managerId");

// 관리자 로그인이 되어 있지않을 때 (세션이 없을 때);
if(managerId == null || managerId == ""){
	response.sendRedirect("../logon/managerLoginForm.jsp");
}

// 관리자 로그인 되어 있을 때 (세션 있을 때)
String product_category = request.getParameter("product_category");
String product_kind = request.getParameter("product_kind");
DecimalFormat df = new DecimalFormat("#,###,###.####");
int number = 0;
int count = 0;
	
ProductDBBean dbPro = ProductDBBean.getInstance();
List<ProductDataBean> productList = null;

count = dbPro.getProductCount(product_category, "product_category"); // 전체 상품수 또는 분류별 상품수

// cagegoryName = cagegory와 kind를 한글로 변환
String categoryName = "";
if(count > 0) { // 등록된 상품이 있다면
	if(product_kind == null || product_kind == "" || product_kind.equals("null")){
		productList = dbPro.getProducts(product_category, "product_category", null, startRow, pageSize);
		categoryName = dbPro.getCategoryName(product_category); 
	} else {
		productList = dbPro.getProductKinds(product_kind, "product_category", startRow, pageSize);
		count = dbPro.getProductKindCount(product_kind);
		categoryName = dbPro.getKindName(product_kind);
	}
}

// 전체 글수 역순 번호 - 현재 페이지마다 달라서 매번 계산
number = count - (currentPage - 1) * pageSize;

%>
  	<p class="form_title">상품 목록</p>
    <div class="top">
    	<a href="../managerMain.jsp">&lt;&lt; 관리자 메인으로 이동</a>
    	<div class="categoryList">
	    	<span><%=categoryName %>의 목록 : <%=count %>개</span>
	    	<select name="product_category" id="product_category" onchange="category_change(this)">
	        	<option <%if (product_category.equals("all")){ %>selected<%} %> value="all">전체</option>
	            <option <%if (product_category.equals("1")){ %>selected<%} %> value="1">차</option>
	            <option <%if (product_category.equals("2")){ %>selected<%} %> value="2">다구</option>
	            <option <%if (product_category.equals("3")){ %>selected<%} %> value="3">기타</option>
	        </select>
	        <select name="product_kind" id="product_kind">
	            <option selected disabled hidden></option>
	        </select>
	        <input type="button" onclick="goList()" value="이동">
    	</div>
    </div>
    <table class="content_table">
        <tr>
            <th width="50px">번호</th>
            <th width="150px">제품 이미지</th>
            <th width="150px">카테고리</th>
            <th width="400px">상품 설명</th>
            <th width="50px">용량</th>
            <th width="100px">가격</th>
            <th width="50px">재고</th>
            <th width="50px">할인율</th>
            <th width="100px">상품 등록일</th>
            <th width="100px">수정/삭제</th>
        </tr>
        <%
        if(count == 0) { 
    		out.print("<tr><td colspan='10' align='center'>등록된 분류의 상품이 없습니다.</td></tr>");
    	} else {
    		for(int i=0; i<productList.size(); i++) {
			ProductDataBean product = productList.get(i);
			String file = "../../image_tea/" + product.getProduct_image1();
			int p_id = product.getProduct_id();
			String p_category = product.getProduct_category();
			String p_kind = product.getProduct_kind();
			
			String p_categoryName = dbPro.getCategoryName(p_category);
			String p_kindName = dbPro.getKindName(p_kind);
		%>
            <tr>
                <td><%=number-- %></td>
                <td><img src="<%=file%>" alt="<%=product.getProduct_image1()%>" width="130px"></td>
                <td><%=p_categoryName %> &gt <%=p_kindName %></td>
                <td class="explain">
                    <p><span>상품명 : </span><%=product.getProduct_title() %></p>
                    <p><span>브랜드 : </span><%=product.getProduct_brand() %></p>
                    <p><span>타입 : </span><%=product.getProduct_type() %></p>
                    <p><span>원산지 : </span><%=product.getProduct_origin() %></p>
                    <p><span>원재료 및 함량 : </span><%= product.getProduct_material() %></p>
                </td>
                <% 
                if(product.getProduct_type() == null || product.getProduct_type() == "")
                	out.print("<td>" + product.getProduct_weight() + "개</td>");
                else if(product.getProduct_type().equals("잎차") || product.getProduct_type().equals("파우더"))
                	out.print("<td>" + product.getProduct_weight() + "g</td>");
                else
                	out.print("<td>" + product.getProduct_weight() + "개</td>");
       			%>
                <td><%=product.getProduct_price() %>원</td>
                <td><%=product.getProduct_count()%>개</td>
                <td><%=product.getDiscount_rate() %>%</td>
                <td><%=product.getReg_date() %></td>
                <td>
				<a href="productUpdateForm.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>&product_category=<%=p_category%>&product_type=<%=product.getProduct_type()%>">수정</a>
				 / 
				<a onclick="goDelete(<%=p_category %>,<%=p_kind%>,<%=p_id %>)">삭제</a>
				</td>
            </tr>
            <%}}%>
        </table>
        <input class="insertBtn" type="button" value="상품 등록" onclick="location='productRegisterForm.jsp'">
 		<div id="paging">
	<%
	// 페이징 처리(paging)
	/*
	pageCount : 전체 페이지수
	currentPage : 현재 페이지
	startPage : 현재 페이지 아래쪽에 페이징되는 첫번째 글
	endPage : 현재 페이지 아래쪽에 페이징되는 마지막 글
	pageBlock : 페이징 처리에서 보여지는 페이지 블럭의 수
	count : 전체 게시글
	(전체게시글 / 페이지 사이즈 (10))올림 = 전체 페이지수 
	첫번째 페이지 숫자 = 1
	현재 페이지를 10으로 나누어서 딱 떨어지지 않으면 첫번째 페이지 숫자 = 현재페이지의 10의 자리수 + 1 떨어지면 
	*/
	if(count > 0){
		
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1;
		
		if (currentPage % 10 != 0) startPage = (int) (currentPage / 10) * 10 + 1;
		else startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		
		if (endPage > pageCount) endPage = pageCount;
		if (currentPage > 1) { %>
			<div class="pageBox">
				<a href="productList.jsp?product_category=<%=product_category %>&product_kind=<%=product_kind %>&pageNum=<%=currentPage-1 %>">&lt</a>
			</div>
		<%} 
		for(int i=startPage; i<=endPage; i++){
			if(i == currentPage) out.print("<div class='selectPage'>" + i + "</div>");
			else { %>
			<div class="pageBox">
				<a href="productList.jsp?product_category=<%=product_category %>&product_kind=<%=product_kind %>&pageNum=<%=i %>"><%=i %></a>
			</div>
			<%}
		}
		if (currentPage < pageCount) { %>
			<div class="pageBox">
				<a href="productList.jsp?product_category=<%=product_category %>&product_kind=<%=product_kind %>&pageNum=<%=currentPage+1 %>">&gt</a>
			</div>
	<%}
	}
	%>
	</div>
</div>
</body>
</html>