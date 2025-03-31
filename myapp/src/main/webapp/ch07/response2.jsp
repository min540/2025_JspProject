<!-- response2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		// 캐시 방지 헤더 설정 (HTTP/1.0, 1.1)
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pagma", "no-cache");
		response.setDateHeader("Expires", 0);
%>
respeonse2.jsp