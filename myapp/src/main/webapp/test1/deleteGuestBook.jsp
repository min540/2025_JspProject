<!-- deleteGuestBook.jsp -->
<%@page import="guestbook.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "guestbook.GuestBookMgr"/>
<%
		String method = request.getMethod();
		int num = 0;		
		if(request.getParameter("num")!=null && 
				method.equalsIgnoreCase("POST")){
			num = MUtil.parseInt(request, "num");
			mgr.deleteGuestBook(num);
		}
		response.sendRedirect("showGuestBook.jsp");
%>