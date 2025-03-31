<!-- memberProc.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="ch14.MemberMgr"/>
<jsp:useBean id="bean" class="ch14.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		boolean result = mgr.insertMember(bean);
		//out.print(result);
		String msg = "가입실패";
		String url = "member.jsp";
		if(result){
			msg = "가입성공";
			url = "login.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>;
</script>
