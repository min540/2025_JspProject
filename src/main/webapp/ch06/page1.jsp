<!-- page1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<% 
		// 세션: Client 정보가 저장되는 객체
		String sessionId = session.getId();
		// 세션 이터벌 시간 세팅
		session.setMaxInactiveInterval(15); //15초
%>

최초 접속 시 제공되는 세션 ID값 : <%=sessionId  %><br>
세션 유지 시간 : <%=session.getMaxInactiveInterval()%>