<%@ page contentType="text/html; charset=UTF-8" language="java" import="jspproject.*, java.sql.*" %>
<%
String user_id = (String)session.getAttribute("user_id");
int timer_id = 1; // 기본 Timer1

if(user_id != null){
    UserTimerMgr mgr = new UserTimerMgr();
    timer_id = mgr.getTimerId(user_id);
}

String pageName = "Timer" + timer_id + ".jsp";
%>

<jsp:include page="<%= pageName %>" />
