<%@ page import="jspproject.*" %>
<%@ page import="org.json.JSONObject" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("application/json");

    String user_id = request.getParameter("user_id");
    int mplist_id = Integer.parseInt(request.getParameter("mplist_id"));
    int current_order = Integer.parseInt(request.getParameter("order"));

    MplistMgrMgr mgr = new MplistMgrMgr();
    MplistBgmView prev = mgr.getPrevBgm(user_id, mplist_id, current_order);

    JSONObject json = new JSONObject();
    if (prev != null) {
        json.put("bgm_id", prev.getBgm().getBgm_id());
        json.put("bgm_name", prev.getBgm().getBgm_name());
        json.put("bgm_cnt", prev.getBgm().getBgm_cnt());
        json.put("bgm_music", prev.getBgm().getBgm_music());
        json.put("bgm_image", prev.getBgm().getBgm_image());
        json.put("bgm_order", prev.getBgm_order());
        json.put("mplist_id", prev.getMplist_id());
    }

    response.getWriter().write(json.toString());
%>
