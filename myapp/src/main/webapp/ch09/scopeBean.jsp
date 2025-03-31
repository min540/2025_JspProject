<!-- scopeBean.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<!-- page는 새로운 요청을 할 때마다 새롭게 생성 
session은 새로운 요청을 할 때마다 session 객체에 있는지 먼저 검색. 있으면 재활용  
session.setAttribute("sBean", sBean)
-->
<jsp:useBean id="pBean" scope="page" class="ch09.ScopeBean"/>
<jsp:useBean id="sBean" scope="session" class="ch09.ScopeBean"/>
<%
		// 세션이 종료되거나 제거를 하지 않는 이상 재사용 가능
		session.setAttribute("sBean", sBean);
%>
<jsp:setProperty property = "num" name = "pBean"
value = "<%=pBean.getNum()+10 %>"/>
<jsp:setProperty property = "num" name = "sBean"
value = "<%=sBean.getNum()+10 %>"/>

<h3>Scope Bean</h3>
pBean num값 : <jsp:getProperty property = "num" name = "pBean"/><br>
sBean num값 : <jsp:getProperty property = "num" name = "sBean"/><br>
<a href="scopeBean2.jsp">세션종료</a>