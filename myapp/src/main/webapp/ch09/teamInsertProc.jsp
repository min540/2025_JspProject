<!-- teamInsertProc.jsp -->
<%@page import="ch07.MUtil"%>
<%@page import="ch09.TeamBean"%>
<%@page import="ch09.TeamMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		TeamMgr mgr = new TeamMgr();
		TeamBean bean = new TeamBean();
		
		String name = request.getParameter("name");
		String city = request.getParameter("city");
		int age = MUtil.parseInt(request, "age");
		String team = request.getParameter("team");
		
		bean.setName(name);
		bean.setCity(city);
		bean.setAge(age);
		bean.setTeam(team);
		
		// DB 저장
		mgr.insertTeam(bean);		
		// 저장 후에 teamList.jsp 리턴
		response.sendRedirect("teamList.jsp");
		// response.sendRedirect("teamInsert.html");
%>