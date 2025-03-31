<!-- loginProc.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		boolean result = false;
		if(id!=null && pwd!= null){
			result = true;
		}
		String msg = "로그인에 실패하였습니다";
		String url = "login.jsp";
		if(result){
			msg = "로그인 되었습니다";
			url = "loginOK.jsp";
			// 세션에 idKey라는 키값으로 id를 저장
			session.setAttribute("idKey", id);
		}
		
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>