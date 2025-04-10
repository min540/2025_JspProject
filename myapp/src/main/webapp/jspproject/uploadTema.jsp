<%@ page language="java" contentType="application/json; charset=UTF-8"%>
<%@ page import="jspproject.TemaMgr" %>
<%@ page import="java.util.Map" %>

<%
    request.setCharacterEncoding("UTF-8");
    String user_id = (String) session.getAttribute("user_id");

    if (user_id == null || user_id.trim().equals("")) {
        response.setStatus(401);
        out.print("{\"status\": \"fail\", \"message\": \"로그인이 필요합니다.\"}");
        return;
    }

    TemaMgr mgr = new TemaMgr();
    Map<String, String> result = mgr.uploadFile(request, user_id);

    String tema_title = result.get("tema_title");
    String tema_cnt = result.get("tema_cnt");
    String tema_img = result.get("tema_img");

    if (tema_img != null) {
        out.print("{");
        out.print("\"status\": \"ok\",");
        out.print("\"tema_title\": \"" + tema_title + "\",");
        out.print("\"tema_cnt\": \"" + tema_cnt + "\",");
        out.print("\"tema_img\": \"" + tema_img + "\"");
        out.print("}");
    } else {
        response.setStatus(500);
        out.print("{\"status\": \"fail\", \"message\": \"업로드 실패\"}");
    }
%>