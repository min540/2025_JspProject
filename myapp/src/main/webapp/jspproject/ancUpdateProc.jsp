<!-- .jsp -->
<%@page import="jspproject.AncBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="bean" class="jspproject.AncBean"/>
<jsp:useBean id="amgr" class="jspproject.AncMgr"/>
<%
	//파일 업로드 처리
	String path = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/upload";
	MultipartRequest multi = new MultipartRequest(
		request, path, 30 * 1024 * 1024, "UTF-8" ,new DefaultFileRenamePolicy());
	
	int anc_id = Integer.parseInt(multi.getParameter("anc_id"));
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String img = multi.getFilesystemName("uploadFile");
	//기존 이미지 유지 처리 - 이미지가 널이거나 기존 이미지를 유지해야함
	if(img == null){
		img ="";
	}
	//사용자 등급 확인
	String grade = session.getAttribute("grade").toString();
	//AncBean에 담기
	bean.setAnc_id(anc_id);
	bean.setAnc_title(title);
	bean.setAnc_cnt(content);
	bean.setAnc_img(img);
	//DB 업데이트 호출
	amgr.updateAnc(bean, grade);
	//완료 후 상세보기로 이동
	response.sendRedirect("ancDetail.jsp?anc_id=" + anc_id);
%>