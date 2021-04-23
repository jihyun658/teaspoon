<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link rel="stylesheet" href="etc/productRegisterForm.css">
<script src="etc/productRegisterForm.js"></script>
</head>
<body onload="kind_change()">
	<%
	String managerId = (String)session.getAttribute("managerId");
	
	// 세션이 없을 때(관리자 로그인을 하지 않았을 때)
	if(managerId == null || managerId.equals("")) { 
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} 
	
	// 세션이 있을 때(관리자 로그인을 했을 때)
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	String product_category = request.getParameter("product_category");
	String product_kind = request.getParameter("product_kind");
	String product_type = request.getParameter("product_type");
		
	ProductDBBean dbPro = ProductDBBean.getInstance();
	ProductDataBean product = dbPro.getProduct(product_id);
	%>
   <div class="container">
		<a class="go_managerMain" href="../managerMain.jsp">관리자 메인으로 이동</a>   
        <p class="form_title">상품수정</p>
        <hr color="#EDD8BB" size="1px">
        <form action="productUpdatePro.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="product_id" value="<%=product_id %>">
            <table>
                <tr>
                    <th>상품 종류</th>
                    <td><select name="product_category" id="product_category" onchange="category_change(this)">
                        <option selected disabled hidden="hidden">카테고리 선택</option>
                        <option value="1" <%if(product_category.equals("1")) { %>selected <%} %>>차</option>
                        <option value="2" <%if(product_category.equals("2")) {%>selected<%} %>>다구</option>
                        <option value="3" <%if(product_category.equals("3")) {%>selected<%} %>>기타</option>
                    </select>
                </tr>
                <tr><td></td><td>
                    <select name="product_kind" id="product_kind">
                        <option selected disabled hidden="hidden">-</option>
                    </select></td>
                </tr>
                <tr>
                    <th>제품명</th>
                    <td><input type="text" name="product_title" id="product_tile" value="<%=product.getProduct_title() %>" required></td>
                </tr>
                <tr>
                    <th>브랜드</th>
                    <td><input type="text" name="product_brand" id="product_brand" value="<%=product.getProduct_brand() %>" required></td>
                </tr>
                <tr>
                    <th>원산지</th>
                    <td><input type="text" name="product_origin" value="<%=product.getProduct_origin() %>" required></td>
                </tr>
                <tr>
                    <th>원재료 및 함량</th>
                    <td><input type="text" name="product_material" value="<%=product.getProduct_material() %>" required></td>
                </tr>
                <tr>
                    <th>상품 형태</th>
                    <td>
                        <select name="product_type" id="product_type" onchange="capacity_change(this)">
                            <option selected value="-">-</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>상품 용량</th>
                    <td><span class=number><input type="number" min="0" name="product_weight" value="<%=product.getProduct_weight() %>" required><span class="span" id="capacity">ea</span></span></td>         
                </tr>
                <tr>
                    <th>상품 가격</th>
                    <td><span class=number><input type="number" min="0" name="product_price" value="<%=product.getProduct_price() %>" required><span class="span">원</span></span></td>
                </tr>
                <tr>
                    <th>입고 수량</th>
                    <td><span class=number><input type="number" min="0" name="product_count" value="<%=product.getProduct_count() %>" required><span class="span">개</span></span></td>
                </tr>
                <tr>
                    <th>할인율</th>
                    <td><span class=number><input type="number" min="0" name="discount_rate" max="100" step="5" value="<%=product.getDiscount_rate() %>" required><span class="span">%</span></span></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="product_content" id="" cols="30" rows="4" required> <%=product.getProduct_title() %></textarea></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><input type="file" name="product_image" id="file" value="이미지 선택"><%=product.getProduct_image1() %><br>
                    <input type="file" name="product_image2" id="file" value="이미지 선택"><%=product.getProduct_image2() %><br>
                    <input type="file" name="product_image3" id="file" value="이미지 선택"><%=product.getProduct_image3() %></td>
                </tr>
                <tr>
                    <th>상세 이미지</th>
                    <td><input type="file" name="product_image4" id="file" value="이미지 선택"><%=product.getProduct_image4() %></td>
                </tr>
                <tr>
                    <td colspan="2" class="button">
                        <input type="reset" value="다시작성">
                        <input type="submit" value="상품수정">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>