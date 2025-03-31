<!-- includeTag1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String name = request.getParameter("name");
%>
<!-- include 액션 태그 호출 시 request 정보 전달-->
<jsp:include page="includeTagTop1.jsp"/>