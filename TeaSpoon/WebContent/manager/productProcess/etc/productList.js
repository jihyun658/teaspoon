function category_change(select){
    var kind;
    var kind_1 = ["전체", "블랜딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효자", "녹차", "기타"];
    var kind_2 = ["전체", "티컵/티팟", "티백주머니", "인퓨저", "보틀/텀블러", "기타" ];
    var kind_3 = ["전체", "기타상품"];
    var product_kind = document.getElementById("product_kind");

    product_kind.options.length = 0;
        
    if(select.value == 1) {
        kind = kind_1;
    } else if(select.value == 2) {
        kind = kind_2;
    } else if(select.value == 3) {
        kind = kind_3;
    }
        
    for (var i=1; i<kind.length; i++) {
        var option = document.createElement("option");
        option.value = select.value + "0" + (i) ;
        option.innerHTML = kind[i];
        product_kind.appendChild(option);
    }

}

function goList(){
	var category = document.getElementById("product_category").value;
	var kind = document.getElementById("product_kind").value;
	
	location.href="productList.jsp?product_category=" + category + "&product_kind=" + kind;
}

function goDelete(category, kind, id) {
	result = confirm('정말 삭제하시겠습니까?');
	if(result)
		location.href="productDeletePro.jsp?product_category=" + category + "&product_kind=" + kind + "&product_id=" + id;
}

function getParameter(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function kind_change() {
	var kind;
	var p_kind = getParameter("product_kind");
    var kind_1 = ["전체", "블랜딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효자", "녹차", "기타"];
    var kind_2 = ["전체", "티컵/티팟", "티백주머니", "인퓨저", "보틀/텀블러", "기타" ];
    var kind_3 = ["전체", "기타상품"];
    var product_kind = document.getElementById("product_kind");
	var p_category = getParameter("product_category");

    product_kind.options.length = 0;
        
    if(p_category == 1) {
        kind = kind_1;
    } else if(p_category == 2) {
        kind = kind_2;
    } else if(p_category == 3) {
        kind = kind_3;
    } else {kind = "-"}

    for (var i=1; i<kind.length; i++) {
        var option = document.createElement("option");
        option.value = p_category + "0" + (i) ;
        option.innerHTML = kind[i];
        product_kind.appendChild(option);
    }

	
	selected(p_kind);
}

function selected(kind){
	var product_kind = document.getElementById("product_kind");
	for(var i=0; i<product_kind.length; i++){
	if(product_kind[i].value == kind) {
		product_kind[i].selected = true;
		}
	}
}
