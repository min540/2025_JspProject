<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="jspproject.UserTimerMgr" %>
<%@ page import="jspproject.UserTimerBean" %>

<%
    request.setCharacterEncoding("UTF-8");
    String user_id = request.getParameter("user_id");

    UserTimerMgr mgr = new UserTimerMgr();
    UserTimerBean bean = mgr.getUserTimer(user_id);

    String result = "{";
    result += "\"sessionTime\": " + bean.getTimer_session() + ",";
    result += "\"breakTime\": " + bean.getTimer_break() + ",";
    result += "\"timerLoc\": \"" + bean.getTimer_loc() + "\"";
    result += "}";

    out.print(result);
%>
