<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="jspproject.TemaMgr" %>
<%@ page import="java.util.Map" %>

<%
    TemaMgr mgr = new TemaMgr();
    Map<String, String> result = mgr.uploadFile(request);

    String tema_img = result.get("tema_img");
    String tema_title = result.get("tema_title");
    String tema_cnt = result.get("tema_cnt");

    String redirectUrl = "Background.jsp?fileName=" + tema_img +
                         "&title=" + URLEncoder.encode(tema_title, "UTF-8") +
                         "&cnt=" + URLEncoder.encode(tema_cnt, "UTF-8");

    response.sendRedirect(redirectUrl);
%>
