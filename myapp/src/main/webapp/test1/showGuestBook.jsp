<!-- showGuestBook.jsp -->
<%@page import="guestbook.CommentBean"%>
<%@page import="guestbook.GuestBookBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr" />
<jsp:useBean id="cmgr" class="guestbook.CommentMgr" />
<%
String id = (String) session.getAttribute("idKey");
if (id == null) {
	// 로그인 안된 상태이기 때문에 현재의 url 가지고 login.jsp로 간다
	StringBuffer url = request.getRequestURL();
	// out.print(url);
	response.sendRedirect("login.jsp?url=" + url);
}
%>
<!DOCTYPE html>
<html>
<title>GuestBook</title>
<script type="text/javascript">
	function delFn(num) {
		document.delFrm.num.value = num;
		document.delFrm.action = "deleteGuestBook.jsp";
		document.delFrm.submit();
	}

	function updateFn(num) {
		url = "updateGuestBook.jsp?num=" + num;
		window.open(url, "GuestBook Update", "width=540, height=300");
	}

	function commentFn(frm) {
		if (frm.comment.value == "") {
			alert("댓글을 입력하세요");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	
	function cdelFn(cnum){
		document.delFrm.cnum.value = cnum;
		document.delFrm.flag.value="delete";
		document.delFrm.action="commentProc.jsp";
		document.delFrm.submit();
	}
	
	function disFn(num){
		// alert(num);
		var v = "cmt"+num; // cmt17
		var e = document.getElementById(v);
		if(e.style.display=='none')
			e.style.display='block'; // 보임
		else
			e.style.display='none'; // 안 보임
	}

</script>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#996600">
	<div align="center">
		<%@include file="postGuestBook.jsp"%>
		<table width="520" cellspacing="0" cellpadding="3">
			<tr bgcolor="#F5F5F5">
				<td><b><%=login.getName()%></b></td>
				<td align="right"><a href="logout.jsp">로그아웃</a></b></td>
			</tr>
		</table>
		<!-- GuestBook List Start -->
		<%
		Vector<GuestBookBean> vlist = mgr.listGuestBook(id, login.getGrade());
		// out.print(vlist.size());
		if (vlist.isEmpty()) {
		%>

		<table width="520" cellspacing="0" cellpadding="7">
			<tr>
				<td>등록된 글이 없습니다.</td>
			</tr>
		</table>

		<%
		} else {
		for (int i = 0; i < vlist.size(); i++) {
			// 방명록 글
			GuestBookBean bean = vlist.get(i);
			// 글쓴이 정보
			JoinBean writer = mgr.getJoin(bean.getId());
		%>
		<table width="520" border="1" bordercolor="#000000" cellspacing="0"
			cellpadding="0">
			<tr>
				<td>
					<table bgcolor="#F5F5F5">
						<tr>
							<td width="225">NO : <%=vlist.size() - i%>
							</td>
							<td width="225"><img src="img/face.bmp" border="0" alt="이름">
								"> <%=writer.getName()%></td>
							<td width="150" align="center">
								<%
								if (writer.getHp() == null || writer.getHp().equals("")) {
								%> 홈페이지가 없네요. <%
								} else {
								%> "> <%
								}
								%>
							</td>
						</tr>
						<tr>
							<td colspan="3"><%=bean.getContents()%></td>
						</tr>
						<tr>
							<td>IP : <%=bean.getIp()%></td>
							<td><%=bean.getRegdate() + " " + bean.getRegtime()%></td>
							<td>
								<!-- 본인 : 수정, 삭제. 관리자 : 삭제, 비밀글 여부 --> <%
 // 로그인과 글쓴이가 같다면
 boolean chk = login.getId().equals(writer.getId());
 if (chk || login.getGrade().equals("1") /*관리자*/) {
 	if (chk) {
 %> <a href="javascript:updateFn('<%=bean.getNum()%>')">[수정]</a> <%
 } //if 2
 %> <a href="javascript:delFn('<%=bean.getNum()%>')">[삭제]</a> <%-- <a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>)">[삭제]</a>  --%>
								<%
								} // if 1
								%> <%=bean.getSecret().equals("1") ? "비밀글" : ""%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!-- Comment List Start -->
		<div id = "cmt<%=bean.getNum()%>" style = "display: none">
			<%
			Vector<CommentBean> cvlist = cmgr.listComment(bean.getNum());
			// out.print(cvlist.size());
			if (!cvlist.isEmpty()) {
			%>
			<table width="500" bgcolor="#F5F5F5">
				<%
				for (int j = 0; j < cvlist.size(); j++) {
					CommentBean cbean = cvlist.get(j);
				%>
				<tr>
					<td>
						<table width="500">
							<tr>
								<td><b><%=cbean.getCid()%></b>	</td>
									<td align="right">
									<!-- 로그인과 댓글 글쓴이가 같거나 또는 관리자라면 -->
									<% 
										boolean chk2 = login.getId().equals(cbean.getCid());
										if(chk2||login.getGrade().equals("1")){ %>
											<a href="#" onclick="javascript:cdelFn('<%=cbean.getCnum()%>')">[삭제]</a>
									<% } %>			
									</td>
							</tr>
							<tr>
								<td colspan="2"><%=cbean.getComment()%></td>
							</tr>
							<tr>
								<td><%=cbean.getCip()%></td>
								<td align="right"><%=cbean.getCregDate()%></td>
							</tr>
						</table>
						<hr>
					</td>
				</tr>
				<%
				} // --for(comment)
				%>
			</table>
			<%
			} // --if(comment)
			%>
		</div>
		<!-- Comment List End -->
		<table width = "500">
			<tr>
				<td>
					<button onclick="disFn('<%=bean.getNum()%>')">댓글<%=cvlist.isEmpty()?"":cvlist.size() %></button>
				</td>
			</tr>
		</table>
		
		<!-- Comment Form Start -->
		<form name="cFrm" method="post" action="commentProc.jsp">
			<table>
				<tr>
					<td><textarea placeholder="댓글입력..." name="comment" rows="2"
							cols="65" maxlength="1000"></textarea></td>
					<td><input type="button" value="댓글"
						onclick="commentFn(this.form)"> <input type="hidden"
						name="flag" value="insert"> <!-- 방명록 글번호 --> <input
						type="hidden" name="num" value="<%=bean.getNum()%>"> <!-- 로그인 id -->
						<input type="hidden" name="cid" value="<%=login.getId()%>">
						<!-- 댓글 입력 ip 주소 --> <input type="hidden" name="cip"
						value="<%=request.getRemoteAddr()%>"></td>
				</tr>
			</table>
		</form>
		<!-- Comment Form End -->
		<%
		} // for 문
		} //  if-else 문
		%>


		<!-- GuestBook List End -->
		<form name="delFrm" method="post">
			<input type="hidden" name="num"> 
			<input type="hidden" name="cnum"> 
			<input type="hidden" name="flag">
		</form>

	</div>
</body>
</html>