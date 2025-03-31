<!-- ch08/login.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
		//로그인 관련은 무조건 session 이용
		String id = (String)session.getAttribute("idKey");
		//out.print(id);
%>
<h3>로그인</h3>
<%if(id!=null){	%>
<!-- 로그인 영역 -->	
<%=id%>님 반갑습니다.
<a href="logout">로그아웃</a>		
<%}else{%>
<!--  로그인 안된 영역 -->	
<form method="post" action="loginServlet">
id : <input name="id"><br/>
pwd : <input type="password" name="pwd"><br/>
<input type="submit" value="로그인">
</form>	
<%}%>
