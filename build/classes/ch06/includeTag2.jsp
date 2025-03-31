<!-- includeTag2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String siteName = request.getParameter("siteName");
%>
요청한 사이트명: <%=siteName  %>
<!-- include 액션 태그에 동적으로 매개변수를 넘길 때 사용 -->
<jsp:include page = "includeTagTop2.jsp">
	<jsp:param name="id" value="aaa"/>
	<jsp:param name="pwd" value="bbb"/>
</jsp:include>