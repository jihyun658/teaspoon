
function category_change(select){
    var kind;
    var kind_1 = ["블랜딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효자", "녹차", "기타"];
    var kind_2 = ["티컵/티팟", "티백주머니", "인퓨저", "보틀/텀블러", "기타" ];
    var kind_3 = ["기타상품"];
    var product_kind = document.getElementById("product_kind");

    var type;
    var type_1 = ["티백", "잎차", "파우더", "기타"];
    var type_2 = ["-"];
    var product_type = document.getElementById("product_type");
    
    product_kind.options.length = 0;
       product_type.options.length = 0;
    
    if(select.value == 1) {
        kind = kind_1;
        type = type_1;
    } else if(select.value == 2) {
        kind = kind_2;
        type = type_2;
    } else if(select.value == 3) {
        kind = kind_3;
        type = type_2;
    }
    
    for (var i=0; i<kind.length; i++) {
           var option = document.createElement("option");
           option.value = select.value + "0" + (i+1) ;
           option.innerHTML = kind[i];
           product_kind.appendChild(option);
    }
    for (var i=0; i<type.length; i++) {
        var option = document.createElement("option");
        option.value = type[i];
        option.innerHTML = type[i];
        product_type.appendChild(option);
    }
}

function capacity_change(type) {
    var capacity = document.getElementById("capacity");
    var kind = document.getElementById("product_kind");
    if (type.value=="잎차" || type.value=="파우더"){
        capacity.innerText = "g"
    } else {
        capacity.innerText = "ea"
    }
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
    var kind_1 = ["블랜딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효자", "녹차", "기타"];
    var kind_2 = ["티컵/티팟", "티백주머니", "인퓨저", "보틀/텀블러", "기타" ];
    var kind_3 = ["기타상품"];
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

    for (var i=0; i<kind.length; i++) {
        var option = document.createElement("option");
        option.value = p_category + "0" + (i+1) ;
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