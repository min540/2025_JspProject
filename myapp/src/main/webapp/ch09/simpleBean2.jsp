<!-- simpleBean2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<!--  SimpleBean bean = new SimpleBean() -->
<jsp:useBean id="bean" class = "ch09.SimpleBean"/>
<!-- String msg = request.getParameter("msg");
		bean.setMsg(msg); -->
<jsp:setProperty property="msg" name="bean"/>
<!-- int cnt = Integer.parseInt(request.getParameter("cnt"));
		bean.setCnt(cnt); -->	
<jsp:setProperty property="cnt" name="bean"/>

<jsp:setProperty property="*" name="bean"/>

<h3>SimpleBean2</h3>
msg : <jsp:getProperty property = "msg" name = "bean"/>
cnt : <jsp:getProperty property = "cnt" name = "bean"/>
