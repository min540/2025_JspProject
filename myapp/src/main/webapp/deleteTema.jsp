<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jspproject.TemaMgr" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 캐시 방지
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setContentType("application/json; charset=UTF-8");

    String temaIdStr = request.getParameter("tema_id");
    boolean success = false;
    String jsonResponse = "";

    if (temaIdStr != null && !temaIdStr.isEmpty()) {
        try {
            int temaId = Integer.parseInt(temaIdStr);
            TemaMgr mgr = new TemaMgr();
            mgr.deleteTema(temaId);
            success = true;
            jsonResponse = "{\"status\":\"ok\"}";
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse = "{\"status\":\"fail\", \"message\":\"예외 발생: " + e.getMessage() + "\"}";
        }
    } else {
        jsonResponse = "{\"status\":\"fail\", \"message\":\"유효하지 않은 tema_id\"}";
    }

    response.getWriter().write(jsonResponse);
%>
