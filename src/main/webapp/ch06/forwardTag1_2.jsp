<!-- forwardTag1_2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
%>
<!-- 이 페이지가 Client에 response(응답) -->
id : <%=id%><br>
pwd : <%=pwd%><br>