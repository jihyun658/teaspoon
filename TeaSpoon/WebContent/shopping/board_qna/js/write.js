
function writeSave() {
 	var form = document.writeForm;
	
	if(!form.writer.value) {
	  alert("작성자를 입력하십시요.");
	  form.writer.focus();
	  return false;
	}
	if(!form.subject.value) {
	  alert("제목을 입력하십시요.");
	  form.subject.focus();
	  return false;
	}
	if(!form.content.value) {
	  alert("내용을 입력하십시요.");
	  form.content.focus();
	  return false;
	}
	if(!form.passwd.value) {
	  alert(" 비밀번호를 입력하십시요.");
	  form.passwd.focus();
	  return false;
	}
 }