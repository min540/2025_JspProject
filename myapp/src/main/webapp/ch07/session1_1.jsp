<!-- session1_1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		//세션에서 id값을 리턴
		String id = (String)session.getAttribute("idKey");
		int interlvalTime = session.getMaxInactiveInterval();

		String season = request.getParameter("season");
		String fruit = request.getParameter("fruit");

		if(id!=null){
%>
		<b><%=id %></b>님이 좋아하는 계절과 과일은<p>
		<b><%=season %></b>과 <b><%=fruit %></b>입니다. <p>
		세션 ID : <%=session.getId() %>
		세션 유지 시간 : <%=interlvalTime %>sec

<%
			out.println("세션 유지");
		} else{
			out.println("세션의 시간이 경과를 하였거나 다른 이유로 연결을 지속 할수 없습니다.");
		}
%>
		