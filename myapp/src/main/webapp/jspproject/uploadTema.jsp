<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="jspproject.TemaMgr" %>

<%
    request.setCharacterEncoding("UTF-8");

    String user_id = (String) session.getAttribute("user_id");
    
    // 세션 없을 경우 처리 (예외 방지용)
    if (user_id == null) {
        out.print("{\"status\":\"fail\", \"message\":\"로그인이 필요합니다.\"}");
        return;
    }

    TemaMgr mgr = new TemaMgr();
    Map<String, String> resultMap = mgr.uploadFile(request, user_id);
    
    

    String tema_img = resultMap.get("tema_img");
    String tema_title = resultMap.get("tema_title");
    String tema_cnt = resultMap.get("tema_cnt");

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (tema_img != null) {
        out.print("{");
        out.print("\"status\":\"ok\",");
        out.print("\"tema_img\":\"" + tema_img + "\",");
        out.print("\"tema_title\":\"" + tema_title + "\",");
        out.print("\"tema_cnt\":\"" + tema_cnt + "\"");
        out.print("}");
    } else {
        out.print("{\"status\":\"fail\", \"message\":\"DB 저장 실패\"}");
    }
%>
