<!-- includeTag3.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String name = "홍길동";
		String bloodType = request.getParameter("bloodType");
%>
<!-- 표현식에 쌍따옴표("") 값이 필요하면 홑따옴표('')으로 시작한다. -->
<jsp:include page='<%=bloodType+".jsp"%>'>
	<jsp:param name="name" value="<%=name%>"/>
</jsp:include>