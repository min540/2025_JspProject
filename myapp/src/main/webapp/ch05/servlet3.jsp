<!-- servlet3.jsp -->
<%@page import="ch05.MUtil"%>
<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
		for(int i = 0; i < 10; i++){
			out.println("<font color="+MUtil.randomColor()+">");
			out.println("내일은 즐거운 화요일");
			out.println("</font><br>");
		}
%>