<!-- fdeleteProc.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch13.FileloadMgr"/>
<%
		String snum[] = request.getParameterValues("fch");
		// 문자열 배열을 정수 배열 리턴
		int num[] = new int[snum.length];
		
		for(int i = 0; i < snum.length; i++){
			// out.println(snum[i] +"<br>");
			num[i] = Integer.parseInt(snum[i]);
		}
		mgr.deleteFile(num);
		response.sendRedirect("flist.jsp");
%>