
function deleteSave() {
 	var form = document.deleteForm;
     
	if(!form.passwd.value) {
	  alert(" 비밀번호를 입력하십시요.");
	  form.passwd.focus();
	  return false;
	}
	
 }
