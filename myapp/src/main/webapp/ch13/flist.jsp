<!-- flist.jsp -->
<%@page import="ch13.MUtil"%>
<%@page import="ch13.FileloadBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch13.FileloadMgr" />
<%
Vector<FileloadBean> vlist = mgr.listFile();
// out.print(vlist.size());
%>

<!doctype html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function allChk() {
		f = document.frm;
		if (f.allCh.checked) { // 체크되면 true
			for (i = 0; i < f.fch.length; i++) {
				f.fch[i].checked = true;
			}
			f.btn.disabled = false; // 버튼 활성화
			f.btn.style.color = "blue";
		} else {
			for (let i = 0; i < f.fch.length; i++) {
				f.fch[i].checked = false;
			}
			f.btn.disabled = true; // 버튼 비활성화
			f.btn.style.color = "gray";
		}
	}

	function chk() {
		f = document.frm;
		for (i = 0; i < f.fch.length; i++) { // 'int' 제거 후 'let' 사용
			if (f.fch[i].checked) {
				f.btn.disabled = false; // 버튼 활성화
				f.btn.style.color = "blue";
				return; // 체크된 항목이 있으면 종료
			}
		}
		f.allCh.checked = false;
		f.btn.disabled = true; // 버튼 비활성화
		f.btn.style.color = "gray";
	}
	
	function down(upFile){
		document.downFrm.upFile.value = upFile;
		document.downFrm.submit();
	}
	
</script>
</head>
<body>
	<div align="center">
		<h2>File List</h2>
		<form name="frm" action="fdeleteProc.jsp">
			<table border="1" width="400">
				<tr align="center">
					<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
					<td width="30">번호</td>
					<td>파일명1</td>
					<td>파일명2</td>
					<td>파일크기</td>
				</tr>
				<%
				for (int i = 0; i < vlist.size(); i++) {
					FileloadBean bean = vlist.get(i);
					int num = bean.getNum();
					String upFile = bean.getUpFile();
					int size = bean.getSize();
				%>
				<tr align="center">
					<td><input type="checkbox" name="fch" onclick="chk()"
						value="<%=num%>"></td>
					<td><%=i + 1%></td>
					<td><a href="storage/<%=upFile%>" download><%=upFile%></a></td>
					<td><a href="javascript:down('<%=upFile%>')"><%=upFile%></a></td>
					<td><%=MUtil.monFormat(size)%>byte</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="5"><input type="submit" name="btn" value="DELETE"
						disabled></td>
				</tr>
			</table>
		</form>
		<p>
			<a href="fupload.jsp">입력폼</a>
		<form name="downFrm" method="post" action="fdownload.jsp">
			<input type="hidden" name="upFile">
		</form>
	</div>
</body>
</html>
