<!-- fupload.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
		frm = document.forms[0];
		if (frm.upFile.value == "") { // 파일이 선택되지 않았을 경우
			alert("파일을 선택하세요");
			return;
		}
		frm.submit();
	}
</script>
</head>
<body>
	<div align="center">
		<h2>File Upload</h2>
		<form method="post" action="fuploadProc.jsp?flag=update"
			enctype="multipart/form-data">
			<table border="1">
				<tr>
					<td>파일선택</td>
					<td><input type="file" name="upFile"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="파일업로드"
						onclick="check()"></td>
				</tr>
			</table>
		</form>
		<a href="flist.jsp">파일리스트</a>
	</div>
</body>
</html>