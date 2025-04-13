<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="jspproject.TemaMgr" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // 세션에서 user_id 가져오기
    String user_id = (String) session.getAttribute("user_id");

    if (user_id != null && !user_id.isEmpty()) {
        TemaMgr temaMgr = new TemaMgr();
        temaMgr.resetAllTemaOnOff(user_id); // 모든 테마 off

        // 응답 성공 메시지
        out.print("ok");
    } else {
        out.print("error: no session user_id");
    }
%>
