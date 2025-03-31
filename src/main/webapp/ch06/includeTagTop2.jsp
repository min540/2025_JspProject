<!--  includeTagTop2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
%>
<hr color="red">
id: <%=id %><br>
pwd: <%=pwd %><br>