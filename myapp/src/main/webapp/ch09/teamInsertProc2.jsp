<!--  teamInsertProc2.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch09.TeamMgr"/>
<jsp:useBean id="bean" class="ch09.TeamBean"/>
<jsp:setProperty property="*" name="bean"/>

<%
    // DB 저장
    mgr.insertTeam(bean);

    // 저장 후 teamList.jsp로 리디렉트하여 데이터 확인
    response.sendRedirect("teamList.jsp");
    // response.sendRedirect("teamInsert.html");
%>
