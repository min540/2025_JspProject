<!-- gugudan.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<link href="style.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

<h1 align="center" style="color: #ffffff; font-family: 'Noto Sans KR', sans-serif;">구구단</h1>

<div class="gugu">
	<table border="1">
	<thead>
    	<tr align="center" style="font-family: 'Noto Sans KR', sans-serif;">
        	<% for (int i = 2; i <= 9; i++) { %>
            	<th><%= i %>단</th>
        	<% } %>
    	</tr>
	</thead>
	<tbody>
    	<% for (int j = 1; j <= 9; j++) { %>
        	<tr>
        	<% for (int i = 2; i <= 9; i++) { %>
        		<td align="center"><%= i + "x" + j + "=" + (i * j) %></td>
        	<% } %>
        	</tr>
    	<% } %>
    </tbody>
	</table>
</div>