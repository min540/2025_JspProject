<!-- teamUpdate.jsp -->
<%@page import="ch09.MUtil"%>
<%@page import="ch09.TeamBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch09.TeamMgr"/>
<%
		int num = 0;
		TeamBean bean = null;
		if(request.getParameter("num")==null){
			// num 값이 넘어오지 않으면 teamList.jsp 리턴
			response.sendRedirect("teamList.jsp");
			return;
		} else if(!MUtil.isNumeric(request.getParameter("num"))){
			//num 값이 넘어왔지만 숫자 형태가 아닌 경우
			response.sendRedirect("teamList.jsp");
			return;
		} else{
			// num 값이 정상적으로 넘어오면 bean 팀 정보 리턴
			num = MUtil.parseInt(request, "num");
			bean = mgr.getTeam(num);
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Mgr</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<h1>Team Update</h1>
<form name="frm" method="post" action="teamUpdateProc.jsp">
<table border="1">
<tr>
	<td width="50" align="center">번호</td>
	<td width="150">
		<!-- readonly: 읽기전용, disabled: 폼데이터 전송 안됨 -->
		<input name="num" value="<%=num%>" readonly>
	</td>
</tr>
<tr>
	<td width="50" align="center">이름</td>
	<td width="150"><input name="name" value="<%=bean.getName()%>"></td>
</tr>
<tr>
	<td align="center">사는곳</td>
	<td><input name="city" value="<%=bean.getCity()%>"></td>
</tr>
<tr>
	<td align="center">나이</td>
	<td ><input name="age" value="<%=bean.getAge()%>"></td>
</tr>
<tr>
	<td align="center">팀명</td>
	<td><input name="team" value="<%=bean.getTeam()%>"></td>
</tr>
<tr>
	<td align="center" colspan="2">
		<input type="submit" value="UPDATE">
	</td>
</tr>
</table>
</form><p>
<a href="teamRead.jsp?num=<%=num%>">READ</a>
</div>
</body>
</html>