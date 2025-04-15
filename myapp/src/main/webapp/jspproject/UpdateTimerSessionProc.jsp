<!-- 사용자가 변경한 타이머 세션/휴식 시간 DB 업데이트 처리 로직 -->
<!-- 사용자가 변경한 타이머 위치값 업데이트 처리 로직 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.*, java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String user_id = request.getParameter("user_id");
	String sessionStr = request.getParameter("timer_session");
	String breakStr = request.getParameter("timer_break");
	String timer_loc = request.getParameter("timer_loc");   // 추가
	
	UserTimerMgr mgr = new UserTimerMgr();

	// 세션 / 브레이크 시간 업데이트
	if(user_id != null && sessionStr != null && breakStr != null 
		&& !sessionStr.equals("") && !breakStr.equals("")){

		int timer_session = Integer.parseInt(sessionStr);
		int timer_break = Integer.parseInt(breakStr);

		mgr.updateUserTimerSessionBreak(user_id, timer_session, timer_break);
	}

	// 위치값 들어왔으면 위치 업데이트
	if(user_id != null && timer_loc != null && !timer_loc.equals("")){
		mgr.updateUserTimerLoc(user_id, timer_loc);
	}
%>
