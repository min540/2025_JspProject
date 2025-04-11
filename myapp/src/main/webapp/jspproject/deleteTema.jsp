<%@ page contentType="application/json;charset=UTF-8" %>
<%@ page import="jspproject.TemaMgr" %>
<%
    String temaIdParam = request.getParameter("tema_id");

    try {
        if (temaIdParam != null) {
            int tema_id = Integer.parseInt(temaIdParam);
            TemaMgr mgr = new TemaMgr();
            mgr.deleteTema(tema_id); // void 메서드 그대로 호출
            out.print("{\"status\":\"ok\"}");
        } else {
            out.print("{\"status\":\"fail\", \"message\":\"No tema_id provided\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"status\":\"fail\", \"message\":\"Exception occurred\"}");
    }
%>
