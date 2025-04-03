<!-- deleteAncProc.jsp -->
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
  	String[] delIds = request.getParameterValues("ancIds");
	String grade = (String)session.getAttribute("grade");

  	if (delIds != null) {
    	AncMgr mgr = new AncMgr();
    	for (String idStr : delIds) {
      	int anc_id = Integer.parseInt(idStr);
      	mgr.deleteAnc(anc_id, grade);
    	}
  	}
  	response.sendRedirect("anc.jsp");
%>
