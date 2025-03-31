<!-- request1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"
				   isErrorPage="true"
%>
<%
		//name, studentNum, gender, major, hobby(배열)
		String name = request.getParameter("name");
		String studentNum = request.getParameter("studentNum");
		String gender = request.getParameter("gender");
		String major = request.getParameter("major");
		String hobby[] = request.getParameterValues("hobby");
%>
name : <%=name %><br>
studentNum : <%=studentNum %><br>
gender : <%=gender %><br>
major : <%=major %><br>
hobby : <%for(int i = 0; i < hobby.length; i++) { %>
				<%=hobby[i] %>&nbsp;
			<%} %>
