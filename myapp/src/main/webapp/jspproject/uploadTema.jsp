<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jspproject.TemaMgr" %>
<%@ page import="java.util.Map" %>

<%
    TemaMgr mgr = new TemaMgr();
    Map<String, String> result = mgr.uploadFile(request);

    String tema_img = result.get("tema_img");
    String tema_title = result.get("tema_title");
    String tema_cnt = result.get("tema_cnt");

    // 결과를 간단히 문자열로 응답
    out.print("SUCCESS");
%>
