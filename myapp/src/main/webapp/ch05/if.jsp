<!-- if.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		//  if.jsp?name=홍길동&color=blue
		// request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String msg = "";
		if(color.equals("blue")){
			msg = "파란색";
		} else if(color.equals("red")){
			msg = "빨간색";
		} else if(color.equals("orange")){
			msg = "오렌지색";
		} else {
			msg = "기타";
			color = "white";
		} 
%>

<body bgcolor = "<%=color %>">
<%=name%>님이 좋아하는 색상은 <%=msg%>입니다.
</body>