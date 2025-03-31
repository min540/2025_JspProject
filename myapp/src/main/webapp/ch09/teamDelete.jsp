<!-- teamDelete.jsp -->
<%@page import="ch09.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch09.TeamMgr"/>
<%
		int num = 0;
		if(request.getParameter("num")!=null){
			num = MUtil.parseInt(request, "num");
			mgr.deleteTeam(num);
		}
		response.sendRedirect("teamList.jsp");
%>