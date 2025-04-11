<%@ page  contentType="text/html; charset=UTF-8"%>
<%@page import="jspproject.UserTimerBean"%>
<%@page import="jspproject.UserTimerMgr"%>
<!-- 
	사용자별 타이머 세션(sessionTime) & 휴식시간(breakTime) & 위치(timerLoc) 정보를 DB에서 가져오는 로직
-->

<%
String user_id = (String)session.getAttribute("user_id");

int sessionTime = 600;  // 기본값 (10분)
int breakTime = 300;    // 기본값 (5분)
String left = "1604";   // 타이머 기본 x좌표
String top  = "99";     // 타이머 기본 y좌표

if(user_id != null){
    UserTimerMgr mgr = new UserTimerMgr();
    UserTimerBean bean = mgr.getUserTimer(user_id);  // 여기서 모든 값 한번에 가져옴

    if(bean != null){
        sessionTime = bean.getTimer_session();
        breakTime = bean.getTimer_break();

        String timerLoc = bean.getTimer_loc();
        if(timerLoc != null && !timerLoc.equals("0,0")){
            String[] loc = timerLoc.split(",");
            left = loc.length > 0 ? loc[0] : "1604";
            top  = loc.length > 1 ? loc[1] : "99";
        }
    }
}
%>
