<!--  for.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String[] fruits = {"사과", "바나나", "포도", "오렌지", "수박"};
%>
<!-- 1.표현식을 사용하여 출력 ul, li-->
<ol>
	<% for(int i = 0; i < fruits.length; i++){%>
	<li><%=fruits[i] %></li>
	<%}%>
</ol><hr color = "red" width = "30%" align="left">

<!-- 2.out.println을 사용하여 출력 -->
<ol>
	<%
		for(int i = 0; i < fruits.length; i++){
			out.println("<li>");
			out.print(fruits[i]);
			out.print("</li>");
		}
	%>
</ol>
