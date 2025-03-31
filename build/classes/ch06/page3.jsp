<!-- page3.jsp -->
<!-- 페이지 코드 인코딩과 응답 코드 인코딩 동시에 담당 -->
<%@page  contentType="text/html; charset=UTF-8"%>
<!-- 페이지 코드 인코딩 담당 -->
<%@page pageEncoding="EUC-KR" 
				 isELIgnored="true"
				 trimDirectiveWhitespaces="false"
%>
<%
		String site = "jspstudy.co.kr";
		request.setAttribute("site", site);
%>

사이트명: ${site}