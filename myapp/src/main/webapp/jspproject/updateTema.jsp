<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="jspproject.TemaMgr" %>
<%
    TemaMgr mgr = new TemaMgr();
    try {
        mgr.updateTema(request);
        out.print("ok");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("error");
    }
%>
