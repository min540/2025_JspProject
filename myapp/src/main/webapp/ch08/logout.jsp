<%@page contentType="text/html; charset=UTF-8"%>
<%
		//명시적으로 세션에 저장한 객체를 제거
		session.removeAttribute("idKey");
		//서버에 만들어진 세션 객체를 제거 -> 새로운 세션객체가 생성
		session.invalidate();
		//현재 페이지를 다른 페이지로 응답을 지정
		response.sendRedirect("login.jsp");
%>
