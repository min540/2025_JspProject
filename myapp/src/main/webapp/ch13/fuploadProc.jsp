<!-- fuploadProc.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch13.FileloadMgr"/>
<%
		// get 방식으로 보낸 값을 리턴
		String flag = request.getParameter("flag");
		mgr.uploadFile(request);
		response.sendRedirect("fupload.jsp");
		// response.sendRedirect("flist.jsp");
%>