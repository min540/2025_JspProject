<!-- scopeBean2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		// 세션에 특정한 값만 제거
		session.removeAttribute("sBean");
		// 세션의 무효화, 초기화, 전체제거
		session.invalidate(); //로그아웃 많이 사용
		response.sendRedirect("scopeBean.jsp");
%>