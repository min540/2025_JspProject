<%@page import="java.util.Map"%>
<%@ page import="jspproject.TemaMgr" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String user_id = (String) session.getAttribute("id");

    if (user_id == null) {
        out.print("로그인 후 이용해주세요.");
        return;
    }

    TemaMgr mgr = new TemaMgr();
    Map<String, String> map = mgr.uploadFile(request, user_id);  // ✅ user_id 전달

    // 결과 반환
    response.sendRedirect("Background.jsp?fileName=" + map.get("tema_img")
                         + "&title=" + map.get("tema_title")
                         + "&cnt=" + map.get("tema_cnt"));
%>
