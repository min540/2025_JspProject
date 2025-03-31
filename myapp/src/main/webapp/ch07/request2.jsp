<!-- request2.jsp -->
<%@page import="ch07.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String protocol = request.getProtocol();
		int port = request.getServerPort();
		String remoteAddr = request.getRemoteAddr();
		String method = request.getMethod();
		String uri = request.getRequestURI();
		StringBuffer url = request.getRequestURL();
		String query = request.getQueryString();
		// 정수 타입으로 매개변수 변환
		int age= Integer.parseInt(request.getParameter("age"));
		int age2 = MUtil.parseInt(request, "age");
%>
protocol : <%=protocol %><br>
port : <%=port %><br>
remoteAddr : <%=remoteAddr %><br>
method : <%=method %><br>
uri : <%=uri %><br>
url : <%=url %><br>
query : <%=query %><br>
age : <%=age %><br>
age2 : <%=age2 %><br>

