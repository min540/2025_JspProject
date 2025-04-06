<!-- deleteAncProc.jsp -->
<%@page import="java.util.Arrays"%>
<%@page import="jspproject.UserBean"%>
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
  	String[] delIds = request.getParameterValues("ancIds");
	UserBean user = (UserBean) session.getAttribute("user");
	String grade = null;
	
	if (user == null) {
	    response.sendRedirect("login.jsp");
	    return;
	}
	
	grade = String.valueOf(user.getGrade());

  	if (delIds != null) {
    	AncMgr mgr = new AncMgr();
    	for (String idStr : delIds) {
      	int anc_id = Integer.parseInt(idStr);
      	mgr.deleteAnc(anc_id, grade);
    	}
  	}
  	response.sendRedirect("anc.jsp");
%>
