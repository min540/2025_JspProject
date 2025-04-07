<!-- ancUploadProc.jsp -->
<%@page import="java.io.File"%>
<%@page import="jspproject.AncBean"%>
<%@page import="jspproject.UserBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class ="jspproject.AncMgr"/>
<%

	//파일경로- 경로 바꿔줘야함
	String path = application.getRealPath("/jspproject/upload");
	java.io.File uploadDir = new java.io.File(path);// 없으면 폴더 생성
	if (!uploadDir.exists()) {
    	uploadDir.mkdirs();  
	}
	MultipartRequest multi = new MultipartRequest(
													request, path, 30 * 1024 * 1024, "UTF-8" ,new DefaultFileRenamePolicy());
	
	//파라미터
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String img = multi.getFilesystemName("uploadFile");
	
	//사용자 정보
	UserBean user = (UserBean) session.getAttribute("user");
	if(user == null){
		response.sendRedirect("login.jsp");
		return;
	}

	AncBean bean = new AncBean();
	bean.setUser_id(user.getUser_id());
	bean.setAnc_title(title);
	bean.setAnc_cnt(content);
	bean.setAnc_img(img);
	
	//디비에 넣기
	mgr.insertAnc(bean, String.valueOf(user.getGrade()));
	
	//완료 후 이동
	response.sendRedirect("anc.jsp");
%>