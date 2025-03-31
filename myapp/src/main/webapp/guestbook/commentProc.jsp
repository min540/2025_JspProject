<!-- commentProc.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cmgr" class = "guestbook.CommentMgr" />
<jsp:useBean id="cbean" class = "guestbook.CommentBean"/>
<jsp:setProperty property = "*" name = "cbean"/>

<%
		String flag = request.getParameter("flag");
		String method = request.getMethod();
		
		if(method.equalsIgnoreCase("POST")){
			if(flag.equalsIgnoreCase("insert")){
				cmgr.insertComment(cbean);
			} else if (flag.equalsIgnoreCase("delete")){
				cmgr.deleteComment(cbean.getCnum());
			}
		}
		response.sendRedirect("showGuestBook.jsp");
%>