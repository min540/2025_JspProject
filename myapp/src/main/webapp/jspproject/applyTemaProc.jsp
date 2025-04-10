<%@ page import="jspproject.TemaMgr" %>
<%
    String userId = (String) session.getAttribute("id");
    int temaId = Integer.parseInt(request.getParameter("tema_id"));

    TemaMgr mgr = new TemaMgr();
    mgr.applyTema(userId, temaId);

    response.getWriter().write("ok");
%>
