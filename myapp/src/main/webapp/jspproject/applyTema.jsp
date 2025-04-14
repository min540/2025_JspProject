<%@ page import="jspproject.TemaMgr" %>
<%
    int tema_id = Integer.parseInt(request.getParameter("tema_id"));
    TemaMgr mgr = new TemaMgr();

    // 먼저 모든 테마 off
    mgr.setAllTemaOff((String)session.getAttribute("user_id"));

    // 선택한 테마 on
    boolean success = mgr.setTemaOn(tema_id);

    if (success) {
        out.print("ok");
    } else {
        out.print("fail");
    }
%>
