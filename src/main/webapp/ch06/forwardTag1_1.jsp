<!-- forwardTag1_1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		// forward 액션 태그는 Contrllor 역할
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
%>
id : <%=id %> / pwd : <%=pwd %>
<!-- include와 동일하게 request 정보도 같이 넘어감. -->
<jsp:forward page="forwardTag1_2.jsp"/>