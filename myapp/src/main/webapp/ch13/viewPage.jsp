<!-- viewPage.jsp -->
<%@page import="java.io.File"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
		// 파일 저장 위치
		final String SAVEFOLDER =
		"C:/Jsp/myapp/src/main/webapp/ch13/storage";
		// 파일명 인코딩
		final String ENCODING = "UTF-8";
		// 파일 크기 제한
		final int MAXSIZE = 1024*1024*50; //50mb
		try {
			// request를 매개변수 넘기면 request 안에 아무것도 없다.
			MultipartRequest multi = 
					new MultipartRequest(request, SAVEFOLDER, 
														MAXSIZE, ENCODING,
														new DefaultFileRenamePolicy());
			String user = multi.getParameter("user"); 
			String title = multi.getParameter("title");
			//파일 정보//
			String fileName = multi.getFilesystemName("myfile");
			String fileType = multi.getContentType("myfile");
			File f = multi.getFile("myfile");
			long len = 0;
			if(f.exists()){
				len = f.length();
			}
			out.println("user : " + user + "<br>");
			out.println("title : " + title + "<br>");
			out.println("fileName : " + fileName + "<br>");
			out.println("fileType : " + fileType + "<br>+");
			out.println("len : " + len + "byte<br>");
		} catch(Exception e){
			e.printStackTrace();
		}
%>