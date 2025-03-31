<!-- include1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ include file="top.jsp"%>
<%
		// String d = "하하";

%>
include 지시자의 body입니다.<br>
<%=d.toLocaleString() %>
<%@ include file="bottom.jsp"%>