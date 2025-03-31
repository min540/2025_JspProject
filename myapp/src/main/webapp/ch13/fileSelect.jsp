<!-- fileSelect.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<!-- enctype : 파일 업로드 시 인코딩 타입 세팅 -->
<!-- multipart/form-data : 데이터를 여러 개로 나누어서 전송하는 방식 -->
<form method = "post" enctype="multipart/form-data" action = "viewPage.jsp">
	user : <input name = "user" value = "홍길동"><br>
	title : <input name = "title" value = "파일업로드"><br>
	file : <input type = "file" name = "myfile" value = "UPLOAD"><br>
	<input type = "submit" value = "파일전송">
</form>