<!-- response1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		// 다른 페이지로 응답을 넘기는 기능의  메소드
		response.sendRedirect("response2.jsp");	
%>
<!-- 브라우저 다른 페이지 전환 기능 -->
<script>
	alert("go~");
	location.href = "response2.jsp"
</script>