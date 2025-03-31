<!-- expression1.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%
String subject[] = { "Java", "JSP", "Flutter", "AI", "Spring" };
%>

<table border="1">
	<tr>
		<th>번호</th>
		<th>과목</th>
	</tr>
	<% for(int i = 0; i < subject.length; i++){%>
	<tr align= "center">
		<td><%=i+1 %></td>
		<td><%=subject[i] %></td>
	</tr>
	<%}%>
</table>

<table border="1">
	<tr>
		<th>번호</th>
		<th>과목</th>
	</tr>
	<% 
			for(int i = 0; i < subject.length; i++){
				out.println("<tr align = 'center'>");
				out.println("<td>" + (i+1) + "</td>");
				out.println("<td>" + subject[i] + "</td>");
				out.println("</tr>");				
			}
	%>
</table>