<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration, java.sql.Timestamp" %>
<%@ page import="shop.manager.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

MultipartRequest imageUp = null;
String realFolder = ""; // 실제 경로
String[] fileName = new String[4];   // 파일 이름
int n = 0;

//String saveFolder = "/imageFile"; // 파일이 저장되는(업로드되는) 폴더
String encType = "utf-8";
int maxSize = 1024 * 1024 * 2; // 업로드 파일의 크기 제한, 2MB

realFolder = "D:/human/jsp_study/workspace_jsp/TeaSpoon/WebContent/image_tea";
	
try {
	// 데이터 전달 객체(파일 정보를 포함)
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		fileName[n++] =  imageUp.getFilesystemName(name);
	}
} catch(Exception e) {
	e.printStackTrace();
}
int product_id = Integer.parseInt(imageUp.getParameter("product_id"));
String product_category = imageUp.getParameter("product_category");
String product_kind = imageUp.getParameter("product_kind");
String product_title = imageUp.getParameter("product_title");
String product_brand = imageUp.getParameter("product_brand");
String product_origin = imageUp.getParameter("product_origin");
String product_material = imageUp.getParameter("product_material");
String product_type = imageUp.getParameter("product_type");
String product_weight = imageUp.getParameter("product_weight");
int product_price = Integer.parseInt(imageUp.getParameter("product_price"));
int product_count = Integer.parseInt(imageUp.getParameter("product_count"));
int discount_rate = Integer.parseInt(imageUp.getParameter("discount_rate"));
String product_content = imageUp.getParameter("product_content");

// ProductDataBean 객체 생성 및 삽입
ProductDataBean product = new ProductDataBean();
product.setProduct_id(product_id);
product.setProduct_category(product_category);
product.setProduct_kind(product_kind);
product.setProduct_title(product_title);
product.setProduct_brand(product_brand);
product.setProduct_origin(product_origin);
product.setProduct_material(product_material);
product.setProduct_type(product_type);
product.setProduct_weight(product_weight);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setDiscount_rate(discount_rate);
product.setProduct_content(product_content);
product.setProduct_image1(fileName[0]);
product.setProduct_image2(fileName[1]);
product.setProduct_image3(fileName[2]);
product.setProduct_image4(fileName[3]);
product.setReg_date(new Timestamp(System.currentTimeMillis()));

ProductDBBean productPro = ProductDBBean.getInstance();
productPro.updateProduct(product);

response.sendRedirect("productList.jsp?product_category=" + product_category + "&product_kind=" + product_kind);
%>
</body>
</html>