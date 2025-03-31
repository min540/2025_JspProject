<!-- cookCookie.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		// 서버에서 쿠키에 저장될 값을 만든다.
		String cookieName = "myCookie";
		//쿠키를 생성
		Cookie cookie = new Cookie(cookieName, "Apple");
		cookie.setMaxAge(60); //1분
		cookie.setValue("Melon");
		// 생성된 쿠키를 Client 응답객체에 저장
		response.addCookie(cookie);
%>
쿠키를 만들어서 Client로 보냄.<br>
쿠키 내용 확인 <a href="tasteCookie.jsp">여기로~</a>