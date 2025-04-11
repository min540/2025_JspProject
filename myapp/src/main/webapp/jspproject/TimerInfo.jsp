<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.*" %>

<%
request.setCharacterEncoding("UTF-8");

String user_id = (String)session.getAttribute("user_id");

// 미리보기 모드 확인
boolean isPreview = request.getParameter("preview") != null;

if(isPreview) {
  user_id = "PREVIEW_MODE";  // 미리보기 모드일 땐 강제 고정
}

UserTimerMgr mgr = new UserTimerMgr();
UserTimerBean bean = mgr.getUserTimer(user_id);

if(bean == null && !isPreview){
    mgr.insertDefaultUserTimer(user_id);  // 진짜 사용자만 insert
    bean = mgr.getUserTimer(user_id);
}

int sessionTime = (bean != null) ? bean.getTimer_session() : 600;
int breakTime = (bean != null) ? bean.getTimer_break() : 300;
String loc = (bean != null) ? bean.getTimer_loc() : "1693,247";  //DB에 값 없을 때 기본 위치

String[] pos = loc.split(",");
String left = pos[0];
String top = pos[1];

// 미리보기면 style 초기화
String extraStyle = "";
if(isPreview){
  extraStyle = "left:0px; top:0px;";
}
%>
