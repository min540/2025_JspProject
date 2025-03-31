<!-- page2.jsp -->
<%@page import="java.util.Date"%>
<%@page import="java.net.*, java.sql.*" %>
<%@page  contentType="text/html; charset=UTF-8"%>
<%
		Date d = new Date();
%>

현재 날짜와 시간은? <%=d.toLocaleString()  %>