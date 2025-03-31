<!-- error.jsp -->
<!-- 다른 페이지에서 예외가 일어났을 때 담당하는 페이지 -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@page isErrorPage = "true" %>
<h3>Error Page</h3>
다음과 같은 예외가 발생하였습니다.<br>
<%=exception.getMessage()%>