<!-- simpleBean1.jsp -->
<%@page import="ch09.SimpleBean"%>
<%@page import="ch07.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		//msg와 cnt 받은 매개변수를 SimpleBean 객체를 생성하고 생성된 객체에 저장
		String msg = request.getParameter("msg");
		int cnt = MUtil.parseInt(request, "cnt");
		SimpleBean bean = new SimpleBean();
		bean.setMsg(msg);
		bean.setCnt(cnt);
%>
msg : <%=bean.getMsg() %> <br>
cnt : <%=bean.getCnt() %> <br>