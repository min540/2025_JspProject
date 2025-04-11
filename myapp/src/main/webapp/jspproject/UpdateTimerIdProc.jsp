<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.UserTimerMgr" %>

<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");
	String timer_id_str = request.getParameter("timer_id");

	if(user_id == null || timer_id_str == null || timer_id_str.equals("")){
		out.print("파라미터 오류");
		return;
	}

	int timer_id = Integer.parseInt(timer_id_str);

	UserTimerMgr mgr = new UserTimerMgr();

	boolean result = mgr.updateTimerId(user_id, timer_id);

	if(result){
		out.print("ok");
	}else{
		out.print("fail");
	}
%>
